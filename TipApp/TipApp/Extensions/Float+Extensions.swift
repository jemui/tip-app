//
//  Float+Extensions.swift
//  TipApp
//
//  Created by Jeanette on 1/26/25.
//  

extension Float {
    func asCurrency() -> String {
        return String(format: "$%.2f", self)
    }
}
