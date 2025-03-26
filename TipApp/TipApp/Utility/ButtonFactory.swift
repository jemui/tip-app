//
//  ButtonFactory.swift
//  TipApp
//
//  Created by Jeanette on 1/25/25.
//  

import UIKit

@MainActor
class ButtonFactory {
    static func createButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(String(title), for: .normal)
        button.layer.cornerRadius = 15
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5
        button.titleLabel?.lineBreakMode = .byClipping
        button.adjustsImageSizeForAccessibilityContentSizeCategory = false
        
        button.backgroundColor = .clear
        button.setTitleColor(.blue, for: .selected)
        button.setTitleColor(Constants.tipColor, for: .normal)
        
        return button
    }
}
