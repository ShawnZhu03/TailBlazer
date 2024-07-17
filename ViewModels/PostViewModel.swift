//
//  PostViewModel.swift
//  Trailblazer
//
//  Created by Shawn Zhu on 6/3/24.
//

import Foundation

class PostsViewModel: ObservableObject {
    @Published var places: [Place] = []
    
    func fetchPlaces() async {
        print("fetch object")
        guard let url = URL(string: "http://192.168.1.83:5001/post") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response status code: \(httpResponse.statusCode)")
            }
            guard let data = data, error == nil else {
                print("error")
                return
            }
            
            do {
                let placeData = try JSONDecoder().decode([Place].self, from: data)
                DispatchQueue.main.async {
                    self.places = placeData
                    print("Successfully decoded data and updated places")
                }
            } catch {
                print(data.description)
                print("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
