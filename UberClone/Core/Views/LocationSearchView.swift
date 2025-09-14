//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 12/9/25.
//

import SwiftUI

struct LocationSearchView: View {
    
    //MARK: PROPERTIES
    @State private var startLocationText = ""
    @Binding var mapViewState: MapViewState
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    
    //MARK: BODY
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(Color.theme.primaryTextColor)
                        .frame(width: 6, height: 6)
                }//:VSTACk
                
                VStack {
                    TextField("Current location",  text: $startLocationText)
                        .frame(height: 32)
                        .foregroundStyle(Color.theme.primaryTextColor)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                        
                    TextField("Where to?",  text: $locationSearchViewModel.queryFrament)
                        .frame(height: 32)
                        .foregroundStyle(Color.theme.primaryTextColor)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
                
            }//:HSTACK
            .padding(.leading)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(locationSearchViewModel.results, id:\.self) { result in
                        LocationSearchRow(title: result.title, subTitle: result.subtitle)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    self.mapViewState = .locationSelected
                                    self.locationSearchViewModel.selectLocation(result)
                                }
                            }
                    }
                }//:VSTACK
            }//:SCROLL
        } //:VSTACK
        .background(Color.theme.backgroundColor)
    }
}

//MARK: PREVIEW
struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapViewState: .constant(.searchingForLocation))
            .environmentObject(LocationSearchViewModel())
    }
}
