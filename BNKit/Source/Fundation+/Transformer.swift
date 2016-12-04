//
//  Transformer.swift
//  BNKit
//
//  Created by luojie on 2016/12/4.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

public struct Transformer<S, D> {
    public let mapSource: (S) -> D
    public let mapDestination: (D) -> S
    
    public init(mapSource: @escaping (S) -> D, mapDestination: @escaping (D) -> S) {
        self.mapSource = mapSource
        self.mapDestination = mapDestination
    }
}

public struct ValueTransformer<S, D> {
    public let mapSource: (S) -> D?
    public let mapDestination: (D) -> S?
    
    public init(mapSource: @escaping (S) -> D?, mapDestination: @escaping (D) -> S?) {
        self.mapSource = mapSource
        self.mapDestination = mapDestination
    }
}

extension ValueTransformer {
    
    public func reversed() -> ValueTransformer<D, S> {
        return ValueTransformer<D, S>(
            mapSource: mapDestination,
            mapDestination: mapSource
        )
    }
}

extension Transformer {
    
    public func reversed() -> Transformer<D, S> {
        return Transformer<D, S>(
            mapSource: mapDestination,
            mapDestination: mapSource
        )
    }
}
