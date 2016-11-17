//
//  CLLocationCoordinate2D+.swift
//  BNKit
//
//  Created by luojie on 2016/11/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {
    
    public var toMap: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: latitude  - 0.002435,
            longitude: longitude  + 0.00543
        )
    }
    
    public var toLocation: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: latitude  + 0.002435,
            longitude: longitude  - 0.00543
        )
    }
    
    public func distanceFromCoordinate(coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let location1 = CLLocation(coordinate: self)
        let location2 = CLLocation(coordinate: coordinate)
        return location1.distance(from: location2)
    }
}
