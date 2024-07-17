//
//  PlaceDetail.swift
//  Trailblazer
//
//  Created by Shawn Zhu on 5/29/24.
//

import SwiftUI
import MapKit


struct PlaceDetail: View {
    var MKCompletion : MKLocalSearchCompletion?
    @StateObject private var fetcher = PostsViewModel()
    
    var body: some View {
        VStack{
            Text("Name")
        }
        
    }
        
        
}

//#Preview {
//    PlaceDetail()
//}
