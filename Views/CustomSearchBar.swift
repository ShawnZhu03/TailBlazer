//
//  CustomSearchBar.swift
//  Trailblazer
//
//  Created by Shawn Zhu on 5/29/24.
//

import SwiftUI

struct CustomSearchBar: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color.lowContrast)
            .cornerRadius(20)
            
            
    }
}
