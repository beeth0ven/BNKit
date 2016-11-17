//
//  PlaceholderTextView.swift
//  SelfSizeTextView
//
//  Created by luojie on 16/5/12.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

open class PlaceholderTextView: UITextView {
    
    @IBInspectable
    open var placeholder: NSString? {
        didSet { setNeedsDisplay()
        }
    }
    
    @IBInspectable
    open var placeholderColor: UIColor = .lightGray {
        didSet { setNeedsDisplay() }
    }
    
    override open var text: String! {
        didSet { setNeedsDisplay() }
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    fileprivate func setup() {
        observe(forNotification: .UITextViewTextDidChange, sender: self) { [unowned self] _ in
            self.setNeedsDisplay()
        }
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let placeholder = placeholder, text.isEmpty else { return }
        
        var placeholderAttributes = [String: AnyObject]()
        placeholderAttributes[NSFontAttributeName] = font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        placeholderAttributes[NSForegroundColorAttributeName] = placeholderColor
        
        let placeholderRect = rect.insetBy(
            dx: contentInset.left + textContainerInset.left + textContainer.lineFragmentPadding,
            dy: contentInset.top + textContainerInset.top
        )
        placeholder.draw(in: placeholderRect, withAttributes: placeholderAttributes)
    }
}
