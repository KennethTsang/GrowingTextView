//
//  ViewController.swift
//  GrowingTextView
//
//  Created by BigSmallDog on 02/17/2016.
//  Copyright (c) 2016 BigSmallDog. All rights reserved.
//

import UIKit
import Cartography
import GrowingTextView

class ViewController: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputToolbar: UIToolbar!
    
    lazy private var textView: GrowingTextView = {
        let _textView = GrowingTextView()
        _textView.delegate = self
        _textView.font = UIFont.systemFontOfSize(15)
        _textView.returnKeyType = .Send
        _textView.maxLength = 100
        _textView.trimWhiteSpaceWhenEndEditing = true
        _textView.placeHolder = "Say something..."
        _textView.placeHolderColor = UIColor(white: 0.8, alpha: 1.0)
        _textView.layer.cornerRadius = 4.0
        return _textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        inputToolbar.addSubview(textView)
        constrain(inputToolbar, textView) { inputToolbar, textView in
            textView.edges == inset(inputToolbar.edges, 8, 8, 8, 8)
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGestureHandler")
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
        textView.resignFirstResponder()
    }
}

extension ViewController: GrowingTextViewDelegate {
    func textViewDidChangeHeight(height: CGFloat) {
        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.CurveLinear], animations: { () -> Void in
            self.inputToolbar.layoutIfNeeded()
        }, completion: nil)
    }
}