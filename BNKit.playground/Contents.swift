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

enum MyError: Error {
    case unknown
}

Observable<TimeInterval>.timer(duration: 5, interval: 1)
    .map { _ -> String in throw MyError.unknown }
    .debug("timer")
    .subscribe()
