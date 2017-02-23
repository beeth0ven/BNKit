//
//  Storyboard+IsInStoryboard.swift
//  theatre
//
//  Created by luojie on 2016/12/29.
//  Copyright © 2016年 luojie. All rights reserved.
//

import UIKit


/**
 A easy and safe way to initail controller from the storyboard
 
 # Usage Exampe #
 ```swift
 // 1. Declare a new storyboard
 protocol IsInMainStoryboard: IsInStoryboard {}
 extension IsInMainStoryboard {
     static var storyboardName: String { return "Main" }
 }

 // 2. Declare controller in the storyboard
 class TheatreBaseNavViewController: UINavigationController, IsInMainStoryboard {}
 class CustomBaseNavViewController: UINavigationController, IsInMainStoryboard {}
 class MeBaseNavViewController: UINavigationController, IsInMainStoryboard {}

 // 3. Just initail controller from the storyboard
 class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav1 = TheatreBaseNavViewController.fromStoryboard()
        let nav2 = CustomBaseNavViewController.fromStoryboard()
        let nav3 = MeBaseNavViewController.fromStoryboard()
        
        setViewControllers([nav1,nav2,nav3], animated: true)
    }
    
 }
 
 ```
 */

public protocol IsInStoryboard: IsInBundle {
    static var storyboardName: String { get }
}

public extension IsInStoryboard where Self: UIViewController {
    
    static func fromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: "\(self)") as! Self
    }
}


public extension UIViewController {
    
    @discardableResult
    public func showDetail<VC>(_ vcType: VC.Type, configure: ((VC) -> Void) = { _ in }) -> VC where VC: IsInStoryboard, VC: UIViewController {
        return show(VC.self, kind: .showDetail, configure: configure)
    }
    
    @discardableResult
    public func present<VC>(_ vcType: VC.Type, configure: ((VC) -> Void) = { _ in }) -> VC where VC: IsInStoryboard, VC: UIViewController {
        return show(VC.self, kind: .present, configure: configure)
    }
    
    @discardableResult
    public func show<VC>(_ vcType: VC.Type, configure: ((VC) -> Void) = { _ in }) -> VC where VC: IsInStoryboard, VC: UIViewController {
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

