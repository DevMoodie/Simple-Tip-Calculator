//
//  TipCalculatorViewModel.swift
//  Simple Tip Calculator
//
//  Created by Moody on 2024-08-13.
//

import Foundation

class TipCalculatorViewModel: ObservableObject {
    
    @Published var billAmount: String = ""
    @Published var tipPercentage: Int = 15
    
    var tipPercentages = [10, 15, 20, 25, 30]
    
    var calculatorModel: TipCalculatorModel {
        return TipCalculatorModel(billAmount: Double(billAmount) ?? 0.0, tipPercentage: tipPercentage)
    }
    
    var tipAmountFormatted: String {
        return String(format: "$%.2f", calculatorModel.tipAmount)
    }
    
    var totalAmountFormatted: String {
        return String(format: "$%.2f", calculatorModel.totalAmount)
    }
}
