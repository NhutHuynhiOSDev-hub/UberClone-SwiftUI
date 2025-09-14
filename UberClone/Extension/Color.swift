//
//  Color.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 14/9/25.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    let backgroundColor             : Color = Color("BackgroundColor")
    let primaryTextColor            : Color = Color("PrimaryTextColor")
    let secondaryBackgroundColor    : Color = Color("SecondaryBackgroundColor")
}
