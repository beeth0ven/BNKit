/*:
 # BNKit
 Use this playground to try out BNKit
 */
import PlaygroundSupport
import BNKit
import RxSwift
import RxCocoa
import UIKit

PlaygroundPage.current.needsIndefiniteExecution = true

let viewModel = ItemsViewModel(
    getParam: { 1 },
    mapToResponse: { param -> Observable<(Int, [String])> in .just((param, [])) },
    mapToItems: { response in response.1 }
)

viewModel

func apiCall(page: Int) -> Observable<(page: Int?, items: [String])> {
    return .empty()
}

let pageViewModel = PaginationViewModel(
    getReloadParam: { 0 },
    mapToReloadResponse: apiCall,
    mapToReloadCursor: { $0.page },
    mapToReloadItems: { $0.items },
    getNextPageParam: { $0 },
    mapToNextPageResponse: apiCall,
    mapToNextPageCursor: { $0.page },
    mapToNextPageItems: { $0.items }
)

pageViewModel

viewModel


