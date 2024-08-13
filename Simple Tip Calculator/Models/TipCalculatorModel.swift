//
//  TipCalculatorModel.swift
//  Simple Tip Calculator
//
//  Created by Moody on 2024-08-13.
//

import Foundation

struct TipCalculatorModel {
    let billAmount: Double
    let tipPercentage: Int
    
    var tipAmount: Double {
        return billAmount * Double(tipPercentage) / 100
    }
    
    var totalAmount: Double {
        return billAmount + tipAmount
    }
}
