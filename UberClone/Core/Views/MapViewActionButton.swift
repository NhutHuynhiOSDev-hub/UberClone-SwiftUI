//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 12/9/25.
//

import SwiftUI

struct MapViewActionButton: View {
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: "line.3.horizontal")
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

struct  MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton()
    }
}
