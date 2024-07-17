//
//  LocationSearchResult.swift
//  Trailblazer
//
//  Created by Shawn Zhu on 7/17/24.
//

import Foundation
import MapKit
import SwiftUI

struct LocationSearchResult : View {
    let result : MKMapItem
    @EnvironmentObject var locationManager  : LocationManager
    
    var body: some View {
        VStack(alignment: .leading) {
            if let name = result.name {
                Text(name)
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
            HStack {
                if let distance = locationManager.locationToSearchResult(destination: result.placemark) {
                    let km = distance / 1000
                    let roundedKm = String(format: "%.1f", km)
                    Text("\(roundedKm) km  •  ")
                        .font(.caption)
                }
                if let category = result.pointOfInterestCategory {
                    let catString = String(format: "")
                    Text("\(category)")
                        .font(.caption)
                }
                
            }
            
        }.border(.gray)
    }
}
