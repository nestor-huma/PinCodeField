//
//  NPPinCodeField.swift
//  NPPinCodeField
//
//  Created by Nestor Popko on 2/14/16.
//  Copyright © 2016 Nestor Popko. All rights reserved.
//

import UIKit

@IBDesignable
class NPPinCodeField: UIControl, UIKeyInput {
    
    // MARK: properties
    @IBInspectable var pinCode: String = "" {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var maximumLength: UInt = 4 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var dotColor: UIColor? = UIColor.blackColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var dotRadius: Double = 10.0 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var dotSpacing: Double = 16.0 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineWidth: Double = 2.0 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }

    private var accessoryView: UIView?
    
    
    // MARK: UITextInputTraits protocol properties
    var autocapitalizationType = UITextAutocapitalizationType.None
    var autocorrectionType = UITextAutocorrectionType.No
    var spellCheckingType = UITextSpellCheckingType.No
    var keyboardType = UIKeyboardType.NumberPad
    var keyboardAppearance = UIKeyboardAppearance.Default
    var returnKeyType = UIReturnKeyType.Done
    var enablesReturnKeyAutomatically = true
    
    
    // MARK: initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    private func initialSetup() {
        addTarget(self, action: "becomeFirstResponder", forControlEvents: .TouchUpInside)
    }
    
    
    //MARK: UIView
    override func intrinsicContentSize() -> CGSize {
        let width = Double(maximumLength) * dotRadius * 2 + Double(maximumLength - 1) * dotSpacing + lineWidth
        let height = dotRadius * 2 + lineWidth
        return CGSizeMake(CGFloat(width), CGFloat(height))
    }
    
    override func drawRect(rect: CGRect) {
        var origin = CGPointMake(CGFloat(lineWidth/2), CGFloat(lineWidth/2))
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, dotColor?.CGColor)
        CGContextSetStrokeColorWithColor(context, dotColor?.CGColor)
        CGContextSetLineWidth(context, CGFloat(lineWidth))
        for i in 0..<maximumLength {
            let dotRect = CGRectMake(origin.x, origin.y, CGFloat(dotRadius * 2), CGFloat(dotRadius * 2))
            if Int(i) < pinCode.characters.count {
                CGContextFillEllipseInRect(context, dotRect)
            } else {
                CGContextStrokeEllipseInRect(context, dotRect)
            }
            origin.x += CGFloat(dotRadius * 2 + dotSpacing)
        }
    }
    
    
    // MARK: UIKeyInput
    func hasText() -> Bool {
        return !pinCode.isEmpty
    }
    
    func insertText(text: String) {
        if !self.enabled {
            return
        }
        
        if pinCode.characters.count + text.characters.count > Int(maximumLength) {
            return
        }
        
        pinCode.appendContentsOf(text)
        setNeedsDisplay()
        sendActionsForControlEvents(.EditingChanged)
    }
    
    func deleteBackward() {
        if !self.enabled || pinCode.isEmpty {
            return
        }
        
        pinCode.removeAtIndex(pinCode.endIndex.predecessor())
        setNeedsDisplay()
        sendActionsForControlEvents(.EditingChanged)
    }
    
    
    // MARK: UIResponder
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return accessoryView
        }
        
        set(value) {
            accessoryView = value
        }
    }
}

extension NPPinCodeField {
    /**
     Returns a Boolean value indicating whether all characters were entered.
     */
    func isFilled() -> Bool {
        return pinCode.characters.count == Int(maximumLength)
    }
}
