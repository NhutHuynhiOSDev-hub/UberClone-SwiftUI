//
//  LocationSearchRow.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 12/9/25.
//

import SwiftUI

struct LocationSearchRow: View {
    
    let title: String
    let subTitle: String
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundStyle(.blue)
                .tint(.white)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(self.title)
                    .font(.body)
                
                Text(self.subTitle)
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
                
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
        .padding(.leading)
    }
}

struct LocationSearchRow_Preview: PreviewProvider {
    static var previews: some View {
        LocationSearchRow(title: "Katinat Coffee", subTitle: "123 Dong Khoi")
    }
}
