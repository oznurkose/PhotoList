//
//  ContentView.swift
//  PhotoList
//
//  Created by Öznur Köse on 7.04.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var images = ImageModel()
    @StateObject var settings = Settings()
    @StateObject var locationFetcher = LocationFetcher()
    
    var body: some View {
        TabView {
            PhotoListView()
                .environmentObject(images)
                .tabItem {
                    Label("Photos", systemImage: "photo.on.rectangle")
                }
            
            MapView()
                .environmentObject(images)
                .tabItem {
                    Label("Map", systemImage: "mappin.and.ellipse")
                }
            
            SettingsView()
                .environmentObject(images)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
            
           

            
        }.environmentObject(settings)
        .environmentObject(locationFetcher)
       
     
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        ContentView()
            .environmentObject(ImageModel.ImagesSample)
    }
}
