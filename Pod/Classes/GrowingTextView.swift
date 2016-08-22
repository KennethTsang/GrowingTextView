//
//  GrowingTextView.swift
//  Pods
//
//  Created by Kenneth Tsang on 17/2/2016.
//  Copyright (c) 2016 Kenneth Tsang. All rights reserved.
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
    
    // Maximm height of the textview
    public var maxHeight = CGFloat(0)
    
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
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // Listen to UITextView notification to handle trimming, placeholder and maximum length
    private func commonInit() {
    
        self.contentMode = .Redraw
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textDidChange), name: UITextViewTextDidChangeNotification, object: self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textDidEndEditing), name: UITextViewTextDidEndEditingNotification, object: self)
    }
    
    // Remove notification observer when deinit
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // Calculate height of textview
    override public func layoutSubviews() {
        super.layoutSubviews()
        let size = sizeThatFits(CGSizeMake(bounds.size.width, CGFloat.max))
        var height = size.height
        if maxHeight > 0 {
            height = min(size.height, maxHeight)
        }
    
        if (heightConstraint == nil) {
            heightConstraint = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: height)
            addConstraint(heightConstraint!)
        }
        
        if height != heightConstraint?.constant {
            self.heightConstraint!.constant = height;
            scrollRangeToVisible(NSMakeRange(0, 0))
            if let delegate = delegate as? GrowingTextViewDelegate {
                delegate.textViewDidChangeHeight?(height)
            }
        }
    }
    
    // Show placeholder
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
            
            var attributes = [
                NSForegroundColorAttributeName: placeHolderColor,
                NSParagraphStyleAttributeName: paragraphStyle
            ]
            if let font = font {
                attributes[NSFontAttributeName] = font
            }
            
            placeHolder.drawInRect(rect, withAttributes: attributes)
        }
    }
    
    // Trim white space and new line characters when end editing.
    func textDidEndEditing(notification: NSNotification) {
        if notification.object === self {
            if trimWhiteSpaceWhenEndEditing {
                text = text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                setNeedsDisplay()
            }
        }
    }

    // Limit the length of text
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
