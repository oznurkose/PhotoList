//
//  DetailedView.swift
//  PhotoList
//
//  Created by Öznur Köse on 7.04.2023.
//

import SwiftUI

struct DetailedView: View {
    @State var image: ImageData
    @State private var showingEditScreen = false
    
    @EnvironmentObject var images: ImageModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("\(image.name)")
                        .font(.headline)
                    
                    Image(uiImage: image.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 500, height: 500)
                    
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

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(image: ImageModel.ImagesSample.images[0])
    }
}
