//
//  Place.swift
//  Trailblazer
//
//  Created by Shawn Zhu on 5/29/24.
//

import Foundation

class Place : Codable {
    let place_id : Int
    let placename : String
    let placeimageurl : String

    init(place_id: Int, placeName: String, placeImageURL: String) {
        self.place_id = place_id
        self.placename = placeName
        self.placeimageurl = placeImageURL
        
    }
    
//    required init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.place_id = try container.decode(UUID.self, forKey: .place_id)
//        self.placename = try container.decode(String.self, forKey: .placename)
//        self.placeimageurl = try container.decode(String.self, forKey: .placeimageurl)
//    }
    
    static var samplePlaces : [Place] = [
        Place(place_id: 1, placeName: "Vegas Wok", placeImageURL: "VegasWok")
    ]
}
