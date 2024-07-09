//
//  HomeTabView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/8/24.
//

import SwiftUI

struct DubizzleHomeTabView: View {
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            SearchBar()
            ScrollView {
                serviceGridList()
                verifyView()
                popularListingView()
            }
        }
    }
}

extension DubizzleHomeTabView {
    private func popularListingView() -> some View {
        VStack {
            HStack {
                Text("Popular in Residential for Rent")
                    .bold()
                Spacer()
                Image(systemName: "arrow.right")
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(DubizzleData.properties.indices, id: \.self) { index in
                        VStack {
                            Image(systemName: DubizzleData.properties[index].thumbnail)
                                .resizable()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            Text("AED \(DubizzleData.properties[index].price)")
                                .foregroundColor(.red)
                            Text("\(DubizzleData.properties[index].numberOfBeds) Bed | \(DubizzleData.properties[index].numberOfBathrooms) Bath")
                            Text(DubizzleData.properties[index].address)
                        }
                        .padding(.horizontal, 5)
                        .frame(width: 120, height: 180)
                        .border(Color.black)
                        
                    }
                }
            }
        }
        .padding()
    }
    
    private func verifyView() -> some View {
        HStack {
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(Color/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .frame(width: 60, height: 150)
                .background(Color.mint)
            
            VStack(alignment: .leading) {
                Text("Become a verified user")
                    .bold()
                Text("Build Trust")
                Text("Get increased visibility")
                Text("Unlock Exclusive Rewards")
                Button{
                    
                }label: {
                    Text("Get started.")
                }
            }
            .frame(width: 220)
            
            Button{
                
            }label: {
                Image(systemName: "arrow.right")
            }
            .frame(width: 60, height: 150)
        }
        .frame(height: 150)
        .border(Color.gray)
        .padding()
    }
    
    private func serviceGridList() -> some View {
        LazyVGrid(columns: DubizzleData.columns) {
            ForEach(0..<9) { index in
                VStack {
                    Image(systemName: DubizzleData.services[index].imageName)
                        .foregroundColor(.red)
                        .frame(width: 40, height: 40)
                    Text(DubizzleData.services[index].title)
                    Spacer()
                }
                .frame(width: 110, height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
        }
        .padding()
    }
    
    
    private func SearchBar() -> some View {
        HStack {
            TextField("for property for rent", text: $searchText)
                .font(.footnote)
                .frame(width: 210, height: 50)
                .padding(.leading, 105)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .overlay(
                    HStack {
                        Image(systemName: "building.2")
                            .foregroundColor(.red)
                            .frame(minWidth: 20, maxWidth: 20, alignment: .leading)
                            .padding(.leading)
                        
                        Text("Search")
                            .frame(minWidth: 20, maxWidth: .infinity, alignment: .leading)
                            .padding(.trailing)
                    }
                )
                .padding(.horizontal, 10)
            
            Image(systemName: "bell")
                .resizable()
                .frame(width: 25, height: 30)
                .foregroundColor(.gray)
            
            Spacer()
        }
    }
}

#Preview {
    DubizzleHomeTabView()
}
