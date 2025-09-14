//
//  RideType.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 13/9/25.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    case black
    case uberX
    case uberXL
    
    var id: Int {
        return rawValue
    }
    
    var description: String {
        switch self {
        case .black: 
            return "UberBlack"
        case .uberX: 
            return "UberX"
        case .uberXL: 
            return "UberXL"
        }
    }
    
    var imageName: String {
        switch self {
        case .black:
            return "uber-black"
        case .uberX:
            return "uber-x"
        case .uberXL:
            return "uber-x"
        }
    }
    
    var baseFare: Double {
        switch self {
        case .black:
            return 20
        case.uberX:
            return 5
        case .uberXL:
            return 10
        }
    }
    
    func computePrice(for distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters / 1600
        
        switch self {
        case .black:
            return distanceInMiles * 2 + baseFare
        case .uberX:
            return distanceInMiles * 1.5 + baseFare
        case .uberXL:
            return distanceInMiles * 1.75 + baseFare
        }
    }
}
