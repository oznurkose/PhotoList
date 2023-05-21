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
    @EnvironmentObject var images: ImageModelView
    @Environment(\.dismiss) var dismiss
    @State private var segmentedView = "Photo"
    var segments = ["Photo", "Location"]
    @State private var isImagePicker = false
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417),
                                           span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    @State var annotations = [ImageData.MapAnnotations]()
    
    var columns = [GridItem(.adaptive(minimum: 200))]
    
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
                        Section {
                            Button("Tap to add more photos") {
                                //
                                isImagePicker = true
                            }
                        }
                        TextField("Edit", text: $image.name)
                            .font(.headline)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal, 10)
                        
                        ForEach(image.image, id: \.self) { img in
                            LazyVGrid(columns: columns) {
                                HStack(alignment: .top) {
                                    
                                    Image(uiImage: img)
                                        .resizable()
                                        .scaledToFit()
                                    //.frame(height: 500)
                                    //.padding()
                                    
                                    Image(systemName: "xmark.circle")
                                        .foregroundColor(.red)
                                        .onTapGesture {
                                            
                                        
                                            
                                            //images.delete(image: image)
                                            let ix = image.image.firstIndex(of: img)
                                            image.image.remove(at: ix!)
                                            //images.add(image: image)
                                            //ImageModel.save(images: images.images)
                                            
                                        }
                                }
                            }
                        }
                        
                       
                        
                        Button {
                            image.isFavorite.toggle()
                        } label: {
                            if image.isFavorite {
                                Label("Remove from favorites", systemImage: "heart.fill")
                                    .foregroundColor(.red)
                            }
                            else {
                                Label("Make favorite", systemImage: "heart")
                                    .foregroundColor(.blue)
                            }
                        }
                    }.sheet(isPresented: $isImagePicker) {
                        ImagePicker(images: $image.image)
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
                    ImageModelView.save(images: images.images)
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
                    ImageModelView.save(images: images.images)
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
