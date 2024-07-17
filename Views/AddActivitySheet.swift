//
//  AddActivity.swift
//  Trailblazer
//
//  Created by Shawn Zhu on 5/27/24.
//

import SwiftUI

struct AddActivity: View {
    @Binding var isOpen : Bool
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var locationManager  : LocationManager
    @State private var isSearching = false
    @State private var resultSheet = false
    
    var body: some View {
                NavigationStack {
                    if isSearching {
                        ProgressView()
                    }
                    VStack {
                        TextField("Search for anything", text: $locationManager.searchTerm ).frame(width: 300)
                            .textFieldStyle(CustomSearchBar())
                            .autocorrectionDisabled()
                            .onSubmit {
                                Task {
                                    isSearching = true
                                    await locationManager.startLocalSearch(searchCompletion: nil, searchTerm: locationManager.searchTerm)
                                    isSearching = false
                                    resultSheet = true
                                }
                            }
                        
                        ScrollView(.vertical) {
                            
                            VStack(alignment: .leading) {
                                ForEach(locationManager.searchSuggestion, id: \.title) { result in
                                    Text(result.title)
                                        .padding(4)
                                        .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).fill(.gray))
                                        .onTapGesture {
                                            Task {
                                                isSearching = true
                                                print("tapped \(result.title)")
                                                await locationManager.startLocalSearch(searchCompletion: result, searchTerm: nil)
                                                isSearching = false
                                                resultSheet = true
                                            }
                                        }
                                }
                            }
                        }.frame(width:300, height: 150)
                        
                        
                        Spacer()
                    }.toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Label("dismiss", systemImage: "multiply")
                                .onTapGesture {
                                    dismiss()
                                }
                        }
                    }
                    .sheet(isPresented: $resultSheet) {
                        VStack{
                            if (!locationManager.searchResults.isEmpty) {
                                ForEach(locationManager.searchResults, id: \.hashValue) { result in
                                        LocationSearchResult(result: result)
                                    }
                                }
                        }
                        .presentationDetents([.large, .medium])
                    }
                }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            }
        }
     

#Preview {
    AddActivity(isOpen: .constant(true)).environmentObject(LocationManager.shared)
}
