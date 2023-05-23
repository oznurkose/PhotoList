//
//  Model.swift
//  PhotoList
//
//  Created by Öznur Köse on 7.04.2023.
//
import CoreLocation
import Foundation
import SwiftUI



class ImageModelView: ObservableObject {
//    static func == (lhs: ImageModel, rhs: ImageModel) -> Bool {
//        lhs.images == rhs.images
//    }
//
    @Published var images = [ImageData]()
    
    init(array: [ImageData] = [ImageData]()) {
        self.images = array
    }
    
    static func getDocumentsURL() -> URL? {
        let filename = "savedImage.jpg"
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = paths[0].appendingPathComponent(filename)
        return documentDirectoryURL
        
    }
    
    static func save(images: [ImageData]) {
        guard let url = ImageModelView.getDocumentsURL() else { return }
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(images)
            try data.write(to: url)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func load() {
        guard let url = ImageModelView.getDocumentsURL() else { return }
        do {
            let decoder = JSONDecoder()
            let decodedImage = try decoder.decode([ImageData].self, from: Data(contentsOf: url))
            self.images = decodedImage
        }
        
        catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(image: ImageData) {
        if let index = self.images.firstIndex(where: { $0.id == image.id }) {
            self.images.remove(at: index)
        }
        //self.save(images: self.images)
    }
    
    func remove(at index: Int) {
        self.images.remove(at: index)
    }
    
    func add(image: ImageData) {
        self.images.insert(image, at: 0)
    }
    
    func edit(image: ImageData) {
        if let index = self.images.firstIndex(where: { $0.id == image.id }) {
            print(index)
            print("index")
            self.images[index].name = image.name
        }
    }
    
}


extension ImageModelView {
    static let ImagesSample =  ImageModelView(array: [ImageData(id: UUID(), name: "Japan", image: [UIImage(named: "japan")!], date: Date.now, latitude: 37.785834, longitude: -122.406417),
                                              ImageData(id: UUID(), name: "Sicily", image: [UIImage(named: "sicily")!], date: Date.now, latitude: 37.785834, longitude: -122.406417)])
}


class Settings: ObservableObject {
    @Published var nameOnly = false
    @Published var favOnly = false
}
