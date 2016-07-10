//
//  NPPinCodeField.swift
//  NPPinCodeField
//
//  Created by Nestor Popko on 2/14/16.
//  Copyright © 2016 Nestor Popko. All rights reserved.
//

import UIKit

@IBDesignable
public class NPPinCodeField: UIControl, UITextInputTraits {
    
    /** The text entered by user. */
    @IBInspectable public var text: String = "" {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /** Length of the pin code */
    @IBInspectable public var length: Int = 4 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
    
    /** Color of the dots. */
    @IBInspectable public var color: UIColor = UIColor.blackColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /** Diameter of the dots. */
    @IBInspectable public var diameter: CGFloat = 20.0 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
    
    /** Spacing between the dots. */
    @IBInspectable public var spacing: CGFloat = 16.0 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
    
    /** Line thickness. */
    @IBInspectable public var thickness: CGFloat = 2.0 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
    
    /** Tells whether the pin code is empty. */
    public var isEmpty: Bool {
        return text.isEmpty
    }
    
    /** Tells whether all characters were entered. */
    public var isFilled: Bool {
        return text.characters.count == length
    }
    
    
    // MARK: UITextInputTraits protocol properties
    public var autocapitalizationType = UITextAutocapitalizationType.None
    public var autocorrectionType = UITextAutocorrectionType.No
    public var spellCheckingType = UITextSpellCheckingType.No
    public var keyboardType = UIKeyboardType.NumberPad
    public var keyboardAppearance = UIKeyboardAppearance.Default
    public var returnKeyType = UIReturnKeyType.Done
    public var enablesReturnKeyAutomatically = true
    
    
    // MARK: initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    private func initialSetup() {
        addTarget(self, action: #selector(becomeFirstResponder), forControlEvents: .TouchUpInside)
    }
    
    
    // MARK: UIResponder
    override public func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    private var accessoryView: UIView?
    
    override public var inputAccessoryView: UIView? {
        get {
            return accessoryView
        }
        set(value) {
            accessoryView = value
        }
    }
    
    
    //MARK: UIView
    override public func intrinsicContentSize() -> CGSize {
        let width = CGFloat(length) * (diameter + spacing) - spacing + thickness
        let height = diameter + thickness
        return CGSizeMake(width, height)
    }
    
    override public func drawRect(rect: CGRect) {
        var origin = CGPointZero
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        CGContextSetLineWidth(context, thickness)
        
        // Draw circles
        for i in 0..<length {
            
            let isDotFilled = i < text.characters.count
            if isDotFilled {
                let dotRect = CGRect(origin: origin, size: CGSize(width: diameter + thickness, height: diameter + thickness))
                CGContextFillEllipseInRect(context, dotRect)
            } else {
                let position = CGPointMake(origin.x + thickness/2, origin.y + thickness/2)
                let dotRect = CGRect(origin: position, size: CGSize(width: diameter, height: diameter))
                CGContextStrokeEllipseInRect(context, dotRect)
            }
            
            origin.x += diameter + spacing
        }
    }
    
}

// MARK: UIKeyInput
extension NPPinCodeField : UIKeyInput {
    
    public func hasText() -> Bool {
        return !text.isEmpty
    }
    
    public func insertText(textToInsert: String) {
        if self.enabled && text.characters.count + textToInsert.characters.count <= length {
            text.appendContentsOf(textToInsert)
            sendActionsForControlEvents(.EditingChanged)
        }
    }
    
    public func deleteBackward() {
        if self.enabled && !text.isEmpty {
            text.removeAtIndex(text.endIndex.predecessor())
            sendActionsForControlEvents(.EditingChanged)
        }
    }
    
}
