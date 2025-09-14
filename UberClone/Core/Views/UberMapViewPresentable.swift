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
    let locationManager = LocationManager.shared
    
    @Binding            var mapViewState: MapViewState
    @EnvironmentObject  var locationSearchViewModel: LocationSearchViewModel
    
    //MARK: FUNCTIONS
    func makeUIView(context: Context) -> some UIView {
        
        self.mapView.delegate           = context.coordinator
        self.mapView.isRotateEnabled    = false
        self.mapView.showsUserLocation  = true
        self.mapView.userTrackingMode   = .follow
        
        return self.mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        switch mapViewState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterUserLocation()
            break
        case .locationSelected:
            if let coordinate = self.locationSearchViewModel.selectedUberLocation?.coordinate {
                
                print("DEBUG: Coordinate is: \(coordinate)")
                
                context.coordinator.addSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        case .polylineAdded:
            break
        case .searchingForLocation:
            break
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension UberMapViewPresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        var currentRegion           : MKCoordinateRegion?
        let parent                  : UberMapViewPresentable
        var userLocationCoordinate  : CLLocationCoordinate2D?
        
        init(parent: UberMapViewPresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    
            self.currentRegion          = region
            self.userLocationCoordinate = userLocation.coordinate
            self.parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            
            if overlay is MKPolyline {
                let renderer = MKPolylineRenderer(overlay: overlay)
                
                renderer.lineWidth      = 3
                renderer.strokeColor    = .green
                
                return renderer
            }
            return MKOverlayRenderer()
        }
        
        //MARK: FUNCTIONS
        func addSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            
            self.parent.mapView.addAnnotation(anno)
            self.parent.mapView.selectAnnotation(anno, animated: true)
            self.parent.mapView.showAnnotations(self.parent.mapView.annotations, animated: true)
        } 
        
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            
            guard let userLocationCoordinates = self.userLocationCoordinate else { return }
            
            self.parent.locationSearchViewModel.getDestinationRoute(from: userLocationCoordinates, to: coordinate) { route in
                
                self.parent.mapView.addOverlay(route.polyline)
                self.parent.mapViewState = .polylineAdded
                
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect,
                                                               edgePadding: .init(top: 62, left: 32, bottom: UIScreen.main.bounds.size.height/1.5, right: 32))
                
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        func clearMapViewAndRecenterUserLocation() {
            
            parent.mapView.removeOverlays(parent.mapView.overlays)
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            if let currentRegion = self.currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}
