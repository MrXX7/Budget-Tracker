//
//  ContentView.swift
//  Budget Tracker
//
//  Created by Oncu Can on 1.12.2024.
//

import SwiftUI

struct ContentView: View {
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
        // Save transaction logic will go here
        print("Transaction saved: \(category), \(amount), \(date), \(description)")
    }
}


#Preview {
    ContentView()
}
