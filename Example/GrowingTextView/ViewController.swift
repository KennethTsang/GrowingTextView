//
//  ViewController.swift
//  GrowingTextView
//
//  Created by Kenneth Tsang on 02/17/2016.
//  Copyright (c) 2016 Kenneth Tsang. All rights reserved.
//

import UIKit
import Cartography
import GrowingTextView

class ViewController: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputToolbar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textView = GrowingTextView()
        textView.delegate = self
        textView.layer.cornerRadius = 4.0
        textView.maxLength = 200
        textView.maxHeight = 70
        textView.trimWhiteSpaceWhenEndEditing = true
        textView.placeHolder = "Say something..."
        textView.placeHolderColor = UIColor(white: 0.8, alpha: 1.0)
        textView.placeHolderLeftMargin = 5.0
        textView.font = UIFont.systemFontOfSize(15)
        
        inputToolbar.addSubview(textView)
        constrain(inputToolbar, textView) { inputToolbar, textView in
            textView.edges == inset(inputToolbar.edges, 8, 8, 8, 8)
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        let endFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        bottomConstraint.constant = CGRectGetHeight(view.bounds) - endFrame.origin.y
        self.view.layoutIfNeeded()
    }
    
    func tapGestureHandler() {
        inputToolbar.endEditing(true)
    }
}

extension ViewController: GrowingTextViewDelegate {
    func textViewDidChangeHeight(height: CGFloat) {
        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.CurveLinear], animations: { () -> Void in
            self.inputToolbar.layoutIfNeeded()
        }, completion: nil)
    }
}