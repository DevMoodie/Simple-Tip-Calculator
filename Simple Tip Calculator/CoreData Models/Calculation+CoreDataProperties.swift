//
//  Calculation+CoreDataProperties.swift
//  Simple Tip Calculator
//
//  Created by Moody on 2024-08-14.
//
//

import Foundation
import CoreData


extension Calculation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Calculation> {
        return NSFetchRequest<Calculation>(entityName: "Calculation")
    }

    @NSManaged public var billAmount: Double
    @NSManaged public var tipPercentage: Int16
    @NSManaged public var tipAmount: Double
    @NSManaged public var totalAmount: Double
    @NSManaged public var date: Date?

}

extension Calculation : Identifiable {

}
