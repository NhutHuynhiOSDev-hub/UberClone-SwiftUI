//
//  Double.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 13/9/25.
//

import Foundation

extension Double {
    private var currencyFormatter: NumberFormatter {
        
        let formatter = NumberFormatter()
        
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle           = .currency
        formatter.locale                = Locale(identifier: "en_US")

        return formatter
    }
    
    func toCurrency() -> String {
        return currencyFormatter.string(for: self) ?? ""
    }
}
