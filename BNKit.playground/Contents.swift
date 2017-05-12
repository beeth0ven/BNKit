/*:
 # BNKit
 Use this playground to try out BNKit
 */
import PlaygroundSupport
import BNKit
import RxSwift
import RxCocoa
import UIKit
import Action


PlaygroundPage.current.needsIndefiniteExecution = true

public struct ItemsViewModel<Item, ReloadInput, ReloadOutput> {
    
    // Output
    
    public let items: Observable<[Item]>
    public let errors: Observable<ActionError>
    public let isEmpty: Observable<Bool>
    public let executing: Observable<Bool>
    
    private let disposeBag = DisposeBag()

    // Input
    
    public init(
        reloadTrigger: Observable<Void>,
        toInput: @escaping (Void) -> ReloadInput,
        toOutput: @escaping (ReloadInput) -> Observable<ReloadOutput>,
        toItems: @escaping (ReloadOutput) -> [Item]
        ) {
        
        // Input -> Output
        
        let reloadAction = Action(workFactory: toOutput)
        self.items = Observable.merge(
            reloadAction.executing.filter { $0 }.map { _ in [] },
            reloadAction.elements.map(toItems)
        )
        self.errors = reloadAction.errors
        self.isEmpty = Observable.merge(
            reloadAction.executing.filter { $0 }.map { _ in false },
            reloadAction.elements.map(toItems).map { $0.isEmpty }
        )
        self.executing = reloadAction.executing
        
        reloadTrigger
            .map(toInput)
            .bind(to: reloadAction.inputs)
            .disposed(by: disposeBag)
    }
}

let viewModel = ItemsViewModel(
    reloadTrigger: .just(),
    toInput: { 1 },
    toOutput: { input -> Observable<(Int, [String])> in .just((input, [])) },
    toItems: { output in output.1 }
)

struct PageItemsViewModel<Item, ReloadInput, ReloadOutput, NextPageInput, NextPageOutput, Cursor> {
    // Output
    
    public let items: Observable<[Item]>
    public let reloadErrors: Observable<ActionError>
    public let loadNextPageErrors: Observable<ActionError>
    public let isEmpty: Observable<Bool>
    public let reloadExecuting: Observable<Bool>
    public let loadNextPageExecuting: Observable<Bool>
    public let hasNextPage: Observable<Bool>
    
    private let disposeBag = DisposeBag()
    private typealias UpdateItems = (inout [Item]) -> Void
    private typealias UpdateCusor = (Cursor?) -> Cursor?

    // Input

    public init(
        reloadTrigger: Observable<Void>,
        toReloadInput: @escaping (Void) -> ReloadInput,
        toReloadOutput: @escaping (ReloadInput) -> Observable<ReloadOutput>,
        toReloadItems: @escaping (ReloadOutput) -> [Item],
        toReloadCursor: @escaping ((Cursor?, ReloadOutput) -> Cursor?),
        loadNextPageTrigger: Observable<Void>,
        toLoadNextPageInput: @escaping (Cursor) -> NextPageInput,
        toLoadNextPageOutput: @escaping (NextPageInput) -> Observable<NextPageOutput>,
        toLoadNextPageItems: @escaping (NextPageOutput) -> [Item],
        toLoadNextPageCursor: @escaping ((Cursor?, NextPageOutput) -> Cursor?)
        ) {
        
        // Input -> Output
        
        let reloadAction = Action(workFactory: toReloadOutput)
        let loadNextPageAction = Action(workFactory: toLoadNextPageOutput)
        
        self.reloadErrors = reloadAction.errors
        self.loadNextPageErrors = loadNextPageAction.errors
        
        let updateItems: Observable<UpdateItems> = Observable.merge(
            reloadAction.executing.filter { $0 }.map { _ in { $0 = [] } },
            reloadAction.elements.map(toReloadItems).map { items in { $0 = items } },
            loadNextPageAction.elements.map(toLoadNextPageItems).map { items -> UpdateItems in { $0 += items } }
            )
            
        self.items = updateItems.scan([]) { (items, updateItem) in
            var items = items
            updateItem(&items)
            return items;
        }
        
        self.isEmpty = Observable.merge(
            reloadAction.executing.filter { $0 }.map { _ in false },
            reloadAction.elements.map(toReloadItems).map { $0.isEmpty }
        )
        
        self.reloadExecuting = reloadAction.executing
        self.loadNextPageExecuting = loadNextPageAction.executing

        let updateCusor: Observable<UpdateCusor> = Observable.merge(
            reloadAction.elements.map { output -> UpdateCusor in { oldCusor in toReloadCursor(oldCusor, output) } },
            loadNextPageAction.elements.map { output -> UpdateCusor in { oldCusor in toLoadNextPageCursor(oldCusor, output) } }
        )
        
        let cursor: Observable<Cursor?> = updateCusor.scan(nil) { (oldCursor, updateCusor) in
            updateCusor(oldCursor)
        }
        
        self.hasNextPage = cursor.map { $0 != nil }
        
        reloadTrigger
            .map(toReloadInput)
            .bind(to: reloadAction.inputs)
            .disposed(by: disposeBag)
        
        loadNextPageTrigger
            .withLatestFrom(cursor)
            .filterNil()
            .map(toLoadNextPageInput)
            .bind(to: loadNextPageAction.inputs)
            .disposed(by: disposeBag)
    }

}

let pageViewModel = PageItemsViewModel(
    reloadTrigger: .just(),
    toReloadInput: { () -> String in "1" },
    toReloadOutput: { input -> Observable<(Bool, [String])> in .just((true, [])) },
    toReloadItems: { output -> [String] in output.1 },
    toReloadCursor: { (oldPage, output) -> Int? in output.0 ? (oldPage ?? 1) + 1 : nil },
    loadNextPageTrigger: .just(),
    toLoadNextPageInput: { page in (page, "") },
    toLoadNextPageOutput: { input -> Observable<(Bool, [String])> in .just((true, [])) },
    toLoadNextPageItems: { output in output.1 },
    toLoadNextPageCursor: { (oldPage, output) in output.0 ? (oldPage ?? 1) + 1 : nil }
)

let items = pageViewModel.items
let i = viewModel.items