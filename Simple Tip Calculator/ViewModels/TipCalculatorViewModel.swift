//
//  TipCalculatorViewModel.swift
//  Simple Tip Calculator
//
//  Created by Moody on 2024-08-13.
//

import Foundation
import CoreData

class TipCalculatorViewModel: ObservableObject {
    
    @Published var billAmount: String = ""
    @Published var tipPercentage: Int = 15
    @Published var savedCalculations: [Calculation] = []
    
    var tipPercentages = [10, 15, 20, 25, 30]
    
    var billAmountValue: Double {
        return Double(billAmount) ?? 0.0
    }
    
    var calculatorModel: TipCalculatorModel {
        return TipCalculatorModel(billAmount: Double(billAmount) ?? 0.0, tipPercentage: tipPercentage)
    }
    
    var tipAmountFormatted: String {
        return String(format: "$%.2f", calculatorModel.tipAmount)
    }
    
    var totalAmountFormatted: String {
        return String(format: "$%.2f", calculatorModel.totalAmount)
    }
    
    // Core Data Context
    private let context = PersistenceController.shared.container.viewContext
         
    // Save Calculation
    func saveCalculation() {
        let newCalculation = Calculation(context: context)
        newCalculation.billAmount = billAmountValue
        newCalculation.tipPercentage = Int16(tipPercentage)
        newCalculation.tipAmount = calculatorModel.tipAmount
        newCalculation.totalAmount = calculatorModel.totalAmount
        newCalculation.date = Date()

        do {
            try context.save()
            fetchSavedCalculations()
        } catch {
            print("Failed to save calculation: \(error.localizedDescription)")
        }
    }
     
    // Fetch Saved Calculations
    func fetchSavedCalculations() {
        let request: NSFetchRequest<Calculation> = Calculation.fetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
         
        do {
            savedCalculations = try context.fetch(request)
        } catch {
            print("Failed to fetch calculations: \(error.localizedDescription)")
        }
    }
     
    // Delete Calculation
    func deleteCalculation(at offsets: IndexSet) {
        offsets.forEach { index in
            let calculation = savedCalculations[index]
            context.delete(calculation)
        }

        do {
            try context.save()
            fetchSavedCalculations()
        } catch {
            print("Failed to delete calculation: \(error.localizedDescription)")
        }
    }
}
