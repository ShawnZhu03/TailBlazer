//
//  Item.swift
//  Trailblazer
//
//  Created by Shawn Zhu on 5/27/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
