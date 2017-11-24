//
//  ViewController.swift
//  PinCodeField
//
//  Created by nestorpopko on 11/25/2017.
//  Copyright (c) 2017 nestorpopko. All rights reserved.
//

import UIKit
import PinCodeField

class ViewController: UIViewController {

    @IBOutlet var pinCodeField: PinCodeField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pattern")!)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pinCodeField.becomeFirstResponder()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        pinCodeField.resignFirstResponder()
    }

    @IBAction func pinCodeChanged(_ sender: PinCodeField) {
        print("Pin code changed: " + sender.text)
        if sender.isFilled {
            sender.resignFirstResponder()
            print("Pin code entered.")
        }
    }

}

