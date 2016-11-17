//
//  CoreGraphics+.swift
//  PhotoMap
//
//  Created by luojie on 16/8/10.
//
//

import CoreGraphics

extension CGSize {
    
    public static var thumbnailImageSize: CGSize {
        
        return CGSize(width: 128, height: 128)
    }
    
    public static var profileImagelSize: CGSize {
        
        return CGSize(width: 384, height: 384)
    }
}

extension CGRect {
    
    public init(center: CGPoint, size: CGSize) {
        self.init(origin: .zero, size: size)
        self.center = center
    }
    
    public var center: CGPoint {
        get { return CGPoint(x: self.midX, y: self.midY) }
        set {
            origin.x = newValue.x - size.width/2
            origin.y = newValue.y - size.height/2
        }
    }
}

public func *(size: CGSize, scale: CGFloat) -> CGSize {
    return CGSize(width: size.width * scale, height: size.height * scale)
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func += (left: inout CGPoint, right: CGPoint) {
    left = left + right
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func -= (left: inout CGPoint, right: CGPoint) {
    left = left - right
}

public func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

public func *= (left: inout CGPoint, right: CGPoint) {
    left = left * right
}

public func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

public func *= (point: inout CGPoint, scalar: CGFloat) {
    point = point * scalar
}

public func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

public func /= (left: inout CGPoint, right: CGPoint) {
    left = left / right
}

public func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

public func /= (point: inout CGPoint, scalar: CGFloat) {
    point = point / scalar
}

extension CGFloat {
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UInt32.max))
    }
    
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(min < max)
        return CGFloat.random() * (max - min) + min
    }
}
