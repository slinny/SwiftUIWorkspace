//
//  AlertView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/2/24.
//

import SwiftUI

struct AlertView: View {
    @State private var showAlert = false
    
    var body: some View {
        Button {
            showAlert = true
        } label: {
            Text("Open Alert!")
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Alert Title"),
                message: Text("This is an alert message."),
                dismissButton: .default(Text("OK"))
            )
        }
        
    }
}

#Preview {
    AlertView()
}
