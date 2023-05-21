//
//  ContentView.swift
//  PhotoList
//
//  Created by Öznur Köse on 7.04.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var images = ImageModelView()
    @StateObject var settings = Settings()
    @StateObject var locationFetcher = LocationFetcher()
    
    var body: some View {
        TabView {
            PhotoListView()
                .environmentObject(images)
                .environmentObject(settings)
                .environmentObject(locationFetcher)
                .tabItem {
                    Label("Photos", systemImage: "photo.on.rectangle")
                }
            
            MapView()
                .environmentObject(images)
                .environmentObject(settings)
                .environmentObject(locationFetcher)
                .tabItem {
                    Label("Map", systemImage: "mappin.and.ellipse")
                }

            SettingsView()
                .environmentObject(images)
                .environmentObject(settings)
                .environmentObject(locationFetcher)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
            
           

            
        }
       
     
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        ContentView()
            .environmentObject(ImageModelView.ImagesSample)
    }
}
