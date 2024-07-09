//
//  SegmentView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/2/24.
//

import SwiftUI

struct SegmentView: View {
    @State private var selectedSegment = 0
    let segments = ["First", "Second"]

    var body: some View {
        VStack {
            Picker("Select a segment", selection: $selectedSegment) {
                ForEach(0..<2) { index in
                    Text(segments[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if selectedSegment == 0 {
                Text("First Segment Selected")
            } else {
                Text("Second Segment Selected")
            }
        }
        .padding()
        
        Spacer()
    }
}

#Preview {
    SegmentView()
}
