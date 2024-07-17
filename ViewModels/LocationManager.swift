//
//  SearchLocationDelegate.swift
//  Trailblazer
//
//  Created by Shawn Zhu on 6/8/24.
//

import Foundation
import CoreLocation
import MapKit
import Combine

@MainActor
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate, MKLocalSearchCompleterDelegate {
    @Published var region: MKCoordinateRegion? {
            didSet {
                if let region = region {
                    searchManager.region = region
                }
            }
        }
    @Published var location: CLLocation?
    @Published var searchTerm = ""
    @Published var searchSuggestion : [MKLocalSearchCompletion] = []
    @Published var searchResults : [MKMapItem] = []
    private var cancellables = Set<AnyCancellable>()

    
    static let shared = LocationManager()
    
    private let cllLocationManager = CLLocationManager()
    private let searchManager = MKLocalSearchCompleter()
    
    override init() {
        super.init()
        cllLocationManager.delegate = self
        searchManager.delegate = self
        $searchTerm
                   .debounce(for: .milliseconds(600), scheduler: RunLoop.main)
                   .sink { [weak self] newValue in
                       self?.searchAutoComplete(newVal: newValue)
                   }
                   .store(in: &cancellables)
    }
    func locationToSearchResult(destination: MKPlacemark) -> CLLocationDistance?{
        guard let location = self.location else {
            print("error in calculating distance to destination")
            return nil
        }
        let destination3D = CLLocation(latitude: destination.coordinate.latitude, longitude: destination.coordinate.longitude)
        return location.distance(from: destination3D)
    }
    
    func searchAutoComplete(newVal : String) {
        self.searchManager.queryFragment = newVal
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchSuggestion = completer.results
        print(completer.results[0])
    }
    
    func onSearchComplete (response: MKLocalSearch.Response?, error: (any Error)?) {
        if let err = error {
            print("search error: \(err.localizedDescription)")
        }
        guard let response = response else {
            return
        }
        
        searchResults = response.mapItems
        print(response.mapItems)
    }
    
    func startLocalSearch(searchCompletion : MKLocalSearchCompletion?, searchTerm: String?) async {
        var searchRequest : MKLocalSearch.Request
        
        if let completion = searchCompletion {
            searchRequest = MKLocalSearch.Request(completion: completion)
        }
        else if let term = searchTerm {
            searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = term
        } else {
            return
        }
        
        if let region = self.region {
            searchRequest.region = region
        }
        
        do {
            let search = MKLocalSearch(request: searchRequest)
            let response = try await search.start()
            onSearchComplete(response: response, error: nil)
        }
        catch {
            onSearchComplete(response: nil, error: error)
        }
       
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.location = location
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        print(location)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {


            // If authorized, start location services.
        case .authorizedWhenInUse:
            print("authorized")
            cllLocationManager.requestLocation()
         break

            // Request authorization if the user hasn't chosen whether your app
            // can use location services yet.
        case .notDetermined:
            print("request")
            manager.requestWhenInUseAuthorization()


        case .denied, .restricted:
            // Handle denied or restricted status.
            
            break
        default:
            break
        }
    }
}
