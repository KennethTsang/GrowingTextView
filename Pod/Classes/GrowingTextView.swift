//
//  GrowingTextView.swift
//  Pods
//
//  Created by Kenneth on 17/2/2016.
//
//

import Foundation
import UIKit

@objc public protocol GrowingTextViewDelegate: UITextViewDelegate {
    optional func textViewDidChangeHeight(height: CGFloat)
}

@objc public class GrowingTextView: UITextView {
    
    // Maximum length of text. 0 means no limit.
    public var maxLength = 0
    
    // Trim white space and newline characters when end editing. Default is true
    public var trimWhiteSpaceWhenEndEditing = true
    
    // Placeholder properties
    // Need to set both placeHolder and placeHolderColor in order to show placeHolder in the textview
    public var placeHolder: NSString? {
        didSet { setNeedsDisplay() }
    }
    public var placeHolderColor: UIColor? {
        didSet { setNeedsDisplay() }
    }
    public var placeHolderLeftMargin: CGFloat = 5 {
        didSet { setNeedsDisplay() }
    }

    private weak var heightConstraint: NSLayoutConstraint?

    // Initialize
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // Listen to UITextView notification to handle trimming, placeholder and maximum length
    private func commonInit() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChange:", name: UITextViewTextDidChangeNotification, object: self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidEndEditing:", name: UITextViewTextDidEndEditingNotification, object: self)
    }
    
    // Remove notification observer when deinit
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let size = sizeThatFits(CGSizeMake(bounds.size.width, CGFloat.max))
        
        if (heightConstraint == nil) {
            heightConstraint = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: size.height)
            addConstraint(heightConstraint!)
        }
        
        if size.height != heightConstraint?.constant {
            self.heightConstraint!.constant = size.height;
            scrollRangeToVisible(NSMakeRange(0, 0))
            if let delegate = delegate as? GrowingTextViewDelegate {
                delegate.textViewDidChangeHeight?(size.height)
            }
        }
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if text.isEmpty {
            guard let placeHolder = placeHolder else { return }
            guard let placeHolderColor = placeHolderColor else { return }
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAlignment
            
            let rect = CGRectMake(textContainerInset.left + placeHolderLeftMargin,
                textContainerInset.top,
                frame.size.width - textContainerInset.left - textContainerInset.right,
                frame.size.height)
            
            let attributes = [
                NSFontAttributeName: font!,
                NSForegroundColorAttributeName: placeHolderColor,
                NSParagraphStyleAttributeName: paragraphStyle
            ]
            placeHolder.drawInRect(rect, withAttributes: attributes)
        }
    }
    
    func textDidEndEditing(notification: NSNotification) {
        if notification.object === self {
            if trimWhiteSpaceWhenEndEditing {
                text = text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                setNeedsDisplay()
            }
        }
    }
    
    func textDidChange(notification: NSNotification) {
        if notification.object === self {
            if maxLength > 0 && text.characters.count > maxLength {
                let endIndex = text.startIndex.advancedBy(maxLength)
                text = text.substringToIndex(endIndex)
                undoManager?.removeAllActions()
            }
            setNeedsDisplay()
        }
    }
}