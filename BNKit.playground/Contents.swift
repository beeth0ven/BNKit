/*:
 # BNKit
 Use this playground to try out BNKit
 */
import BNKit
import RxSwift
import RxCocoa
import UIKit

playgroundShouldContinueIndefinitely()

Observable<TimeInterval>.timer(duration: 5, interval: 1)
    .debug("timer")
    .subscribe()
