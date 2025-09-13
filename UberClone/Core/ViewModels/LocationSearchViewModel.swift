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
    @Published var queryFrament                 : String = ""
    @Published var selectedLocationCoordinate   : CLLocationCoordinate2D?
    @Published var results                      : [MKLocalSearchCompletion] = [MKLocalSearchCompletion]()
    
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
            
            self.selectedLocationCoordinate = coordinate
            
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
}

//MARK: MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        
        DispatchQueue.main.async {
            self.results = completer.results
        }
    }
}
