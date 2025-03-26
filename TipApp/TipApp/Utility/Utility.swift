//
//  Utility.swift
//  TipApp
//
//  Created by Jeanette on 3/25/25.
//

import UIKit

class Utility {
    @MainActor static func createGradientBG(view: UIView) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            Constants.topGradientColor.cgColor,
            Constants.bottomGradientColor.cgColor
        ]
        
        // Set the gradient direction (you can adjust this)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // Top-left
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)   // Bottom-right
        
        // Set the frame of the gradient layer to match the view's bounds
        gradientLayer.frame = view.bounds
        
        return gradientLayer
    }
}
