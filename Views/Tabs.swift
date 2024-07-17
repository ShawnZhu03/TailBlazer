//
//  Tabs.swift
//  Trailblazer
//
//  Created by Shawn Zhu on 5/27/24.
//

import SwiftUI

struct Tabs: View {
    var body: some View {
        TabView {
            Dashboard()
                .tabItem{
                    Label("Dashboard", systemImage: "house")
                }
            
//            AddActivity()
//                .tabItem {
//                    Label("Activity", systemImage: "plus")
//                }
            
            Profile()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

#Preview {
    Tabs()
}
