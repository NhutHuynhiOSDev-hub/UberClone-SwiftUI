//
//  ContentView.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 11/9/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewPresentable()
                .ignoresSafeArea()
            
            LocationSearchActivationView()
                .padding(.top, 72)
            
            MapViewActionButton()
                .padding(.leading, 24)
                .padding(.top, 4)
            
        }
    }
}

#Preview {
    HomeView()
}
