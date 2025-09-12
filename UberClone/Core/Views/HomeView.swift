//
//  ContentView.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 11/9/25.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: PROPERTIES
    @State private var showLocationSearchView: Bool = false
    
    //MARK: BODY
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewPresentable()
                .ignoresSafeArea()
            
            if showLocationSearchView {
                LocationSearchView()
            } else {
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        self.showLocationSearchView.toggle()
                    }
            }
            
            MapViewActionButton(showLocationSearchView: $showLocationSearchView)
                .padding(.leading, 24)
                .padding(.top, 4)
            
        }
    }
}

//MARK: PREVIEW
#Preview {
    HomeView()
}
