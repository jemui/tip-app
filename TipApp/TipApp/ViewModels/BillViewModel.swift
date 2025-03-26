//
//  BillViewModel.swift
//  TipApp
//
//  Created by Jeanette on 1/26/25.
//  
//

class BillViewModel {
    private var bill = Bill(billTotal: 0.0, tipPercentage: 0.0, totalPeople: 2)
    
    //observable properties
    var partyCount: Int = 2 {
        didSet {
            onPartyCountUpdated?(partyCount)
            bill.totalPeople = partyCount
        }
    }

    
    var onPartyCountUpdated: ((Int) -> Void)?
    
    var billFieldTotal: String = "" {
        didSet {
            bill.billTotal = Float(billFieldTotal) ?? 0.0
        }
    }
    var tipPercentage: Float = 0.0 {
        didSet {
            bill.tipPercentage = tipPercentage
        }
    }
    
    var totalPerPerson: Float {
        bill.totalPerPerson
    }
    
    var resultSummary: String {
        "Split between \(bill.totalPeople), with \(bill.tipPercentage) tip."
    }
    
    func updateBillAmount(billAmount: Float) {
//        bill.billTotal
    }
}
