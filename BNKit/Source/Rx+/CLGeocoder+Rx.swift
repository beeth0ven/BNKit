//
//  CLGeocoder+Rx.swift
//  BNKit
//
//  Created by luojie on 2016/11/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MapKit

extension CLGeocoder {
    
    public static func rx_getPlacemarks(from coordinate: CLLocationCoordinate2D) -> Observable<[CLPlacemark]> {
        
        return Observable.create({ observer -> Disposable in
            
            let geocoder = CLGeocoder()
            let location = CLLocation(coordinate: coordinate)
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                switch (placemarks, error) {
                case let (_, error?):
                    observer.onError(error)
                case let (placemarks?, _):
                    observer.onNext(placemarks)
                    observer.onCompleted()
                default: fatalError()
                }
            }
            
            return Disposables.create()
            
        }).asObservable()
        
    }
}

