//
//  Model.swift
//  PhotoList
//
//  Created by Öznur Köse on 7.04.2023.
//
import CoreLocation
import Foundation
import SwiftUI

struct ImageData: Identifiable, Codable {
//    static func == (lhs: ImageData, rhs: ImageData) -> Bool {
//        lhs.id == rhs.id
//    }
//
    let id: UUID
    var name: String
    let image: UIImage
    let date: Date
    var locationData: MapAnnotations
    
    struct MapAnnotations: Identifiable {
        let id: UUID
        var latitude: CLLocationDegrees
        var longitude: CLLocationDegrees
        var location: CLLocationCoordinate2D
        
        init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
            self.id = UUID()
            self.latitude = latitude
            self.longitude = longitude
            self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageData
        case date
        case latitude
        case longitude
    }
    
    init(id: UUID, name: String, image: UIImage, date: Date, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.id = id
        self.name = name
        self.image = image
        self.date = date
        self.locationData = MapAnnotations(latitude: latitude, longitude: longitude)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(Date.self, forKey: .date)
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        locationData = MapAnnotations(latitude: latitude, longitude: longitude)
        let imageData = try container.decode(Data.self, forKey: .imageData)
        image = UIImage(data: imageData) ?? UIImage(named: "sicily")!
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            // encoded
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(date, forKey: .date)
            try container.encode(locationData.latitude, forKey: .latitude)
            try container.encode(locationData.longitude, forKey: .longitude)
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                try container.encode(imageData, forKey: .imageData)
            }
        }
        
        catch {
            print(error.localizedDescription)
        }
    }
    

}
    


class ImageModel: ObservableObject {
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
        guard let url = ImageModel.getDocumentsURL() else { return }
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
        guard let url = ImageModel.getDocumentsURL() else { return }
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


extension ImageModel {
    static let ImagesSample =  ImageModel(array: [ImageData(id: UUID(), name: "Japan", image: UIImage(named: "japan")!, date: Date.now, latitude: 37.785834, longitude: -122.406417),
                                              ImageData(id: UUID(), name: "Sicily", image: UIImage(named: "sicily")!, date: Date.now, latitude: 37.785834, longitude: -122.406417)])
}


class Settings: ObservableObject {
    @Published var nameOnly = false
}
