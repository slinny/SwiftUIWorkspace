//
//  SelectListView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/2/24.
//

import SwiftUI

struct SelectListView: View {
    @State private var selected: Set<Int> = []
    @State private var orientation = 0
    
    var body: some View {
        Button {
            orientation = (orientation + 1) % 3
        } label: {
            Text("Change Orientation")
        }
        .orientationButtonStyle()
        
        HStack {
            Button {
                for i in 1..<101 {
                    selected.insert(i)
                }
            } label: {
                Text("Select All")
            }
            .selectButtonStyle()
            
            Button {
                selected = Set<Int>()
            } label: {
                Text("Deselect All")
            }
            .selectButtonStyle()
        }
        
        if orientation == 0 {
            gridList()
        } else if orientation == 1 {
            verticalList()
        } else if orientation == 2 {
            horizontallList()
        }
        
        Spacer()
    }
}

extension SelectListView {
    private func color(for index: Int) -> Color {
        if index % 10 == 0 {
            return .red
        } else if index % 5 == 0 {
            return .blue
        } else if index % 2 == 0 {
            return .green
        } else {
            return .gray
        }
    }
    
    private func verticalList() -> some View {
        ScrollView {
            Grid {
                ForEach(1..<101) { index in
                    Text(selected.contains(index) ? "Hello Selected \(index)" : "\(index)")
                        .frame(width: 350, height: 50, alignment: .leading)
                        .padding(.leading, 20)
                        .background(selected.contains(index) ? color(for: index) : Color.white)
                        .onTapGesture {
                            if selected.contains(index) {
                                selected.remove(index)
                            } else {
                                selected.insert(index)
                            }
                        }
                }
            }
        }
    }
    
    
    private func gridList() -> some View {
        ScrollView {
            VStack {
                ForEach(1..<21) { row in
                    HStack {
                        ForEach(1..<6) { column in
                            let index = row * 5 + column - 5
                            Text("\(index)")
                                .frame(width: 70, height: 70, alignment: .center)
                                .background(selected.contains(index) ? color(for: index) : Color.gray)
                                .cornerRadius(20.0)
                                .onTapGesture {
                                    if selected.contains(index) {
                                        selected.remove(index)
                                    } else {
                                        selected.insert(index)
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
    
    private func horizontallList() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(1..<101) { index in
                    Text(selected.contains(index) ? "Hello Selected \(index)" : "\(index)")
                        .frame(width: selected.contains(index) ? 100 : 30, height: 50, alignment: .leading)
                        .background(selected.contains(index) ? color(for: index) : Color.white)
                        .onTapGesture {
                            if selected.contains(index) {
                                selected.remove(index)
                            } else {
                                selected.insert(index)
                            }
                        }
                }
            }
        }
    }
}

extension Button {
    func orientationButtonStyle() -> some View {
        self
            .padding()
            .frame(width: 300, height: 50)
            .cornerRadius(20.0)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 2)
            )
    }
    
    func selectButtonStyle() -> some View {
        self
            .padding()
            .foregroundColor(.white)
            .frame(width: 150, height: 50)
            .background(Color.blue)
            .cornerRadius(20.0)
    }
}

#Preview {
    SelectListView()
}
