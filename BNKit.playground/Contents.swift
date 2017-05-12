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

protocol IsPageResultViewModel {
    associatedtype Item
    associatedtype Cursor
    associatedtype ReloadInput
    associatedtype ReloadOutput
    associatedtype NextPageInput
    associatedtype NextPageOutput
    typealias UpdateItems = (inout [Item]) -> Void

    var reloadTrigger: PublishSubject<Void> { get }
    var loadNextPageTrigger: PublishSubject<Void> { get }
    
    var reloadAction: Action<ReloadInput, ReloadOutput>! { get }
    var loadNextPageAction: Action<NextPageInput, NextPageOutput>! { get }

    var items: Observable<[Item]>! { get }
    var cursor: Observable<Cursor?>! { get }
    var executing: Observable<Bool>! { get }
    var isEmpty: Observable<Bool>!{ get }
    
    var updateItems: PublishSubject<UpdateItems> { get }
    
    func createReloadAction() -> Action<ReloadInput, ReloadOutput>
    func createLoadNextPageAction() -> Action<NextPageInput, NextPageOutput>
    func createCursor() -> Observable<Cursor?>

}

extension IsPageResultViewModel {
    
    func createItems() -> Observable<[Item]> {
        return updateItems.scan([]) { (items, updateItem) in
            var items = items
            updateItem(&items)
            return items;
            }
            .observeOnMainScheduler()
            .shareReplay(1)
    }
    
    func createExecuting() -> Observable<Bool> {
        return Observable.combineLatest(
            reloadAction.executing.startWith(false),
            loadNextPageAction.executing.startWith(false)
        ) { $0 || $1 }
            .observeOnMainScheduler()
            .shareReplay(1)
    }
    
    func createIsEmpty() -> Observable<Bool> {
        let isEmpty = items
            .debounce(0.1, scheduler: MainScheduler.asyncInstance)
            .withLatestFrom(cursor, executing) { (items, cursor, executing) in
                items.isEmpty && cursor == nil && !executing
            }
        
        return Observable.merge(
            reloadAction.executing.filter { $0 }.map { _ in false },
            isEmpty
            )
            .observeOnMainScheduler()
            .shareReplay(1)
    }
}

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
    toOutput: { input in Observable<(Int, [String])>.just((input, [])) },
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

struct PageResultViewModel: IsPageResultViewModel {
    
    typealias Item = String
    typealias Cursor = Int
    typealias ReloadInput = Int
    typealias ReloadOutput = (items: [Item], cursor: Cursor?)
    typealias NextPageInput = Cursor
    typealias NextPageOutput = (items: [Item], cursor: Cursor?)
    
    let reloadTrigger = PublishSubject<Void>()
    let loadNextPageTrigger = PublishSubject<Void>()
    let updateItems = PublishSubject<UpdateItems>()

    private(set) var reloadAction: Action<ReloadInput, ReloadOutput>!
    private(set) var loadNextPageAction: Action<NextPageInput, NextPageOutput>!
    
    private(set) var items: Observable<[Item]>!
    private(set) var cursor: Observable<Cursor?>!
    private(set) var executing: Observable<Bool>!
    private(set) var isEmpty: Observable<Bool>!
    
    private let disposeBag = DisposeBag()
    
    init() {
        setup()
        setupAction()
    }
    
    private mutating func setup() {
        reloadAction = createReloadAction()
        loadNextPageAction = createLoadNextPageAction()
        items = createItems()
        cursor = createCursor()
        executing = createExecuting()
        isEmpty = createIsEmpty()
    }
    
    private func setupAction() {
        
        let params = 1
        
        reloadTrigger
            .withLatestFrom(executing)
            .filter { !$0 }
            .map { _ in params } // Need change
            .bind(to: reloadAction.inputs)
            .disposed(by: disposeBag)
        
        loadNextPageTrigger
            .withLatestFrom(executing)
            .filter { !$0 }
            .withLatestFrom(cursor)
            .filterNil()
            .map { _ in params } // Need change
            .bind(to: loadNextPageAction.inputs)
            .addDisposableTo(disposeBag)
        
        Observable.merge(
            reloadAction.elements.map { output -> UpdateItems in { $0 = output.items } },
            loadNextPageAction.elements.map { output -> UpdateItems in { $0 += output.items } }
            )
            .bind(to: updateItems)
            .disposed(by: disposeBag)
    }
    
    func createReloadAction() -> Action<ReloadInput, (items: [Item], cursor: Cursor?)> {
        return Action { _ in .empty() }
    }
    
    func createLoadNextPageAction() -> Action<Cursor, (items: [Item], cursor: Cursor?)> {
        return Action { _ in .empty() }
    }
    
    func createCursor() -> Observable<Cursor?> {
        return Observable.merge(
            reloadAction.executing.filter { $0 }.map { _ in false },
            reloadAction.elements.map { $0.cursor != nil },
            loadNextPageAction.elements.map { $0.cursor != nil }
            )
            .scan(nil) { (oldPage, hasNextPage) in
                hasNextPage ? (oldPage ?? 1) + 1 : nil
            }
            .observeOnMainScheduler()
            .shareReplay(1)
    }
}

