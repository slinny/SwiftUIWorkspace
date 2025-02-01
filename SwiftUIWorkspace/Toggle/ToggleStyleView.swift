//
//  ToggleStyle.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 2/1/25.
//

import SwiftUI

struct ToggleStyleView: View {
    @State var isOn = false
    
    var body: some View {
        Form {
            Toggle("WiFi", systemImage: isOn ? "wifi" : "wifi.slash", isOn: $isOn)
                .toggleStyle(.button)
                .contentTransition(.symbolEffect)
        
            Toggle("WiFi", systemImage: "wifi", isOn: $isOn)
        }
    }
}

#Preview {
    ToggleStyleView()
}
