//
//  TransactionEntity+CoreDataProperties.swift
//  Budget Tracker
//
//  Created by Oncu Can on 5.12.2024.
//

import Foundation
import CoreData

extension TransactionEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionEntity> {
        return NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
    }

    @NSManaged public var category: String?
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var transactionDescription: String?
}

