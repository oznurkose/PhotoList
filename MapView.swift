//
//  MapView.swift
//  PhotoList
//
//  Created by Öznur Köse on 14.04.2023.
//
import MapKit
import SwiftUI

struct MapView: View {
    @EnvironmentObject var images: ImageModel
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.785834, longitude: -110.406417),
                                           span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    var body: some View {
        NavigationView {
            ScrollView {
                Map(coordinateRegion: $region, annotationItems: images.images) {
                    MapMarker(coordinate: $0.locationData.location)
                }
                .frame(height: 600)
            }
            .navigationTitle("Locations")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
