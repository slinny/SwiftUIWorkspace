//
//  AddFoodItemView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 2/2/25.
//

import SwiftUI

enum ValidationError: String {
    case emptyName = "Please fill in a name."
    case emptyCalories = "Please fill in calories."
}

struct AddFoodItemView: View {
    @State private var name: String = ""
    @State private var calories: String = ""
    @Environment(\.dismiss) var dismiss
    @Bindable var viewmodel: FoodViewModel
    @State private var error: ValidationError?
    @State private var showError: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Food Item")) {
                    TextField("Name", text: $name)
                }
                
                Section(header: Text("Calories")) {
                    TextField("Calories", text: $calories)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Add Food Item")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if !viewmodel.isValidName(name: name) {
                            error = .emptyName
                            showError = true
                        } else if !viewmodel.isValidCalories(calories: calories) {
                            error = .emptyCalories
                            showError = true
                        } else {
                            viewmodel.saveFoodItem(name: name, calories: calories)
                            dismiss()
                        }
                    }) {
                        Label("Save", systemImage: "checkmark")
                    }
                }
            }
            .alert(isPresented: $showError) {
                Alert(title: Text("Error"), message: Text(error?.rawValue ?? ""))
            }
        }
    }
}

#Preview {
    AddFoodItemView(viewmodel: FoodViewModel())
}
