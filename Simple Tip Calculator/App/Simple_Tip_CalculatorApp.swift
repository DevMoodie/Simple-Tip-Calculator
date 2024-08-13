//
//  Simple_Tip_CalculatorApp.swift
//  Simple Tip Calculator
//
//  Created by Moody on 2024-08-13.
//

import SwiftUI

@main
struct Simple_Tip_CalculatorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
