//
//  Example2.swift
//  GrowingTextView
//
//  Created by Tsang Kenneth on 16/3/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import GrowingTextView

class Example2: UIViewController {
    
    @IBOutlet weak var inputToolbar: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint! //*** Bottom Constraint of toolbar ***
    @IBOutlet weak var textView: GrowingTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // *** Set below parameters in Storyboard ***
        //        textView.delegate = self
        //        textView.layer.cornerRadius = 4.0
        //        textView.maxLength = 200
        //        textView.maxHeight = 70
        //        textView.trimWhiteSpaceWhenEndEditing = true
        //        textView.placeHolder = "Say something..."
        //        textView.placeHolderColor = UIColor(white: 0.8, alpha: 1.0)
        //        textView.placeHolderLeftMargin = 5.0
        //        textView.font = UIFont.systemFont(ofSize: 15)
        
        // *** Listen for keyboard show / hide ***
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)

        // *** Hide keyboard when tapping outside ***
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillChangeFrame(_ notification: Notification) {
        let endFrame = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        bottomConstraint.constant = UIScreen.main.bounds.height - endFrame.origin.y
        self.view.layoutIfNeeded()
    }
    
    func tapGestureHandler() {
        view.endEditing(true)
    }
}

extension Example2: GrowingTextViewDelegate {
    
    // *** Call layoutIfNeeded on superview for animation when changing height ***
    
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
