//
//  UberMapViewPresentable.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 12/9/25.
//

import MapKit
import SwiftUI

struct UberMapViewPresentable: UIViewRepresentable {
    
    //MARK: PROPERTIES
    let mapView         = MKMapView()
    let locationManager = LocationManager()
    
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    
    //MARK: FUNCTIONS
    func makeUIView(context: Context) -> some UIView {
        
        self.mapView.delegate           = context.coordinator
        self.mapView.isRotateEnabled    = false
        self.mapView.showsUserLocation  = true
        self.mapView.userTrackingMode   = .follow
        
        return self.mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate = self.locationSearchViewModel.selectedLocationCoordinate {
            print("DEBUG: Selected coordianted in map view: \(coordinate)")
            context.coordinator.addSelectAnnotation(withCoordinate: coordinate)
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
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            
            let region = MKCoordinateRegion(
                center: userLocation,
                span: span)
    
            self.parent.mapView.setRegion(region, animated: true)
        }
        
        //MARK: FUNCTIONS
        func addSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            
            // Remove all previous pins before add new once
            self.parent.mapView.removeAnnotations(self.parent.mapView.annotations)
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            
            self.parent.mapView.addAnnotation(anno)
            self.parent.mapView.selectAnnotation(anno, animated: true)
            self.parent.mapView.showAnnotations(self.parent.mapView.annotations, animated: true)
        }
    }
}
