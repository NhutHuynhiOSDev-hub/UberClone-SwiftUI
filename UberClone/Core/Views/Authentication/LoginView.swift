//
//  LoginView.swift
//  UberClone
//
//  Created by Nhut Huynh Quang on 14/9/25.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: PROPERTIES
    @State var email = ""
    @State var password = ""
    
    //MARK: BODY
    var body: some View {
        ZStack {
            Color(Color.theme.backgroundColor)
                .ignoresSafeArea(.all)
                
            VStack {
                // Image & Title
                Image("uber_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Text("Uber".uppercased())
                    .foregroundStyle(Color.theme.primaryTextColor)
                    .font(.largeTitle)
                
                // Input fields
                VStack(spacing: 32) {
                    VStack(alignment: .leading) {
                        // Title
                        Text("Email Address")
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .fontWeight(.semibold)
                            .font(.footnote)
                        
                        // Text Field
                        TextField("email.com", text: $email)
                            .foregroundStyle(Color.theme.primaryTextColor)
                        
                        Rectangle()
                            .foregroundStyle(Color.theme.primaryTextColor.opacity(0.3))
                            .frame(width: UIScreen.main.bounds.size.width - 32, height: 0.7)
                    }
                    
                    VStack(alignment: .leading) {
                        // Title
                        Text("Password")
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .fontWeight(.semibold)
                            .font(.footnote)
                        
                        // Text Field
                        TextField("", text: $password)
                            .foregroundStyle(Color.theme.primaryTextColor)
                        
                        Rectangle()
                            .foregroundStyle(Color.theme.primaryTextColor.opacity(0.3))
                            .frame(width: UIScreen.main.bounds.size.width - 32, height: 0.7)
                    }
                    
                    // Forgot pass
                    Button {
                        
                    } label: {
                        Text("Forgot Password?")
                            .font(.system(size: 13).weight(.semibold))
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .padding(.top)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.top, 12)
                .padding(.horizontal)
                
                // Social login
                VStack {
                    // Divider + text
                    HStack(spacing: 24) {
                        Rectangle()
                            .frame(width: 76, height: 1)
                            .foregroundStyle(Color.theme.primaryTextColor.opacity(0.3))
                        
                        Text("Sign in with social")
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .fontWeight(.semibold)
                        
                        Rectangle()
                            .frame(width: 76, height: 1)
                            .foregroundStyle(Color.theme.primaryTextColor.opacity(0.3))
                    
                    }
                    
                    HStack(spacing: 24) {
                        Button {
                            
                        } label: {
                            Image("fb_signin_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 38, height: 38)
                        }
                        
                        Button {
                            
                        } label: {
                            Image("gg_signin_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 38, height: 38)
                        }
                    }
                }
                .padding(.vertical)
                
                Spacer()
                
                // Signin button
                Button {
                    
                } label: {
                    HStack(spacing: 8) {
                        Text("Sign in".uppercased())
                            .foregroundStyle(Color.theme.backgroundColor)
                        Image(systemName: "arrow.right")
                            .foregroundStyle(Color.theme.backgroundColor)
                    }
                }
                .frame(width: UIScreen.main.bounds.size.width - 32, height: 50)
                .background(Color.theme.primaryTextColor)
                .cornerRadius(10)
                
                Spacer()
                
                // Signup button
                Button {
                    
                } label: {
                    HStack(spacing: 8) {
                        Text("Don't have an account?")
                            .font(.system(size: 15))
                            
                        Text("Sign Up")
                            .font(.system(size: 15).weight(.semibold))
                    }
                    .foregroundStyle(Color.theme.primaryTextColor)
                }   
            }
        }
    }
}

//MARK: PREVIEW
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
