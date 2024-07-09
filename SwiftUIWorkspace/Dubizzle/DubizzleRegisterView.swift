//
//  DubizzleRegisterView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/9/24.
//

import SwiftUI

struct DubizzleRegisterView: View {
    
    @StateObject var viewModel = DubizzleRegisterViewModel()
    
    var body: some View {
        NavigationStack {
            TextField("Username", text: $viewModel.username)
                .padding()
                .frame(width: 300, height: 50)
                .border(Color.black, width: 1)
                
            TextField("Password", text: $viewModel.password)
                .padding()
                .frame(width: 300, height: 50)
                .border(Color.black, width: 1)
            
            NavigationLink(destination: DubizzleUserInfoView(viewModel: viewModel)) {
                Text("Complete Registration")
                    .font(.title3)
                    .frame(width: 300, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    DubizzleRegisterView()
}
