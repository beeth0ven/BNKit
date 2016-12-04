//
//  Transformers.swift
//  BNKit
//
//  Created by luojie on 2016/12/4.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

public enum Transformers {}
public enum ValueTransformers {}

extension ValueTransformers {
    
    public static let stringAndInt = ValueTransformer<String, Int>(
        mapSource: { Int.init($0) },
        mapDestination: { NumberFormatter().string(from: $0 as NSNumber) }
    )
    
    public static let stringAndFloat = ValueTransformer<String, Float>(
        mapSource: { Float.init($0) },
        mapDestination: { NumberFormatter().string(from: $0 as NSNumber) }
    )
    
    public static let stringAndDouble = ValueTransformer<String, Double>(
        mapSource: { Double.init($0) },
        mapDestination: { NumberFormatter().string(from: $0 as NSNumber) }
    )
    
    public static let stringAndCGFloat = ValueTransformer<String, CGFloat>(
        mapSource: { Double.init($0).flatMap { CGFloat.init($0) } },
        mapDestination: { NumberFormatter().string(from: $0 as NSNumber) }
    )
    
}

extension Transformers {
    
    public static let intAndFloat = Transformer<Int, Float>(
        mapSource: { Float.init($0) },
        mapDestination: { Int.init($0) }
    )
    
    public static let intAndDouble = Transformer<Int, Double>(
        mapSource: { Double.init($0) },
        mapDestination: { Int.init($0) }
    )
    
    public static let intAndCGFloat = Transformer<Int, CGFloat>(
        mapSource: { CGFloat.init($0) },
        mapDestination: { Int.init($0) }
    )
    
    public static let floatAndDouble = Transformer<Float, Double>(
        mapSource: { Double.init($0) },
        mapDestination: { Float.init($0) }
    )
    
    public static let floatAndCGFloat = Transformer<Float, CGFloat>(
        mapSource: { CGFloat.init($0) },
        mapDestination: { Float.init($0) }
    )
    
    public static let doubleAndCGFloat = Transformer<Double, CGFloat>(
        mapSource: { CGFloat.init($0) },
        mapDestination: { Double.init($0) }
    )
}
