# NPPinCodeField
Customizable pin code control inherited from UIControl.

# Preview
![alt tag](https://s31.postimg.org/qnp444auj/Simulator+Screen Shot Jul 10, 2016, 10.30.36 PM.png)

# Customization
You can customize its properties in Interface Builder:
![alt tag](https://s31.postimg.org/lnrnw657v/Screen+Shot 2016-07-10 at 10.29.10 PM.png)

#Usage
Please check out the example project to see the NPPinCodeField in action.
```Swift

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pinCodeField = NPPinCodeField()
        
        // Number of dots
        pinCodeField.length = 4
        // Dot color
        pinCodeField.color = UIColor.darkGrayColor()
        // Dot diameter
        pinCodeField.diameter = 20
        // Spacing between dots
        pinCodeField.spacing = 16
        // Line thickness
        pinCodeField.thickness = 2
        // Add target for change event
        pinCodeField.addTarget(self, action: #selector(pinCodeChanged(_:)), forControlEvents: .EditingChanged)
        
        view.addSubview(pinCodeField)
    }
    
    func pinCodeChanged(sender: NPPinCodeField) {
        print("Pin code changed: " + sender.text)
        if sender.isFilled {
            sender.resignFirstResponder()
            print("Pin code entered.")
        }
    }

```

#License
MIT
