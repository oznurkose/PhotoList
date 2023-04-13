//
//  ImportView.swift
//  PhotoList
//
//  Created by Öznur Köse on 7.04.2023.
//
import MapKit
import SwiftUI

struct ImportView: View {
    @State private var image: UIImage?
    @State private var isImagePicker = false
    
    @State private var imageName = ""
    @State private var showingAlert = false
    @EnvironmentObject var images: ImageModel
    @EnvironmentObject var locationFetcher: LocationFetcher
    
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            VStack {
                //select an image
                Group {
                    if image == nil {
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
                        Image(uiImage: image!)
                            .resizable()
                        //   .frame(height: 350)
                            .scaledToFit()
                    }
                }
              
                .onTapGesture {
                    isImagePicker = true
                }
                Section {
                    TextField("Give a name ✍🏼", text: $imageName)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(50)
                
                
            }
            .sheet(isPresented: $isImagePicker) {
                ImagePicker(image: $image)
            }
            .alert("Image saved successfuly!", isPresented: $showingAlert) {
                Button("OK") {
                    dismiss()
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        //
                        if image == nil {
                            // show alert
                        }
                        else {
                            let imageData = ImageData(id: UUID(), name: imageName, image: image!, date: Date.now, location: CLLocationCoordinate2D(latitude: locationFetcher.lastKnownLocation!.latitude, longitude: locationFetcher.lastKnownLocation!.longitude))
                            images.add(image: imageData)
                            ImageModel.save(images: images.images)
                            showingAlert = true
                            print(images)
                        }
                        
                    }
                }
            }
        }
    }
}

struct ImportView_Previews: PreviewProvider {
    static var previews: some View {
        ImportView()
            .environmentObject(ImageModel.ImagesSample)
    }
}
