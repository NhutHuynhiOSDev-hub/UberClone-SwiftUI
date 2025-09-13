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
        
        print("DEBUG: MapState is: \(mapViewState)")
        
        switch mapViewState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterUserLocation()
            break
        case .locationSelected:
            if let coordinate = self.locationSearchViewModel.selectedLocationCoordinate {
                
                print("DEBUG: Selected coordianted in map view: \(coordinate)")
                context.coordinator.addSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
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
            
            self.userLocationCoordinate = userLocation.coordinate
            
            let userLocationCoordinate = CLLocationCoordinate2D(
                latitude: userLocation.coordinate.latitude,
                longitude: userLocation.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            
            let region = MKCoordinateRegion(
                center: userLocationCoordinate,
                span: span)
    
            self.currentRegion = region
            
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
            
            // Remove all previous pins before add new once
            self.parent.mapView.removeAnnotations(self.parent.mapView.annotations)
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            
            self.parent.mapView.addAnnotation(anno)
            self.parent.mapView.selectAnnotation(anno, animated: true)
            self.parent.mapView.showAnnotations(self.parent.mapView.annotations, animated: true)
        } 
        
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            
            guard let userLocationCoordinates = self.userLocationCoordinate else { return }
            
            self.getDestinationRoute(from: userLocationCoordinates, to: coordinate) { route in
                
                self.parent.mapView.addOverlay(route.polyline)
            }
        }
        
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D,
                                 to destinationCoordinator: CLLocationCoordinate2D,
                                 completion: @escaping(MKRoute) -> Void) {
            
            let request                 = MKDirections.Request()
            let userPlacemark           = MKPlacemark(coordinate: userLocation)
            let destinationPlacemark    = MKPlacemark(coordinate: destinationCoordinator)
            
            request.source      = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destinationPlacemark)
            
            let direction = MKDirections(request: request)
             
            direction.calculate { response, error in
                if let error = error {
                    
                    print("DEBUG: Failed to get direction with erorr \(error.localizedDescription)")
                    return
                }
                
                guard let route = response?.routes.first else { return }
                completion(route)
            }
        }
        
        func clearMapViewAndRecenterUserLocation() {
            
            self.parent.mapView.removeOverlays(self.parent.mapView.overlays)
            self.parent.mapView.removeAnnotations(self.parent.mapView.annotations)
            
            if let currentRegion = self.currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}
