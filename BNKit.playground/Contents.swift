/*:
 # BNKit
 Use this playground to try out BNKit
 */
import BNKit
import RxSwift
import RxCocoa

//infix operator --> : DefaultPrecedence
//
//class Button: UIButton {
//    
//    override func awakeFromNib() {
//        
//        Observable.just(true) --> (self, { (button, isEnable) in button.isEnable = isEnable })
//    }
//    
//}
//
//
//
//func --><E,B>(observable: Observable<E>, params: (base: B, setter: (B, E) -> Void))
//    where B: HasDisposeBag, B: AnyObject
//{
//    let observer = UIBindingObserver(UIElement: params.base, binding: params.setter)
//    observable
//        .debug("bindTo")
//        .bindTo(observer)
//        .addDisposableTo(params.base.disposeBag)
//}
//
//let button = Button(type: .contactAdd)
//let a = 1
