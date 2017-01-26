//
//  Storyboard+IsInStoryboard.swift
//  theatre
//
//  Created by luojie on 2016/12/29.
//  Copyright © 2016年 luojie. All rights reserved.
//

import UIKit

public protocol IsInStoryboard: IsInBundle {
    static var staticStoryboard: UIStoryboard { get }
}

public extension IsInStoryboard where Self: UIViewController {
    
    static func fromStoryboard() -> Self {
        return staticStoryboard.instantiateViewController(withIdentifier: "\(self)") as! Self
    }
}


public extension UIViewController {
    
    @discardableResult
    func showDetail<VC>(_ vcType: VC.Type, configure: ((VC) -> Void) = { _ in }) -> VC where VC: IsInStoryboard, VC: UIViewController {
        return show(VC.self, kind: .showDetail, configure: configure)
    }
    
    @discardableResult
    func present<VC>(_ vcType: VC.Type, configure: ((VC) -> Void) = { _ in }) -> VC where VC: IsInStoryboard, VC: UIViewController {
        return show(VC.self, kind: .present, configure: configure)
    }
    
    @discardableResult
    func show<VC>(_ vcType: VC.Type, configure: ((VC) -> Void) = { _ in }) -> VC where VC: IsInStoryboard, VC: UIViewController {
        return show(VC.self, kind: .show, configure: configure)
    }
    
    private func show<VC>(_ vcType: VC.Type, kind: ShowKind, configure: ((VC) -> Void) = { _ in }) -> VC where VC: IsInStoryboard, VC: UIViewController {
        let vc = VC.fromStoryboard()
        configure(vc)
        switch kind {
        case .show:
            show(vc, sender: nil)
        case .present:
            present(vc, animated: true, completion: nil)
        case .showDetail:
            showDetailViewController(vc, sender: nil)
        }
        return vc
    }
    
    private enum ShowKind {
        case show
        case present
        case showDetail
    }
}

