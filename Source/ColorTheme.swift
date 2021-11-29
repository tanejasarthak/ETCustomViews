//
//  ColorTheme.swift
//  ETCustomView
//
//  Created by Sarthak.taneja on 29/11/21.
//

import Foundation

protocol ColorTheme {
    /**#212426*/
    var background: UIColor { get } // Use this for button background.
    /**#2F3136;*/
    var card: UIColor { get }
    /**#F9F8F3*/
    var cardSubView: UIColor { get }
    /**#222222**/
    var text: UIColor { get }
    /**#FFFFFF*/
    var buttonText: UIColor { get }
    /**#FF3B3B*/
    var alertText: UIColor { get }
}

public struct DarkColorTheme: ColorTheme {
    var background = #colorLiteral(red: 0.1294117647, green: 0.1411764706, blue: 0.1490196078, alpha: 1)
    var card = #colorLiteral(red: 0.1843137255, green: 0.1921568627, blue: 0.2117647059, alpha: 1)
    var cardSubView = #colorLiteral(red: 0.9764705882, green: 0.9725490196, blue: 0.9529411765, alpha: 1)
    var text = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
    var buttonText = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    var alertText = #colorLiteral(red: 1, green: 0.231372549, blue: 0.231372549, alpha: 1)
}

public struct LightColorTheme: ColorTheme {
    var background = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    var card = #colorLiteral(red: 0.007843137255, green: 0.07058823529, blue: 0.2352941176, alpha: 1)
    var cardSubView = #colorLiteral(red: 0.007843137255, green: 0.07058823529, blue: 0.2352941176, alpha: 1)
    var text = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
    var buttonText = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
    var alertText = #colorLiteral(red: 1, green: 0.231372549, blue: 0.231372549, alpha: 1)
}

private extension UIColor {
    func inversedColor() -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0

        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: alpha)
        }
        return self
    }
}
