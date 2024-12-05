//
//  ContentView.swift
//  Budget Tracker
//
//  Created by Oncu Can on 1.12.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var category: String = "Food"
    @State private var amount: String = ""
    @State private var date: Date = Date()
    @State private var description: String = ""
    
    let categories = ["Food", "Transport", "Salary", "Entertainment", "Other"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Category")) {
                    Picker("Select Category", selection: $category) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section(header: Text("Amount")) {
                    TextField("Enter amount", text: $amount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Date")) {
                    DatePicker("Select Date", selection: $date, displayedComponents: .date)
                }
                
                Section(header: Text("Description")) {
                    TextField("Enter description", text: $description)
                }
                
                Button(action: saveTransaction) {
                    Text("Add Transaction")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Add Transaction")
        }
    }
    
    func saveTransaction() {
        // Validate the amount as a valid Double
        guard let amountValue = Double(amount), !amount.isEmpty else {
            print("Invalid amount")
            return
        }

        // Create a new TransactionEntity
        let newTransaction = TransactionEntity(context: viewContext)
        newTransaction.category = category
        newTransaction.amount = amountValue
        newTransaction.date = date
        newTransaction.transactionDescription = description

        // Save the new transaction to Core Data
        do {
            try viewContext.save()
            print("Transaction saved: \(category), \(amount), \(date), \(description)")
        } catch {
            print("Error saving transaction: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
