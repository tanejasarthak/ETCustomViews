//
//  ETCustomButton.swift
//  etmoneyios
//
//  Created by Neeraj Gupta on 26/02/21.
//  Copyright © 2021 ETMoney. All rights reserved.
//

import UIKit

// NOTE: never add height constraint to ETCustomButton
public class ResizableButton: UIButton {
    public override var intrinsicContentSize: CGSize {
       let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)) ?? .zero
       let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)

       return desiredButtonSize
    }
}

@IBDesignable public class ETCustomButton: ResizableButton {
    
    // MARK: - Properties
    
    public var etApperanceType: Bool = false {
        didSet {
            // Toggle the check/uncheck images
          //  updateAttributedString()
        }
    }
    
    @IBInspectable private var etApperance: Bool {
        get {
            return etApperanceType
        } set {
            self.etApperanceType = newValue
        }
    }
    
    var etButtonSize: ETCustomButtonSize = .large {
        didSet {
            // Toggle the check/uncheck images
            updateSize()
        }
    }
    @IBInspectable private var etSize: Int {
        get {
            return self.etButtonSize.rawValue
        }
        set( btsize) {
            self.etButtonSize = ETCustomButtonSize(rawValue: btsize) ?? .large
        }
    }
    
    
    
    var etButtonType: ETCustomButtonType = .primary {
        didSet {
            // Toggle the check/uncheck images
            updateTypeAndState()
        }
    }
    @IBInspectable private var etType: Int {
        get {
            return self.etButtonType.rawValue
        }
        set( btType) {
            self.etButtonType = ETCustomButtonType(rawValue: btType) ?? .primary
        }
    }
    
    

    var etButtonState: ETCustomButtonState = .defaultState {
        didSet {
            // Toggle the check/uncheck images
            updateTypeAndState()
        }
    }
    
    @IBInspectable private var etState: Int {
        get {
            return self.etButtonState.rawValue
        }
        set(btState) {
            self.etButtonState = ETCustomButtonState(rawValue: btState) ?? .defaultState
        }
    }

    private var heightConstraint : NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    internal func setup() {
        // do any initial setup here
        setupThemeApperance()
    }
    
    public func refreshView() {
        setupThemeApperance()
    }

    private func setupThemeApperance() {
        setThemes(theme: !etApperanceType ? LightColorTheme() : ThemeManager.shared.getColorTheme())
    }
    
    func setThemes(theme: ColorTheme) {
        backgroundColor = theme.background
        setTitleColor(theme.buttonText, for: .normal)
        tintColor = theme.buttonText
        layer.borderColor = theme.text.cgColor
    }
    
    private func updateSize(){
        if heightConstraint == nil {
            heightConstraint = NSLayoutConstraint.addHeightConstraint(view: self, withHeight: etButtonSize.getHeight())
            heightConstraint?.priority = UILayoutPriority(999)
            heightConstraint?.isActive = true
        }
        else{
            heightConstraint?.constant = etButtonSize.getHeight()
        }
        
        self.titleLabel?.font = etButtonSize.getTextFont()
    }
    
    
    private func updateTypeAndState(){
        layer.borderWidth = etButtonType.getBorderWidth(for: etButtonState)
        layer.borderColor = etButtonType.getBorderColor(for: etButtonState)
        layer.cornerRadius = etButtonState.getCornerRadius()
        backgroundColor = etButtonType.getBackgroundColor(for: etButtonState)
        setTitleColor(etButtonType.getTextColor(for: etButtonState), for: .normal)
    }

}



@objc public enum ETCustomButtonSize : Int {
    case large = 1
    case medium = 2
    case small = 3
    
    func getHeight() -> CGFloat {
        switch self {
        case .large:
            return 48.0
        case .medium:
            return 36.0
        case .small:
            return 24.0
        }
    }
    
    func getTextFont() -> UIFont {
        switch self {
        case .large:
            return UIFont(name: ETConstants.FontNames.ProximaSemiBold, size: 16.0) ?? UIFont.boldSystemFont(ofSize: 16.0)
        case .medium:
            return UIFont(name: ETConstants.FontNames.ProximaSemiBold, size: 14.0) ?? UIFont.boldSystemFont(ofSize: 14.0)
        case .small:
            return UIFont(name: ETConstants.FontNames.ProximaRegular, size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
        }
    }
}

@objc public enum ETCustomButtonType : Int {
    case primary = 1
    case secondary = 2
    
    func getBorderWidth(for state: ETCustomButtonState) -> CGFloat{
        switch self {
        case .primary:
            switch state {
            case .defaultState, .whiteBg:
                return 0.0
            default:
                return 1.0
            }
        case .secondary:
            return 1.0
        }
    }
    
    func getBorderColor(for state: ETCustomButtonState) -> CGColor {
        switch self {
        case .primary:
            switch state {
            case .disabled:
                return UIColor(red: 0.867, green: 0.867, blue: 0.867, alpha: 1).cgColor
            default:
                return UIColor.clear.cgColor
            }
        case .secondary:
            switch state {
            case .defaultState:
                return UIColor(red: 0.098, green: 0.702, blue: 0.553, alpha: 1).cgColor
            case .disabled:
                return UIColor(red: 0.867, green: 0.867, blue: 0.867, alpha: 1).cgColor
            case .greyOutline:
                return UIColor(red: 0.867, green: 0.867, blue: 0.867, alpha: 1).cgColor
            default:
                return UIColor.clear.cgColor
            }
        }
    }

    func getBackgroundColor(for state: ETCustomButtonState) -> UIColor {
        switch self {
        case .primary:
            switch state {
            case .defaultState:
                return UIColor(red: 0.098, green: 0.702, blue: 0.553, alpha: 1)
            case .disabled:
                return UIColor(red: 0.976, green: 0.973, blue: 0.953, alpha: 1)
            default:
                return UIColor.clear
            }
        case .secondary:
            return UIColor.clear
        }
    }
    
    func getTextColor(for state: ETCustomButtonState) -> UIColor {
        switch self {
        case .primary:
            switch state {
            case .defaultState:
                return .white
            case .disabled:
                return UIColor(red: 0.867, green: 0.867, blue: 0.867, alpha: 1)
            case .whiteBg:
                return UIColor(red: 0.098, green: 0.702, blue: 0.553, alpha: 1)
            default:
                return UIColor.clear
            }
        case .secondary:
            switch state {
            case .defaultState:
                return UIColor(red: 0.098, green: 0.702, blue: 0.553, alpha: 1)
            case .disabled:
                return UIColor(red: 0.867, green: 0.867, blue: 0.867, alpha: 1)
            case .greyOutline:
                return UIColor(red: 0.604, green: 0.604, blue: 0.604, alpha: 1)
            default:
                return UIColor.clear
            }
        }
    }
}

@objc public enum ETCustomButtonState : Int {
    case defaultState = 1
    case disabled = 2
    case greyOutline = 3
    case whiteBg = 4
    
    func getCornerRadius() -> CGFloat{
        switch self {
        case .whiteBg:
            return 0.0
        default:
            return 4.0
        }
    }
}

extension NSLayoutConstraint {
    static func addHeightConstraint(view theView:UIView, withHeight height:CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint.addHeightConstraint(view: theView, withHeight: height, andRelation: .equal)
    }
    
    static func addHeightConstraint(view theView:UIView, withHeight height:CGFloat, andRelation relation:NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: theView,
                                  attribute: .height,
                                  relatedBy: relation,
                                  toItem: nil,
                                  attribute: .notAnAttribute,
                                  multiplier: 1.0,
                                  constant: height)
    }
}
