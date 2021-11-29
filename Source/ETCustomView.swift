//
//  ETView.swift
//  ETViewPod
//
//  Created by Sarthak.taneja on 25/11/21.
//

import UIKit

public enum CurrentMode {
    case light
    case dark
}

public enum ETViewType: Int {
    case backgroundView = 0
    case cardView
    case cardSubView
}

@IBDesignable public class ETCustomView: UIView {
    
    // Set this as true if you want to make the UIView dynamic. For false, it will always have light background.
    public var etApperanceType: Bool = false {
        didSet {
            // Toggle the check/uncheck images
          //  updateAttributedString()
            setup()
        }
    }
    
    @IBInspectable private var etApperance: Bool {
        get {
            return etApperanceType
        } set {
            self.etApperanceType = newValue
        }
    }
    
    public var etViewStatusType: ETViewType = .backgroundView {
        didSet {
            setup()
        }
    }
    
    @IBInspectable private var etViewType: Int {
        get {
            return etViewStatusType.rawValue
        } set {
            self.etViewStatusType = ETViewType(rawValue: newValue) ?? .backgroundView
        }
    }
    
    @IBInspectable private var etBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable private var etCornerRaduis: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
       
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
    
    public func refreshView() {
        setup()
    }
    
    private func setup() {
       setThemes(theme: !etApperanceType ? LightColorTheme() : ThemeManager.shared.getColorTheme())
    }
    
    func setThemes(theme: ColorTheme) {
        backgroundColor = theme.background
        layer.borderColor = theme.text.cgColor
    }
}
