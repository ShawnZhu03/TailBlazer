//
//  FeedView.swift
//  Trailblazer
//
//  Created by Shawn Zhu on 5/29/24.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationStack() {
            
            HStack {
                Text("Feed")
                    .padding(.leading, 15)
                
                Spacer()
                
            }
            
                
                
            
            ScrollView {
                LazyVStack {
                    ForEach(Post.sampleData, id: \.id) { post in
                        HStack {
                            NavigationLink(destination: PlaceDetail()) {
                                Text(post.user).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundStyle(Color.black)
                            }
                            Spacer()
                            ZStack {
                                Circle()
                                    .strokeBorder(lineWidth: 2)
                                    .frame(width:80)
                                    .foregroundColor(.green)
                                
                                Text(String(format: "%.1f", post.rating))
                                    .foregroundStyle(Color.green)
                                
                            }
                            
                            
                        }.padding()
                        Divider()
                    }
                }
            }
            
        }
    }
}

#Preview {
    FeedView()
}
