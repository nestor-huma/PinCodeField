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
    @IBInspectable public var color: UIColor = .black {
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
        return text.count == length
    }
    
    
    // MARK: UITextInputTraits protocol properties
    public var autocapitalizationType = UITextAutocapitalizationType.none
    public var autocorrectionType = UITextAutocorrectionType.no
    public var spellCheckingType = UITextSpellCheckingType.no
    public var keyboardType = UIKeyboardType.numberPad
    public var keyboardAppearance = UIKeyboardAppearance.default
    public var returnKeyType = UIReturnKeyType.done
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
        addTarget(self, action: #selector(becomeFirstResponder), for: .touchUpInside)
    }
    
    
    // MARK: UIResponder
    public override var canBecomeFirstResponder: Bool {
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
    public override var intrinsicContentSize: CGSize {
        let width = CGFloat(length) * (diameter + spacing) - spacing + thickness
        let height = diameter + thickness
        return CGSize(width: width, height: height)
    }
    
    public override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setFillColor(color.cgColor)
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(thickness)
        
        // Draw circles
        var origin = CGPoint.zero
        for i in 0..<length {
            
            let isDotFilled = i < text.count
            if isDotFilled {
                let dotRect = CGRect(origin: origin, size: CGSize(width: diameter + thickness, height: diameter + thickness))
                context.fillEllipse(in: dotRect)
            } else {
                let position = CGPoint(x: origin.x + thickness/2, y: origin.y + thickness/2)
                let dotRect = CGRect(origin: position, size: CGSize(width: diameter, height: diameter))
                context.strokeEllipse(in: dotRect)
            }
            
            origin.x += diameter + spacing
        }
    }
    
}

// MARK: UIKeyInput
extension NPPinCodeField : UIKeyInput {
    
    public var hasText: Bool {
        return !text.isEmpty
    }
    
    public func insertText(_ textToInsert: String) {
        if isEnabled && text.count + textToInsert.count <= length {
            text.append(textToInsert)
            sendActions(for: .editingChanged)
        }
    }
    
    public func deleteBackward() {
        if isEnabled && !text.isEmpty {
            text.removeLast()
            sendActions(for: .editingChanged)
        }
    }
    
}
