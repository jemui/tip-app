//
//  BillModel.swift
//  TipApp
//
//  Created by Jeanette on 1/26/25.
//  

struct Bill {
    var billTotal: Float
    var tipPercentage: Float
    var totalPeople: Int

    var tip: Float {
        billTotal*(tipPercentage/100.0)
    }
    
    var total: Float {
        billTotal+tip
    }
    
    var totalPerPerson: Float {
        total/Float(totalPeople)
    }
}
