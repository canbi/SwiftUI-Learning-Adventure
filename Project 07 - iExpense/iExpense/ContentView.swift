//
//  ContentView.swift
//  iExpense
//
//  Created by Can Bi on 2.02.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Personal Expenses")){
                    ForEach(expenses.items) { item in
                        item.type == ExpenseType.Business ? nil :
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type.rawValue)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                .foregroundColor(colorStatus(for: item.amount))
                            
                        }
                    }.onDelete(perform: removeItems)
                    
                    expenses.items.filter{$0.type == ExpenseType.Personal}.count == 0 ? Text("No Expense") : nil
                }
                
                Section(header: Text("Business Expenses")){
                    ForEach(expenses.items) { item in
                        item.type == ExpenseType.Personal ? nil :
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type.rawValue)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                .foregroundColor(colorStatus(for: item.amount))
                            
                        }
                    }.onDelete(perform: removeItems)
                    
                    expenses.items.filter{$0.type == ExpenseType.Business}.count == 0 ? Text("No Expense") : nil
                }
            }
            
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func colorStatus(for amount: Double) -> Color{
        if amount <= 10{
            return Color.green
        }else if amount <= 100{
            return Color.orange
        }else{
            return Color.red
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
