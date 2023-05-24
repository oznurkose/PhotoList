//
//  DetailedView.swift
//  PhotoList
//
//  Created by Öznur Köse on 7.04.2023.
//
import MapKit
import SwiftUI

struct DetailedView: View {
    @State var image: ImageData
    @State private var showingEditScreen = false
    @State private var segmentedView = "Photo"
    var segments = ["Photo", "Location"]
    @State var region = LocationFetcher.Region
    var columns = [GridItem(.adaptive(minimum: 200))]
    @State var annotations = [ImageData.MapAnnotations]()
    
    
    var body: some View {
        if showingEditScreen {
            EditView(image: image)
        }
        else {
            NavigationView {
                ScrollView {
                    Picker("Detailed view selection", selection: $segmentedView) {
                        ForEach(segments, id: \.self) { segment in
                            Text("\(segment)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding([.bottom, .horizontal])
                    
                    if segmentedView == "Photo" {
                        VStack(alignment: .center) {
                            Text("\(image.name)")
                                .font(.title)
                            
                            ForEach(image.image, id: \.self) { img in
                                LazyVGrid(columns: columns) {
                                    Image(uiImage: img)
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                }
                            }
                        }
                    }
                    else {
                        VStack {
                            Text("\(image.name)")
                                .font(.title)
                            
                            Map(coordinateRegion: $region, annotationItems: [image]) { img in
                                MapAnnotation(coordinate: img.locationData.location) {
                                        AnnotationView(image: img)
                                }
                                
                            }
                            .frame(height: 500)
                        }
                    }
                }
                
            }
            .toolbar {
                ToolbarItem {
                    Button("Edit") {
                        showingEditScreen = true
                    }
                }
            }
            .sheet(isPresented: $showingEditScreen) {
                EditView(image: image)
            }
            .onAppear {
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: image.locationData.latitude, longitude: image.locationData.longitude), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
            }
            
        }
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(image: ImageModelView.ImagesSample.images[0])
    }
}
