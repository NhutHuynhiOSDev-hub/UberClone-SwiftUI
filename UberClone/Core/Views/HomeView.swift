//
//  ContentView.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 11/9/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        UberMapViewPresentable()
            .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
