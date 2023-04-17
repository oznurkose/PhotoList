//
//  MapView.swift
//  PhotoList
//
//  Created by Öznur Köse on 14.04.2023.
//
import MapKit
import SwiftUI

struct PlaceAnnotationView: View {
  @State private var showTitle = true
  
  let title: String
  
  var body: some View {
    VStack(spacing: 0) {
      Text(title)
        .font(.callout)
        .padding(5)
        .background(Color(.white))
        .cornerRadius(10)
        .opacity(showTitle ? 0 : 1)

      
      Image(systemName: "mappin.circle.fill")
        .font(.title)
        .foregroundColor(.red)
      
      Image(systemName: "arrowtriangle.down.fill")
        .font(.caption)
        .foregroundColor(.red)
        .offset(x: 0, y: -5)
    }
    .onTapGesture {
      withAnimation(.easeInOut) {
        showTitle.toggle()
      }
    }
  }
}

struct MapView: View {
    @EnvironmentObject var images: ImageModel
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.785834, longitude: -110.406417),
                                           span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    @State private var selectedAnnotation: ImageData?
    @State private var isSheet = false
    @State private var shownAnnotations = [ImageData]()
    
    var body: some View {
        NavigationView {
            ScrollView {
                Map(coordinateRegion: $region, annotationItems: shownAnnotations) { img in
                    MapAnnotation(coordinate: img.locationData.location) {
                                        Button {
                                            selectedAnnotation = img
                                        } label: {
                                            PlaceAnnotationView(title: img.name)
                                        }
                                    }
                }
                .frame(height: 600)
            }
            .sheet(item: $selectedAnnotation) { image in
                VStack {
                    Text("\(image.name)")
                        .font(.headline)
                    
                    Image(uiImage: image.image)
                        .resizable()
                        .scaledToFit()
                        .frame( height: 500)
                        .padding()
                }
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
