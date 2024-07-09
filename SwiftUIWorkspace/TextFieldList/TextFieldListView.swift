//
//  TextFieldListView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/1/24.
//

import SwiftUI

struct TextFieldListView: View {
    @State private var item1: String = ""
    @State private var item2: String = ""
    @State private var item3: String = ""
    @State private var item4: String = ""
    @State private var item5: String = ""
    @State private var item6: String = ""
    @State private var item7: String = ""
    @State private var item8: String = ""
    @State private var item9: String = ""
    
    
    
    var body: some View {
        let items: [Binding<String>] = [
            $item1,
            $item2,
            $item3,
            $item4,
            $item5,
            $item6,
            $item7,
            $item8,
            $item9,
        ]
        
        List {
            ForEach(1..<10) {index in
                TextField("\(index): ", text: items[index-1])
            }
        }
    }
}

#Preview {
    TextFieldListView()
}
