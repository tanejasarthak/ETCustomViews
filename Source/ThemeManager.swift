//
//  ThemeManager.swift
//  ETCustomView
//
//  Created by Sarthak.taneja on 26/11/21.
//

import Foundation

public class ThemeManager {
    static public var shared = ThemeManager()
    public var selectedTheme: CurrentMode = .light
    private init() { }
    
    func getColorTheme() -> ColorTheme {
        switch ThemeManager.shared.selectedTheme {
        case .light:
            return LightColorTheme()
        case .dark:
            return DarkColorTheme()
        }
    }
}
