//
//  LocationFetcher.swift
//  PhotoList
//
//  Created by Öznur Köse on 13.04.2023.
//


import CoreLocation
import MapKit

class LocationFetcher: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    @Published var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
    
    static let SampleLF = LocationFetcher()
    static let MapCoordinate = CLLocationCoordinate2D(latitude: SampleLF.lastKnownLocation?.latitude ?? 37.785834,
                                                      longitude: SampleLF.lastKnownLocation?.longitude ?? -110.406417)
    static let Region = MKCoordinateRegion(center: LocationFetcher.MapCoordinate,
                                           span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
}
