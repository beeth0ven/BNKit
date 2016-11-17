//
//  TipView.swift
//  WorkMap
//
//  Created by luojie on 16/10/22.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

open class TipView: UIView {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var textLabel: UILabel!
    
    let state = Variable(State.spinnerOnly)
    let delayDismiss = Variable<Double?>(nil)
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        state.asDriver()
            .drive(stateOberver)
            .addDisposableTo(disposeBag)
        
        delayDismiss.asObservable()
            .flatMapLatest { delay -> Observable<Void> in
                switch delay {
                case nil:
                    return .empty()
                case let delay?:
                    return Observable<Int64>.interval(delay, scheduler: MainScheduler.instance)
                        .take(1)
                        .map { _ in }
                }
            }
            .bindTo(rx_remove)
            .addDisposableTo(disposeBag)
        
    }
    
    private var stateOberver: AnyObserver<State> {
        return UIBindingObserver(UIElement: self){ (tipView, state) in
            switch state {
            case .spinnerOnly:
                tipView.spinner.isShowed = true
                tipView.textLabel.isShowed = false
            case .spinnerWithText(let text):
                tipView.spinner.isShowed = true
                tipView.textLabel.isShowed = true
                tipView.textLabel.text = text
            case .textOnly(let text):
                tipView.spinner.isShowed = false
                tipView.textLabel.isShowed = true
                tipView.textLabel.text = text
            }
            }.asObserver()
    }
    
    private var rx_remove: AnyObserver<Void> {
        return UIBindingObserver(UIElement: self, binding: { (view, _) in
            view.superview?.isUserInteractionEnabled = true
            view.superview?.animateUpdate { view.removeFromSuperview() }
        }).asObserver()
    }
    
    public enum State {
        case spinnerOnly
        case spinnerWithText(String)
        case textOnly(String)
    }
}

extension TipView {
    
    public static func show(state: State, delayDismiss: TimeInterval? = nil, in view: UIView = UIApplication.shared.keyWindow!) {
        shared.state.value = state
        shared.delayDismiss.value = delayDismiss
        shared.translatesAutoresizingMaskIntoConstraints = false
        view.animateUpdate {
            view.isUserInteractionEnabled = false
            view.addSubview(shared)
            view.addConstraints([
                shared.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                shared.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                ])
        }
    }
    
    public static func update(state: State, delayDismiss: TimeInterval? = 2) {
        shared.state.value = state
        shared.delayDismiss.value = delayDismiss
    }
    
    public static func remove() {
        shared.superview?.animateUpdate { shared.removeFromSuperview() }
    }
    
    @nonobjc static let shared = TipView.fromNib(bundle: .BNKit)!
}
