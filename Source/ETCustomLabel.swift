//
//  ETCustomLabel.swift
//  etmoneyios
//
//  Created by Neeraj Gupta on 26/02/21.
//  Copyright © 2021 ETMoney. All rights reserved.
//

import UIKit

@IBDesignable public class ETCustomLabel: UILabel {
    
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
    
    public override var text: String?{
        didSet{
            updateAttributedString()
        }
    }
    
    var etLabelType: ETCustomLabelType = .body1 {
        didSet {
            // Toggle the check/uncheck images
            updateAttributedString()
        }
    }
    @IBInspectable private var etType: Int {
        get {
            return self.etLabelType.rawValue
        }
        set( labelType) {
            self.etLabelType = ETCustomLabelType(rawValue: labelType) ?? .body1
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

    internal func setup() {
        // do any initial setup here
        updateAttributedString()
        setupThemeApperance()
    }
    
    public func refreshView() {
        setupThemeApperance()
    }
    
    private func setupThemeApperance() {
        setThemes(theme: !etApperanceType ? LightColorTheme() : ThemeManager.shared.getColorTheme())
    }
    
    func setThemes(theme: ColorTheme) {
        textColor = theme.buttonText
        layer.borderColor = theme.text.cgColor
    }
    
    private func updateAttributedString(){
        if let text = text {
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = etLabelType.lineHeightMultiple()
            paragraphStyle.alignment = self.textAlignment
            paragraphStyle.lineBreakMode = self.numberOfLines == 0 ? .byWordWrapping : .byTruncatingTail
            let attributes = [
                NSAttributedString.Key.font : etLabelType.getTextFont(),
                NSAttributedString.Key.paragraphStyle : paragraphStyle
                ] as [NSAttributedString.Key : Any]
            
            let attributedStr = NSAttributedString(string: text, attributes: attributes)
            attributedText = attributedStr
        }
        else{
            attributedText = nil
        }
    }

}



@objc public enum ETCustomLabelType : Int {
    case displayHeading = 1
    case heading2 = 2
    case heading3 = 3
    case heading3_1 = 4
    case heading4 = 5
    case body1 = 6
    case body2 = 7
    case body3 = 8
    case body4 = 9
    case body5 = 10
    case para1 = 11
    case para2 = 12
    case heading3_2 = 13

    func getFontSize() -> CGFloat {
        switch self {
        case .displayHeading:
            return 28.0
        case .heading2:
            return 22.0
        case .heading3:
            return 18.0
        case .heading3_1:
            return 18.0
        case .heading4:
            return 16.0
        case .body1:
            return 16.0
        case .body2:
            return 14.0
        case .body3:
            return 14.0
        case .body4:
            return 12.0
        case .body5:
            return 12.0
        case .para1:
            return 16.0
        case .para2:
            return 14.0
        case .heading3_2:
            return 18.0
        }
    }
    
    func getLineHeight() -> CGFloat {
        switch self {
        case .displayHeading:
            return 34.0
        case .heading2:
            return 26.0
        case .heading3:
            return 22.0
        case .heading3_1:
            return 22.0
        case .heading4:
            return 20.0
        case .body1:
            return 20.0
        case .body2:
            return 18.0
        case .body3:
            return 18.0
        case .body4:
            return 16.0
        case .body5:
            return 16.0
        case .para1:
            return 24.0
        case .para2:
            return 22.0
        case .heading3_2:
            return 22.0
        }
    }

    func lineHeightMultiple() -> CGFloat {
        switch self {
        case .displayHeading:
            return 1.0
        case .heading2:
            return 0.97
        case .heading3:
            return 1.0
        case .heading3_1:
            return 1.0
        case .heading4:
            return 1.03
        case .body1:
            return 1.03
        case .body2:
            return 1.06
        case .body3:
            return 1.06
        case .body4:
            return 1.09
        case .body5:
            return 1.09
        case .para1:
            return 1.23
        case .para2:
            return 1.29
        case .heading3_2:
            return 1.0
        }
    }

    func getTextFont() -> UIFont {
        return UIFont(name: getFontFamilyName(), size: getFontSize()) ?? UIFont.boldSystemFont(ofSize: getFontSize())
    }
    
    func getFontFamilyName() -> String{
        switch self {
        case .displayHeading:
            return ETConstants.FontNames.ProximaBold
        case .heading2:
            return ETConstants.FontNames.ProximaSemiBold
        case .heading3:
            return ETConstants.FontNames.ProximaSemiBold
        case .heading3_1:
            return ETConstants.FontNames.ProximaSemiBold
        case .heading4:
            return ETConstants.FontNames.ProximaSemiBold
        case .body1:
            return ETConstants.FontNames.ProximaRegular
        case .body2:
            return ETConstants.FontNames.ProximaSemiBold
        case .body3:
            return ETConstants.FontNames.ProximaRegular
        case .body4:
            return ETConstants.FontNames.ProximaSemiBold
        case .body5:
            return ETConstants.FontNames.ProximaRegular
        case .para1:
            return ETConstants.FontNames.ProximaRegular
        case .para2:
            return ETConstants.FontNames.ProximaRegular
        case .heading3_2:
            return ETConstants.FontNames.ProximaBold
        }
    }
}
