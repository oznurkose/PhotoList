//
//  PhotoListView.swift
//  PhotoList
//
//  Created by Öznur Köse on 7.04.2023.
//

import SwiftUI

struct PhotoListView: View {
    @EnvironmentObject var images: ImageModel
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var locationFetcher: LocationFetcher
    
    @State private var importImage = false
    @State private var sortingStyle = "date"
    @State private var sortingDialogue = false
    @State private var searchText = ""
    
    
    var sortedImages: [ImageData] {
        switch sortingStyle {
        case "date":
            return images.images.sorted { $0.date < $1.date }
            
        default:
            return images.images.sorted { $0.name < $1.name }
        }
    }
    
    var searchImages: [ImageData] {
        if searchText.isEmpty {
            return sortedImages
        }
        else {
            return sortedImages.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var filteredImages: [ImageData] {
        settings.nameOnly ? searchImages.filter { $0.name.trimmingCharacters(in: .whitespacesAndNewlines) != "" } : searchImages
    }

    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredImages) { image in
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
            .searchable(text: $searchText)
            .onAppear {
                images.load()
                locationFetcher.start()
            }
            .navigationTitle("Photos")
            .toolbar {
                Button {
                    //
                    importImage = true
                } label: {
                    Label("Import photo", systemImage: "plus")
                        .font(.system(size: 20))
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        //
                        sortingDialogue = true
                    } label: {
                        Label("Sorting", systemImage: "arrow.up.arrow.down")
                            .font(.system(size: 17))
                    }
                }
            }
            .confirmationDialog("Sort photos", isPresented: $sortingDialogue) {
                Button("Date") {
                    sortingStyle = "date"
                }
                Button("Name") {
                    sortingStyle = "name"
                }
            } message: {
                Text("Sort by")
            }
            .sheet(isPresented: $importImage) {
                ImportView()
            }
            
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
