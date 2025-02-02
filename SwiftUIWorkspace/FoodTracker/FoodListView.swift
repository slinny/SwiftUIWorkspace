//
//  FoodListView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 2/2/25.
//

import SwiftUI

struct FoodListView: View {
    @State private var viewmodel = FoodViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewmodel.foodItems) { item in
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text("Calories: \(item.calories)")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Food Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddFoodItemView( viewmodel: viewmodel)) {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    FoodListView()
}
