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
}
