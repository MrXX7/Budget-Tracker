//
//  EditTransactionView.swift
//  Budget Tracker
//
//  Created by Oncu Can on 2.12.2024.
//

import SwiftUI
import CoreData

struct EditTransactionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var isPresented: Bool
    var transaction: TransactionEntity
    
    @State private var category: String
    @State private var amount: String
    @State private var date: Date
    @State private var description: String

    init(isPresented: Binding<Bool>, transaction: TransactionEntity) {
        self._isPresented = isPresented
        self.transaction = transaction
        
        // Pre-fill fields with transaction details, safely unwrapping optionals
        self._category = State(initialValue: transaction.category ?? "Food")
        self._amount = State(initialValue: "\(transaction.amount)")
        self._date = State(initialValue: transaction.date ?? Date())
        self._description = State(initialValue: transaction.transactionDescription ?? "")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Category")) {
                    TextField("Enter category", text: $category)
                }
                Section(header: Text("Amount")) {
                    TextField("Enter amount", text: $amount)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Date")) {
                    DatePicker("Select date", selection: $date, displayedComponents: .date)
                }
                Section(header: Text("Description")) {
                    TextField("Enter description", text: $description)
                }
                Button(action: saveChanges) {
                    Text("Save Changes")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Edit Transaction")
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
        }
    }
    
    func saveChanges() {
        // Ensure the amount is a valid Double
        guard let amountValue = Double(amount), !amount.isEmpty else {
            print("Invalid amount")
            return
        }
        
        // Update the transaction entity with new values
        transaction.category = category
        transaction.amount = amountValue
        transaction.date = date
        transaction.transactionDescription = description
        
        // Save the changes to Core Data
        do {
            try viewContext.save()
            isPresented = false
        } catch {
            print("Error saving changes: \(error.localizedDescription)")
        }
    }
}



