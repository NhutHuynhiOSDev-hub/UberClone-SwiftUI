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
    @State private var destinationLocationText = ""
    
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
                        .fill(Color(.black))
                        .frame(width: 6, height: 6)
                }//:VSTACk
                
                VStack {
                    TextField("Current location",  text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    
                    TextField("Where to?",  text: $destinationLocationText)
                        .frame(height: 32)
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
                    ForEach(0..<20, id:\.self) { _ in
                        LocationSearchRow()
                    }
                }//:VSTACK
            }//:SCROLL
        } //:VSTACK
        .background(Color(.systemBackground))
    }
}

//MARK: PREVIEW
struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
