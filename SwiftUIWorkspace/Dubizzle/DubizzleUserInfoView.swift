//
//  DubizzleUserInfoView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/9/24.
//

import SwiftUI

struct DubizzleUserInfoView: View {
    
    @ObservedObject var viewModel: DubizzleRegisterViewModel
    
    var body: some View {
        VStack {
            Text("User Info")
                .font(.title3)
                .frame(width: 300, height: 50)
                .padding()
            
            Text("Username: \($viewModel.username.wrappedValue)")
                .padding()
                .frame(width: 300, height: 50)
                .border(Color.black, width: 1)
                
            Text("Password: \($viewModel.password.wrappedValue)")
                .padding()
                .frame(width: 300, height: 50)
                .border(Color.black, width: 1)
            Spacer()
        }
    }
}

#Preview {
    DubizzleUserInfoView(viewModel: DubizzleRegisterViewModel())
}
