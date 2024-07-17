//
//  Post.swift
//  Trailblazer
//
//  Created by Shawn Zhu on 5/29/24.
//

import Foundation

class Post : Codable {
    let id : UUID
    let user : String
    let rating : Double
    let place : Place
    
    init(user: String, rating: Double, place: Place) {
        self.id = UUID()
        self.user = user
        self.rating = rating
        self.place = place
    }
    
    static var sampleData: [Post] = [
        Post(user: "Shawn", rating: 2.5, place : Place.samplePlaces[0]),
        Post(user: "Sam", rating: 3.6, place: Place.samplePlaces[0]),
        Post(user: "Shawn", rating: 2.5, place : Place.samplePlaces[0]),
        Post(user: "Sam", rating: 3.6, place: Place.samplePlaces[0]),
        Post(user: "Shawn", rating: 2.5, place : Place.samplePlaces[0]),
        Post(user: "Sam", rating: 3.6, place: Place.samplePlaces[0])
    ]
}
