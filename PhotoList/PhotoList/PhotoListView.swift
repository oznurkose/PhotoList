//
//  PhotoListView.swift
//  PhotoList
//
//  Created by Öznur Köse on 7.04.2023.
//

import SwiftUI

struct PhotoListView: View {
    @EnvironmentObject var images: ImageModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(images.images) { image in
                    NavigationLink(destination: DetailedView(image: image)) {
                        HStack {
                            Text("\(image.name)")
                            Spacer()
                            Image(uiImage: image.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        }
                    }
                   
                    } .onDelete { index in
                        images.remove(at: index)
                        ImageModel.save(images: images.images)
                    
                }
                
            }
            .onAppear {
                images.load()
            }
            .navigationTitle("Photos")
        }
       // .environmentObject(images)
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
            .environmentObject(ImageModel.ImagesSample)
    }
}
