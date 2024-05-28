//
//  ContentView.swift
//  Trailblazer
//
//  Created by Shawn Zhu on 5/27/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            Text("Hello")
        }
        detail: {
            Text("Home")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
