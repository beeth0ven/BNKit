/*:
 # BNKit
 Use this playground to try out BNKit
 */
import BNKit
import RxSwift
import RxCocoa


let a = 1

Observable<TimeInterval>.timer(duration: 5)
    .subscribe(
        onNext: { remain in
            print("剩余：", remain)
    },
        onCompleted: {
            print("计时结束！")
    }
)