//
//  EditView.swift
//  PhotoList
//
//  Created by Öznur Köse on 7.04.2023.
//

import SwiftUI

struct EditView: View {
    @State var image: ImageData
    @EnvironmentObject var images: ImageModel
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextField("Edit", text: $image.name)
                        .font(.headline)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    
                    Image(uiImage: image.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 500)
                        .padding()
                    
                }
                
            }
            
        }
        .toolbar {
            ToolbarItem {
                Button("Save") {
                    //
                    images.delete(image: image)
                    images.add(image: image)
                    ImageModel.save(images: images.images)
                    print(images)
                    dismiss()
                }
            }
        }
        
    }
    
}



//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(imagePhoto: (UIImage(named: "sicily") ?? UIImage(systemName: "person.crop.square"))!)
//    }
//}
