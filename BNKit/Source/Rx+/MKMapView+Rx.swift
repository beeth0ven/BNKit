//
//  MKMapView+Rx.swift
//  WorkMap
//
//  Created by luojie on 16/10/9.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

public class RxMKMapViewDelegateProxy: DelegateProxy, MKMapViewDelegate, DelegateProxyType {

    typealias HasDelegate = MKMapView
    typealias Delegate = MKMapViewDelegate
    
    public static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        let hasDelegate = object as! HasDelegate
        return hasDelegate.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        let hasDelegate = object as! HasDelegate
        hasDelegate.delegate = delegate as? Delegate
    }
}

extension Reactive where Base: MKMapView {
    
    public var delegate: DelegateProxy {
        return RxMKMapViewDelegateProxy.proxyForObject(base)
    }
    
    public var regionDidChangeAnimated: Observable<Bool> {
        return delegate.methodInvoked(#selector(MKMapViewDelegate.mapView(_:regionDidChangeAnimated:)))
            .map { params in params.last as! Bool }
    }
    
    public var centerDidChange: Observable<CLLocationCoordinate2D> {
        return delegate.methodInvoked(#selector(MKMapViewDelegate.mapView(_:regionDidChangeAnimated:)))
            .map { _ in self.base.centerCoordinate }
    }
    
    public var didUpdateUserLocation: Observable<MKUserLocation> {
        return delegate.methodInvoked(#selector(MKMapViewDelegate.mapView(_:didUpdate:)))
            .map { params in params.last as! MKUserLocation }
    }
    
}


