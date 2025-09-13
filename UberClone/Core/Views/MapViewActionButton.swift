//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 12/9/25.
//

import SwiftUI

struct MapViewActionButton: View {
    
    //MARK: PROPERTIES
    @Binding var mapViewState: MapViewState
    
    //MARK: BODY
    var body: some View {
        Button {
            withAnimation(.spring) {
                self.actionForState(mapViewState)
            }
        } label: {
            Image(systemName: self.imageNameFotState(mapViewState))
                .font(.title2)
                .foregroundStyle(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func actionForState(_ state: MapViewState) {
        switch state {
        case .noInput:
            print("NO INPUT")
        case .searchingForLocation:
            mapViewState = .noInput
        case .locationSelected:
            mapViewState = .noInput
        }
    }
    
    func imageNameFotState(_ state: MapViewState) -> String {
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .locationSelected, .searchingForLocation:
            return "arrow.left"
        }
    }
}

//MARK: PREVIEW
struct  MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapViewState: .constant(.noInput))
    }
}
