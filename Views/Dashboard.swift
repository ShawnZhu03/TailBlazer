//
//  Dashboard.swift
//  Trailblazer
//
//  Created by Shawn Zhu on 5/27/24.
//

import SwiftUI

struct Dashboard: View {
   
   
    @State private var isSheetPresent = false
    
    var body: some View {
        VStack()
          {
              
                HomeHeader(searchResults: $isSheetPresent)
              
                FeedView()
            
                  .fullScreenCover(isPresented: $isSheetPresent) {
                      AddActivity(isOpen: $isSheetPresent).environmentObject(LocationManager.shared)
                  }
              
            
              Spacer()
            
        }
        
    }
}

#Preview {
    Dashboard()
}
