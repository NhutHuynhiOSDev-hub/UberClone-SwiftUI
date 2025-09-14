//
//  LocationManager.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 11/9/25.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    static let shared           = LocationManager()
    private let locationManager = CLLocationManager()
    @Published var userLocationCoordinate : CLLocationCoordinate2D?
     
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        self.userLocationCoordinate = location.coordinate
        self.locationManager.stopUpdatingLocation()
    }
}
