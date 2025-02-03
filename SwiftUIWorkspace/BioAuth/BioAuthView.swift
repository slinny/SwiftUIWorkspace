//
//  BioAuthView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 2/3/25.
//

import SwiftUI
import LocalAuthentication

struct BioAuthView: View {
    @State private var isAuthenticated: Bool = false
    @State private var text: String = "LOCKED"
    
    var body: some View {
        Text(text)
            .bold()
            .padding()
        
        Button("Authenticate") {
            authenticate()
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Unlock using Touch ID") { success, error in
                DispatchQueue.main.async {
                    if success {
                        text = "UNLOCKED"
                    } else {
                        text = "Failed to unlock"
                    }
                }
            }
        } else {
            text = "Phone does not support Biometric Authentication"
        }
    }
}

#Preview {
    BioAuthView()
}
