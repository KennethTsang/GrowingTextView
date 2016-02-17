//
//  GrowingTextView.swift
//  Pods
//
//  Created by Kenneth on 17/2/2016.
//
//

//
//  GrowingTextView.swift
//  Pods
//
//  Created by Kenneth on 4/2/2016.
//
//

import Foundation
import UIKit

class GrowingTextView: UITextView {
    var trimWhiteSpaceWhenResign = true
    
    private weak var heightConstraint: NSLayoutConstraint?
    
    var placeHolder: NSString? {
        didSet { setNeedsDisplay() }
    }
    var placeHolderColor: UIColor? {
        didSet { setNeedsDisplay() }
    }
    var placeHolderLeftMargin: CGFloat = 5 {
        didSet { setNeedsDisplay() }
    }
    
//    override init(frame: CGRect, textContainer: NSTextContainer?) {
//        super.init(frame: frame, textContainer: textContainer)
//        commonInit()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//    
//    private func commonInit() {
//        let options = NSKeyValueObservingOptions([.New, .Old])
//        addObserver(self, forKeyPath: "selectedTextRange", options: options, context: &observerContext)
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
        let size = sizeThatFits(CGSizeMake(bounds.size.width, CGFloat.max))
        
        if (heightConstraint == nil) {
            heightConstraint = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: size.height)
            addConstraint(heightConstraint!)
        }
        
        if size.height != heightConstraint?.constant {
            heightConstraint!.constant = size.height;
            superview?.layoutIfNeeded()
            scrollRangeToVisible(NSMakeRange(0, 0))
        }
    }
    
    override func resignFirstResponder() -> Bool {
        if trimWhiteSpaceWhenResign {
            text = text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
        return super.resignFirstResponder()
    }
    
    override func drawRect(rect: CGRect) {
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
    
    //    override func shouldChangeTextInRange(range: UITextRange, replacementText text: String) -> Bool {
    //        let replacementLength = offsetFromPosition(range.start, toPosition: range.end)
    //        let newLength = self.text.characters.count - replacementLength + text.characters.count
    //        print("\(self.text.characters.count) - \(replacementLength) + \(text.characters.count)")
    //        return (newLength <= 10)
    //    }
}