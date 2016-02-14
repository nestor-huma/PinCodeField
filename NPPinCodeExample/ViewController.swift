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
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pattern")!)
        pinCodeField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

