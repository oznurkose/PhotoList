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
    @State private var isSheet = false
    @State private var shownAnnotations = [ImageData]()
    
    var body: some View {
        NavigationView {
            ScrollView {
                Map(coordinateRegion: $region, annotationItems: shownAnnotations) { img in
                    MapAnnotation(coordinate: img.locationData.location) {
                        
                        AnnotationView(image: img, title: img.name)
                    }
            }
            .frame(height: 600)
        }
        .navigationTitle("Locations")
    }
        .onAppear {
            shownAnnotations = images.images
        }
    //.sync($images.images, with: $shownAnnotations)
}



}

//extension View {
//    func sync(_ published: Binding<[ImageData]>, with binding: Binding<[ImageData]>) -> some View {
//        self
//            .onChange(of: published.wrappedValue) { pub in
//            binding.wrappedValue = pub
//        }
//
//    }
//}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
