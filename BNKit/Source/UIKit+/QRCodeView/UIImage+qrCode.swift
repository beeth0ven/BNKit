//
//  UIImage+qrCode.swift
//  QRCode
//
//  Created by luojie on 16/10/24.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

extension UIImage {
    
    public static func qrCode(from text: String, length: CGFloat = 200, tintColor: UIColor? = nil) -> UIImage {
        let data = text.data(using: .isoLatin1)!
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")!
        qrFilter.setDefaults()
        qrFilter.setValue(data, forKey: "inputMessage")
        qrFilter.setValue("H", forKey: "inputCorrectionLevel")
        var ciImage = qrFilter.outputImage!
        
        if let tintColor = tintColor {
            let colorFilter = CIFilter(name: "CIFalseColor", withInputParameters: [
                "inputImage": ciImage,
                "inputColor0": tintColor.ciColor,
                "inputColor1": UIColor.white.ciColor
                ])!
            ciImage = colorFilter.outputImage!
        }
        
        let scaleX = length / ciImage.extent.size.width
        let scaleY = length / ciImage.extent.size.height
        let transformedImage = ciImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        return UIImage(ciImage: transformedImage)
    }
}
