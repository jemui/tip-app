//
//  LabelFactory.swift
//  TipApp
//
//  Created by Jeanette on 1/25/25.
//  

import UIKit

@MainActor
class LabelFactory {
    //label factory pattern
    static func createTextLabel(text: String) -> UILabel {
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.tintColor = .black
        textLabel.textAlignment = .center
        
        return textLabel
    }
}
