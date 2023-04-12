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
        if showingEditScreen {
            EditView(image: image)
        }
        else {
            NavigationView {
                ScrollView {
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
