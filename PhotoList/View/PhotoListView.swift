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
        if settings.nameOnly && settings.favOnly {
            return searchImages.filter { $0.isFavorite && $0.name.trimmingCharacters(in: .whitespacesAndNewlines) != "" }
        }
        else if settings.nameOnly {
            return searchImages.filter { $0.name.trimmingCharacters(in: .whitespacesAndNewlines) != "" }
        }
        else if settings.favOnly {
            return searchImages.filter { $0.isFavorite }
        }
        else {
            return searchImages
        }
    }

    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredImages) { image in
                    NavigationLink(destination: DetailedView(image: image)) {
                        HStack {
                            Image(uiImage: image.image[0])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                            Text("\(image.name)")
                            Spacer()
                            if image.isFavorite {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                   
                    } .onDelete { index in
                        if let imageIndex = images.images.firstIndex(where: { $0.id == filteredImages[index.first!].id } ) {
                            images.remove(at: imageIndex)
                            ImageModel.save(images: images.images)
                        }
                        
                    
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
