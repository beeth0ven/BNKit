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

Observable<TimeInterval>.timer(duration: 5, interval: 1)
    .debug("timer")
    .subscribe()
