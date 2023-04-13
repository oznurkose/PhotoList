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
    @EnvironmentObject var images: ImageModel
    @State private var segmentedView = "Photo"
    var segments = ["Photo", "Location"]
    @State var region = MKCoordinateRegion(center: ImageModel.ImagesSample.images[0].location,
                                           latitudinalMeters: 1000,
                                           longitudinalMeters: 1000)
    
    
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
                                .font(.headline)
                            
                            Image(uiImage: image.image)
                                .resizable()
                                .scaledToFit()
                                .frame( height: 500)
                                .padding()
                        }
                    }
                    else {
                        VStack {
                            Text("\(image.name)")
                                .font(.headline)
                            
                            Map(coordinateRegion: $region, annotationItems: ImageModel.ImagesSample.images) {
                                MapMarker(coordinate: $0.location)
                            }
                            .frame(height: 250)
                        }
                    }
                }
                
            }
            .toolbar {
                ToolbarItem {
                    Button("Edit") {
                        //
                        showingEditScreen = true
                    }
                }
            }
            .sheet(isPresented: $showingEditScreen) {
                EditView(image: image)
            }
            .onAppear {
                if let index = images.images.firstIndex(where: { $0.id == image.id }) {
                    image = images.images[index] }
            }
            
        }
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(image: ImageModel.ImagesSample.images[0])
            .environmentObject(ImageModel.ImagesSample)
    }
}
