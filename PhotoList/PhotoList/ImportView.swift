//
//  ImportView.swift
//  PhotoList
//
//  Created by Öznur Köse on 7.04.2023.
//

import SwiftUI

struct ImportView: View {
    @State private var image: UIImage?
    @State private var isImagePicker = false
    
    @State private var imageName = ""
    @State private var showingAlert = false
    @EnvironmentObject var images: ImageModel
    
    var body: some View {
        NavigationView {
            VStack {
                //select an image
                Group {
                    if image == nil {
                        Image(systemName: "photo.on.rectangle")
                            .resizable()
                            .frame(width: 180, height: 150)
                            .scaledToFit()
                    }
                    else {
                        Image(uiImage: image!)
                            .resizable()
                            .frame(width: 280, height: 180)
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
                
            }
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        //
                        if image == nil {
                            // show alert
                        }
                        else {
                            let imageData = ImageData(id: UUID(), name: imageName, image: image!)
                            images.add(image: imageData)
                            ImageModel.save(images: images.images)
                            imageName = ""
                            image = nil
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
