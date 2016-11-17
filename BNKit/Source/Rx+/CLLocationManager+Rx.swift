//
//  CLLocationManager+Rx.swift
//  WorkMap
//
//  Created by luojie on 16/10/10.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

public class RxLocationManagerDelegateProxy: DelegateProxy, DelegateProxyType, CLLocationManagerDelegate {
    
    typealias HasDelegate = CLLocationManager
    typealias Delegate = CLLocationManagerDelegate
    
    public static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        let hasDelegate = object as! HasDelegate
        return hasDelegate.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        let hasDelegate = object as! HasDelegate
        hasDelegate.delegate = delegate as? Delegate
    }
}

extension Reactive where Base: CLLocationManager {
    
    public var delegate: DelegateProxy {
        return RxLocationManagerDelegateProxy.proxyForObject(base)
    }
    
    public var didUpdateLocations: Observable<[CLLocation]> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:)))
            .map { params in params[1] as! [CLLocation] }
    }
    
    public var didChangeAuthorizationStatus: Observable<CLAuthorizationStatus> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didChangeAuthorization:)))
            .map { params in CLAuthorizationStatus(rawValue: (params[1] as! NSNumber).int32Value)! }
    }
    
    
    public var didAuthorize: Observable<Void> {
        
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        case .restricted:
            let alert = UIAlertController(title: "Work Map", message: "Location service is restricted!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
        case .denied:
            let alert = UIAlertController(title: "Work Map", message: "Location service is denied!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Authorize", style: .default, handler: { _ in UIApplication.shared.openSettings() }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
        case .notDetermined:
            self.base.requestWhenInUseAuthorization()
        }
        
        return didChangeAuthorizationStatus
            .startWith(status)
            .filter { $0 == .authorizedAlways || $0 == .authorizedWhenInUse }
            .map { _ in }
        
    }
    
}
