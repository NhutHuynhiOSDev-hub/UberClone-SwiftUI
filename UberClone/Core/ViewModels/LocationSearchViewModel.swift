//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 12/9/25.
//

import MapKit
import Combine
import Foundation

class LocationSearchViewModel: NSObject, ObservableObject {
    
    //MARK: PROPERTIES
    @Published  var pickupTime              : String?
    @Published  var dropOffTime             : String?
    @Published  var queryFrament            : String = ""
    @Published  var selectedUberLocation    : UberLocation?
    @Published  var results                 : [MKLocalSearchCompletion] = [MKLocalSearchCompletion]()
                var userLocationCoordiante  : CLLocationCoordinate2D?
    
    private var cancellables    = Set<AnyCancellable>()
    private let searchCompleter = MKLocalSearchCompleter()

    override init() {
        super.init()
        self.searchCompleter.delegate       = self
        self.searchCompleter.queryFragment  = self.queryFrament
        
        // Add Debounce
        self.$queryFrament
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] fragment in
                guard let self = self else { return }
                self.searchCompleter.queryFragment = queryFrament
            }
            .store(in: &cancellables)
    }
    
    //MARK: FUNCTIONS
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        self.locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            
            if let error = error {
                print("DEBUG: Location search failed with error \(error.localizedDescription)")
                
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            
            let coordinate = item.placemark.coordinate
            
            self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
            
            print("DEBUG: Location coordinator \(coordinate)")
        }
    }
    
    // Search location details
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler) {
        
        let searchRequet = MKLocalSearch.Request()
        searchRequet.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        
        let search = MKLocalSearch(request: searchRequet)
        search.start { response, error in
            completion(response, error)
        }
    }
    
    func computeRidePrice(forType type: RideType) -> Double {
        
        guard let currentCoordinate = self.userLocationCoordiante else { return 0.0 }
        guard let destinationCoordinate = self.selectedUberLocation?.coordinate else { return 0.0 }
        
        let userLocation        = CLLocation(latitude: currentCoordinate.latitude, longitude: currentCoordinate.longitude)
        let destinationLocation = CLLocation(latitude: destinationCoordinate.latitude, longitude: destinationCoordinate.longitude)
        let tripDistanceInMeter = userLocation.distance(from: destinationLocation)
        
        return type.computePrice(for: tripDistanceInMeter)
    }
    
    func getDestinationRoute(from curentCoordiante: CLLocationCoordinate2D,
                             to destinationCoordinate: CLLocationCoordinate2D,
                             completion: @escaping(MKRoute) -> Void) {
        
        let request                 = MKDirections.Request()
        let userPlacemark           = MKPlacemark(coordinate: curentCoordiante)
        let destinationPlacemark    = MKPlacemark(coordinate: destinationCoordinate)
        
        request.source      = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        
        let direction = MKDirections(request: request)
         
        direction.calculate { response, error in
            if let error = error {
                
                print("DEBUG: Failed to get direction with erorr \(error.localizedDescription)")
                return
            }
            
            guard let route = response?.routes.first else { return }
            self.configurePickupAndDropOffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePickupAndDropOffTimes(with expectedTravelTime: Double) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        self.pickupTime  = formatter.string(from: Date())
        self.dropOffTime = formatter.string(from: Date() + expectedTravelTime)
    }
}

//MARK: MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        
        DispatchQueue.main.async {
            self.results = completer.results
        }
    }
}
