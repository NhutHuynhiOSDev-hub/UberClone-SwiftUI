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
    @Published var selectedLocation : String?
    @Published var queryFrament     : String = ""
    @Published var results = [MKLocalSearchCompletion]()
    
    private var cancellables    = Set<AnyCancellable>()
    private let searchCompleter = MKLocalSearchCompleter()
    
//    var queryFrament: String = "" {
//        didSet {
//            print("DEBUG: query fragment is \(self.queryFrament)")
//            self.searchCompleter.queryFragment = self.queryFrament
//        }
//    }

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
    func selectLocation(_ location: String) {
        print("DEBUG: Selected Location \(location)")
        self.selectedLocation = location
        
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
