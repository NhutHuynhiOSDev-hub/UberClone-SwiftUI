//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 11/9/25.
//

import SwiftUI

@main
struct UberCloneApp: App {
    
    @StateObject var locationSearchViewModel = LocationSearchViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(self.locationSearchViewModel)
        }
    }
}
