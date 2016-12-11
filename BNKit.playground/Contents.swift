/*:
 # BNKit
 Use this playground to try out BNKit
 */
import BNKit
import RxSwift
import RxCocoa
import UIKit

// Filter -> SearchResult -> [Section] -> CellStyle -> Cell
// Filter -async-> SearchResult -sync-> [Section] -sync-> CellStyle -sync-> Cell
// Filter -> Observable<SearchResult> -> [Section] -> CellStyle -> Cell