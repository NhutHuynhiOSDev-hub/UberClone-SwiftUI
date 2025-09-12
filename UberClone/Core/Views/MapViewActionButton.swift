//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 12/9/25.
//

import SwiftUI

struct MapViewActionButton: View {
    
    //MARK: PROPERTIES
    @Binding var showLocationSearchView: Bool
    
    //MARK: BODY
    var body: some View {
        Button {
            withAnimation(.spring) {
                showLocationSearchView.toggle()
            }
        } label: {
            Image(systemName: showLocationSearchView ? "arrow.left" : "line.3.horizontal")
                .font(.title2)
                .foregroundStyle(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

//MARK: PREVIEW
struct  MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(showLocationSearchView: .constant(true))
    }
}
