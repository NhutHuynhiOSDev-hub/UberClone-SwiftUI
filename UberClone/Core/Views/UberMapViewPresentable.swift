//
//  UberMapViewPresentable.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 12/9/25.
//

import MapKit
import SwiftUI

struct UberMapViewPresentable: UIViewRepresentable {
    
    let mapView         = MKMapView()
    let locationManager = LocationManager()
    
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    
    func makeUIView(context: Context) -> some UIView {
        
        self.mapView.delegate           = context.coordinator
        self.mapView.isRotateEnabled    = false
        self.mapView.showsUserLocation  = true
        self.mapView.userTrackingMode   = .follow
        
        return self.mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let selectedLocation = self.locationSearchViewModel.selectedLocation {
            print("DEBUG: ViewModel \(selectedLocation)")
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension UberMapViewPresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: UberMapViewPresentable
        
        init(parent: UberMapViewPresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            
            let userLocation = CLLocationCoordinate2D(
                latitude: userLocation.coordinate.latitude,
                longitude: userLocation.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
            
            let region = MKCoordinateRegion(
                center: userLocation,
                span: span)
    
            self.parent.mapView.setRegion(region, animated: true)
        }
    }
}
