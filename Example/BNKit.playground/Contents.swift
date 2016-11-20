/*:
 # BNKit
 Use this playground to try out BNKit
 */
import BNKit
import RxSwift

(0..<1.0).random()

let disposeBag = DisposeBag()

Observable.just(1)
    .debug()
    .subscribe()
    .addDisposableTo(disposeBag)