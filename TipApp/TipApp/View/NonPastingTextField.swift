//
//  NonPastingTextField.swift
//  TipApp
//
//  Created by Jeanette on 1/26/25.
//  

import UIKit

class NonPastingTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        //disable pasting
        if action == #selector(UIResponderStandardEditActions.paste) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }

}
