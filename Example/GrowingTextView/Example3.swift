//
//  Example3.swift
//  GrowingTextView
//
//  Created by Kenneth on 29/7/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import GrowingTextView

class Example3: UIViewController {
    
    @IBOutlet weak var textView: GrowingTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // *** Customize GrowingTextView Instance ***
        textView.placeHolder = "Say something..."
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.minHeight = 30
        textView.maxHeight = 100
        
        // *** Hide keyboard when tapping outside ***
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
    }
    
    func tapGestureHandler() {
        view.endEditing(true)
    }
    
    @IBAction func minHeightChanged(_ sender: UISegmentedControl) {
        textView.minHeight = sender.selectedSegmentIndex == 0 ? 30 : 60
    }
    
    @IBAction func maxHeightChanged(_ sender: UISegmentedControl) {
        textView.maxHeight = sender.selectedSegmentIndex == 0 ? 100 : 150
    }
}

extension Example3: GrowingTextViewDelegate {
    
    // *** Call layoutIfNeeded on superview for animation when changing height ***
    
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
