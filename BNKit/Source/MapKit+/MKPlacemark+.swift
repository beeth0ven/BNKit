//
//  MKPlacemark+.swift
//  BNKit
//
//  Created by luojie on 2016/11/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import MapKit
import Contacts

extension MKPlacemark {
    public convenience init(coordinate: CLLocationCoordinate2D, addressName: String?) {
        let addressDictionary = addressName.flatMap { [CNPostalAddressStreetKey: $0] }
        self.init(coordinate: coordinate, addressDictionary: addressDictionary)
    }
}
