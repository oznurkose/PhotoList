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
            VStack {
                TextField("Edit", text: $image.name)
                    .font(.headline)
                    .textFieldStyle(.roundedBorder)
                
                Image(uiImage: image.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 500)
                
                Button("Save") {
                    //
                    images.delete(image: image)
                    images.add(image: image)
                    //images.edit(image: image)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                
            }
        }
       
    }
    
}
    


//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(imagePhoto: (UIImage(named: "sicily") ?? UIImage(systemName: "person.crop.square"))!)
//    }
//}
