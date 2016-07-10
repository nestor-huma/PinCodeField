//
//  ViewController.swift
//  NPPinCodeExample
//
//  Created by Admin on 2/14/16.
//  Copyright © 2016 Nestor Popko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pinCodeField: NPPinCodeField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pattern")!)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        pinCodeField.becomeFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        pinCodeField.resignFirstResponder()
    }
    
    @IBAction func pinCodeChanged(sender: NPPinCodeField) {
        print("Pin code changed: " + sender.text)
        if sender.isFilled {
            sender.resignFirstResponder()
            print("Pin code entered.")
        }
    }

}

