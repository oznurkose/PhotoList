//
//  MapView.swift
//  VizManager
//
//  Created by Öznur Köse on 21.05.2023.
//

import MapKit
import SwiftUI

struct MapView: View {
    @EnvironmentObject var images: ImageModelView
    @State var region = LocationFetcher.Region
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $region, annotationItems: images.images) { img in
                MapAnnotation(coordinate: img.locationData.location) {
                    NavigationLink {
                        DetailedView(image: img)
                    } label: {
                        AnnotationView(image: img)
                    }
                }
            }
            .navigationTitle("Locations")
            .ignoresSafeArea()
            
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(ImageModelView.ImagesSample)
    }
}
