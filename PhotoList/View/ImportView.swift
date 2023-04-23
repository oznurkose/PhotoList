//
//  ImportView.swift
//  PhotoList
//
//  Created by Öznur Köse on 7.04.2023.
//
import MapKit
import SwiftUI

struct ImportView: View {
    @State var selectedImages = [UIImage]()
    //@State var image: UIImage?
    @State private var isImagePicker = false
    
    @State private var imageName = ""
    @State private var successAlert = false
    @State private var errorAlert = false
    @EnvironmentObject var images: ImageModel
    @EnvironmentObject var locationFetcher: LocationFetcher
    
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    @State var annotations = [ImageData.MapAnnotations]()
    
    @State private var addLocation = false
    @State private var addPhoto = false
    var columns = [GridItem(.adaptive(minimum: 200))]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Group {
                        if selectedImages.isEmpty {
                            // image selection button
                            ZStack {
                                ZStack(alignment: .bottomTrailing) {
                                    // image frame
                                    Circle()
                                        .strokeBorder(.blue, lineWidth:1)
                                        .frame(width: 200, height: 200)
                                    
                                    Image(systemName: "plus.circle")
                                        .background(isDarkMode ? .black : .white)
                                        .frame(width: 58, height: 58)
                                        .foregroundColor(.blue)
                                        .font(.title)
                                }
                                Image(systemName: "photo.on.rectangle")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(70)
                                    .frame(width: 250, height: 250)
                                    .foregroundColor(.blue)
                                    .clipShape(Circle())
                            }
                        }
                        else {
                            ForEach(selectedImages, id: \.self) { img in
                                LazyVGrid(columns: columns) {
                                    HStack(alignment: .top) {
                                        Image(uiImage: img)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 170)
                                            .cornerRadius(10)
                                            .shadow(color: Color.primary.opacity(0.3), radius: 1)
                                        Image(systemName: "xmark.circle")
                                            .foregroundColor(.red)
                                            .onTapGesture {
                                                let ix = selectedImages.firstIndex(of: img)
                                                selectedImages.remove(at: ix!)
                                            }
                                           
                                    }
                                    
                                    
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        isImagePicker = true
                    }
                    
                    Section {
                        HStack {
                            TextField("Name", text: $imageName, prompt: Text("Name"))
                                .textFieldStyle(.roundedBorder)
                        }
                    }
                    .padding(.horizontal, 10)
                    
                    Section {
                        Button("Tap to add more photos") {
                            //
                            isImagePicker = true
                        }
                    }
                    
                    Section {
                        if addLocation {
                            ZStack {
                                Map(coordinateRegion: $region, annotationItems: annotations) {
                                    MapMarker(coordinate: $0.location)
                                }
                                .frame(height: 200)
                                
                                Circle()
                                    .strokeBorder(.red)
                                    .frame(width: 32, height: 32)
                            }
                            .onTapGesture {
                                annotations = [ImageData.MapAnnotations.init(latitude: region.center.latitude, longitude: region.center.longitude)]
                            }
                        }
                        else {
                            Spacer()
                            Button("Tap to add location") {
                                //
                                addLocation = true
                            }
                            .buttonStyle(.borderedProminent)
                            .padding()
                            Spacer()
                        }
                        
                        
                        
                    }
                    .padding(.horizontal, 10)
                    
                }
                .sheet(isPresented: $isImagePicker) {
                    ImagePicker(images: self.$selectedImages)
                }
                .alert("Image saved successfuly!🎉", isPresented: $successAlert) {
                    Button("OK") {
                        dismiss()
                    }
                }
                .alert("You have to select an image!📷", isPresented: $errorAlert) {
                    //
                }
                .toolbar {
                    ToolbarItem {
                        Button("Save") {
                            //
                            if $selectedImages.isEmpty {
                                // show alert
                                errorAlert = true
                                
                            }
                            else {
                                let imageData =
                                ImageData(id: UUID(),
                                          name: imageName,
                                          image: selectedImages,
                                          date: Date.now,
                                          latitude:
                                            annotations.isEmpty ?
                                          region.center.latitude :
                                            annotations[0].latitude,
                                          longitude:
                                            annotations.isEmpty ?
                                          region.center.longitude :
                                            annotations[0].longitude)
                                
                                images.add(image: imageData)
                                ImageModel.save(images: images.images)
                                successAlert = true
                                print(images)
                            }
                            
                        }
                    }
                }
            }
        }
    }
}

//struct ImportView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImportView()
//            .environmentObject(ImageModel.ImagesSample)
//    }
//}
