//
//  HomeView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/8/24.
//

import SwiftUI

struct DubizzleHomeView: View {
    var body: some View {
        TabView {
            DubizzleHomeTabView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Text("Tab2")
                .tabItem {
                    Text("Tab2")
                }
            Text("Tab3")
                .tabItem {
                    Text("Tab3")
                }
            Text("Tab4")
                .tabItem {
                    Text("Tab4")
                }
            Text("Tab5")
                .tabItem {
                    Text("Tab5")
                }
        }
    }
}

#Preview {
    DubizzleHomeView()
}
