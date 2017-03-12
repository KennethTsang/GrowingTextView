//
//  ViewController.swift
//  GrowingTextView
//
//  Created by Kenneth Tsang on 02/17/2016.
//  Copyright (c) 2016 Kenneth Tsang. All rights reserved.
//

import UIKit
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
        textView.font = UIFont.systemFont(ofSize: 15)
        
        inputToolbar.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        inputToolbar.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["textView": textView]
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[textView]-8-|", options: [], metrics: nil, views: views)
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[textView]-8-|", options: [], metrics: nil, views: views)
        inputToolbar.addConstraints(hConstraints)
        inputToolbar.addConstraints(vConstraints)
        self.view.layoutIfNeeded()

//        constrain(inputToolbar, textView) { inputToolbar, textView in
//            textView.edges == inset(inputToolbar.edges, 8, 8, 8, 8)
//        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillChangeFrame(_ notification: Notification) {
        let endFrame = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        bottomConstraint.constant = view.bounds.height - endFrame.origin.y
        self.view.layoutIfNeeded()
    }
    
    func tapGestureHandler() {
        inputToolbar.endEditing(true)
    }
}

extension ViewController: GrowingTextViewDelegate {
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.inputToolbar.layoutIfNeeded()
        }, completion: nil)
    }
}
