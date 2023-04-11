//
//  ContentView.swift
//  PhotoList
//
//  Created by Öznur Köse on 7.04.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var images = ImageModel()
    var body: some View {
        TabView {
            PhotoListView()
                .environmentObject(images)
                .tabItem {
                    Label("Photos", systemImage: "photo.on.rectangle")
                }
            
            ImportView()
                .environmentObject(images)
                .tabItem {
                    Label("Import", systemImage: "plus.circle")
                }
        }
     
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        ContentView()
            .environmentObject(ImageModel.ImagesSample)
    }
}
