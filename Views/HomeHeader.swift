//
//  HomeHeader.swift
//  Trailblazer
//
//  Created by Shawn Zhu on 5/29/24.
//

import SwiftUI

struct HomeHeader: View {
    @State private var searchTerm = ""
    
    @Binding var searchResults : Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("TrailBlazer")
                    .font(.system(size: 28))
                    .bold()
                    .fontDesign(.serif)
                    
                TextField("Search for anything", text: $searchTerm).frame(width: 250)
                    .textFieldStyle(CustomSearchBar())
                    .autocorrectionDisabled()
                    .onTapGesture {
                        searchResults = true
                    }
                    
                    
            }.padding(.leading).padding(.top)
            Spacer()
        }.padding(.bottom, 20)
    }
}

#Preview {
    HomeHeader(searchResults: .constant(true))
}

#Preview("no sheet") {
    HomeHeader(searchResults: .constant(false))
}
