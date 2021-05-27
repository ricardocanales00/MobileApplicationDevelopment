//
//  AddView.swift
//  Act6
//
//  Created by Ricardo López Canales on 06/05/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses : Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    static let types = ["Personal", "Otro"]
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Concepto", text: $name)
                
                Picker("Tipo", selection: $type){
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Cantidad", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Agregar gasto")
            .navigationBarItems(trailing: Button("Guardar") {
                if let actualAmount = Int(self.amount){
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    
                    self.presentationMode
                        .wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

