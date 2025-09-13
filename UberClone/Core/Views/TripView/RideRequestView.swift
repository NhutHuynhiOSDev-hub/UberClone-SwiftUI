//
//  RideRequestView.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 13/9/25.
//

import SwiftUI

struct RideRequestView: View {
    var body: some View {
        VStack(spacing: 8) {
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
            
            HStack {
                // Indicator View
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 32)
                    
                    Rectangle()
                        .fill(Color(.black))
                        .frame(width: 8, height: 8)
                }//:VSTACK
                
                // Trip Info
                VStack(alignment: .leading, spacing: 32) {
                    HStack {
                        Text("Current location")
                            .font(.system(size: 16)
                                .weight(.semibold))
                            .foregroundStyle(.gray)
                        
                        Spacer()
                        
                        Text("1:30 PM")
                            .font(.system(size: 14)
                                .weight(.semibold))
                            .foregroundStyle(.gray)
                    }
                    
                    HStack {
                        Text("The Coffee House")
                            .font(.system(size: 16)
                                .weight(.bold))
                            .foregroundStyle(.gray)
                        
                        Spacer()
                        
                        Text("1:45 PM")
                            .font(.system(size: 14)
                                .weight(.semibold))
                            .foregroundStyle(.gray)
                    }
                }//:VSTACK
                .padding(.leading, 8)
                
            }//:HSTACK
            .padding()
            
            Divider()
            
            
            // Car Options
            Text("Suggested ride".uppercased())
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(0..<3, id: \.self) { _ in
                        VStack(alignment: .leading) {
                            Image("uber-x")
                                .resizable()
                                .scaledToFit()
                            
                            VStack(spacing: 4) {
                                Text("Uber-X")
                                    .font(.system(size: 14).weight(.semibold))
                                
                                Text("$22.04")
                                    .font(.system(size: 14).weight(.semibold))
                            }
                            .padding()
                        }
                        .frame(width: UIScreen.main.bounds.width/3, height: 140)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
            
            Divider()
                .padding(.vertical, 8)
            
            // Payment Options
            HStack(spacing: 12) {
                Text("Visa")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .foregroundStyle(.white)
                    .background(Color(.blue))
                    .cornerRadius(4)
                    .padding(.leading)
                
                Text("*** 1234")
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding(.trailing)
            }
            .frame(height: 50)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // Confirm Button
            Button {
                
            } label: {
                Text("Confirm Ride".uppercased())
                    .padding()
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.size.width - 32, height: 50)
                    .foregroundColor(.white)
                    .background(Color(.blue))
                    .cornerRadius(10)
            }
        }//:VSTACK
        .background(Color(.white))
    }
}

struct RiderequestView_Preview: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
