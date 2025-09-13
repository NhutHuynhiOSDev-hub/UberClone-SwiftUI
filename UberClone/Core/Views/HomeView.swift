//
//  ContentView.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 11/9/25.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: PROPERTIES
    @State private var mapViewState: MapViewState = .noInput
    
    //MARK: BODY
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewPresentable(mapViewState: $mapViewState)
                .ignoresSafeArea()
            
            if mapViewState  == .searchingForLocation {
                LocationSearchView(mapViewState: $mapViewState)
            } else if mapViewState == .noInput {
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        withAnimation {
                            self.mapViewState = .searchingForLocation
                        }
                    }
            }
            
            MapViewActionButton(mapViewState: $mapViewState)
                .padding(.leading, 24)
                .padding(.top, 4)
        }
    }
}

//MARK: PREVIEW
#Preview {
    HomeView()
}
