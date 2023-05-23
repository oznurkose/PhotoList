//
//  ImageModel.swift
//  VizManager
//
//  Created by Öznur Köse on 21.05.2023.
//

import Foundation
import MapKit

struct ImageData: Identifiable, Codable {
    let id: UUID
    var name: String
    var image: [UIImage]
    let date: Date
    var locationData: MapAnnotations
    var isFavorite: Bool = false
    
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
        case fav
    }
    
    init(id: UUID, name: String, image: [UIImage], date: Date, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
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
        isFavorite = try container.decode(Bool.self, forKey: .fav)
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        locationData = MapAnnotations(latitude: latitude, longitude: longitude)
        let imageData = try container.decode([Data].self, forKey: .imageData)
        var images = [UIImage]()
        if imageData.isEmpty == false {
            for img in imageData {
                images.insert(UIImage(data: img)!, at: 0)
            }
        }
        image = images
        
        //image = [UIImage(data: imageData)] ?? [UIImage(named: "sicily")!]
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            // encoded
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(date, forKey: .date)
            try container.encode(isFavorite, forKey: .fav)
            try container.encode(locationData.latitude, forKey: .latitude)
            try container.encode(locationData.longitude, forKey: .longitude)
            var imageDataArr = [Data]()
            for img in image {
                if let imageData = img.jpegData(compressionQuality: 0.8) {
                    //try container.encode(imageData, forKey: .imageData)
                    imageDataArr.insert(imageData, at: 0)
                }
            }
            try container.encode(imageDataArr, forKey: .imageData)
            
        }
        
        catch {
            print(error.localizedDescription)
        }
    }
    

}
    
