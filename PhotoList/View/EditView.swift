//
//  EditView.swift
//  PhotoList
//
//  Created by Öznur Köse on 7.04.2023.
//
import MapKit
import SwiftUI

struct EditView: View {
    @State var image: ImageData
    @EnvironmentObject var images: ImageModel
    @Environment(\.dismiss) var dismiss
    @State private var segmentedView = "Photo"
    var segments = ["Photo", "Location"]
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417),
                                           span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    @State var annotations = [ImageData.MapAnnotations]()
    
    var body: some View {
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
                    VStack {
                        TextField("Edit", text: $image.name)
                            .font(.headline)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal, 10)
                        
                        
                        Image(uiImage: image.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 500)
                            .padding()
                        
                    }
                    
                }
                else {
                    VStack {
                        Text("\(image.name)")
                            .font(.headline)
                        ZStack {
                            Map(coordinateRegion: $region, annotationItems: annotations) {
                                MapMarker(coordinate: $0.location)
                            }
                            .frame(height: 500)
                            Circle()
                                .strokeBorder(.red)
                                .frame(width: 32, height: 32)
                        }
                        .onTapGesture {
                            annotations = [ImageData.MapAnnotations.init(latitude: region.center.latitude, longitude: region.center.longitude)]
                        }
                        
                    }
                }
            }
            
        }
        .toolbar {
            ToolbarItem {
                Button("Save") {
                    //
                    images.delete(image: image)
                    image.locationData = annotations[0]
                    images.add(image: image)
                    ImageModel.save(images: images.images)
                    print(images)
                    dismiss()
                }
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    //
                    images.delete(image: image)
                    ImageModel.save(images: images.images)
                    dismiss()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        .onAppear {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: image.locationData.latitude, longitude: image.locationData.longitude), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
            
            annotations = [ImageData.MapAnnotations.init(latitude: image.locationData.latitude, longitude: image.locationData.longitude)]
        }
    }
    
}



//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(imagePhoto: (UIImage(named: "sicily") ?? UIImage(systemName: "person.crop.square"))!)
//    }
//}
