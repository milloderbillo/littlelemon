//
//  UserProfile.swift
//  littlelemon
//
//  Created by Milo Edelbi on 29.03.23.
//

import SwiftUI

struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    let firstName = UserDefaults.standard.string(forKey: firstNameKey)
    let lastName = UserDefaults.standard.string(forKey: lastNameKey)
    let email = UserDefaults.standard.string(forKey: emailKey)
    var body: some View {
        
        VStack{
            
            ZStack{
                HStack{
                    Spacer()
                    Image("Profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                }
                .padding()
                
                HStack{
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200)
                        .padding(.trailing, 15)
                    Spacer()
                }
            }
            
            VStack{
                HStack{
                    Text("Personal Information")
                        .font(.custom("Karla-Bold", size: 20))
                    Spacer()
                }
                .padding()
                VStack( alignment: .leading, spacing: 5){
                    Text("Avatar")
                        .font(.custom("Karla-Regular.ttf", size: 15))
                        .foregroundColor(.gray)
                    HStack{
                        Image("Profile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                        Button("Change") {
                            
                        }
                        .font(.custom("Karla-Bold", size: 16))
                        .buttonStyle(greenFilledButton())
                        .padding(5)
                        
                        Button("Remove") {
                            
                        }
                        .font(.custom("Karla-Regular", size: 16))
                        .buttonStyle(greenBorderButton())
                        .foregroundColor(Color(hex: "#333333"))
                        .padding(5)
                    }
                }
                Text(firstName ?? "?")
                Text(lastName ?? "?")
                Text(email ?? "?")
                
                Button {
                    UserDefaults.standard.setValue(false, forKey: isLoggedInKey)
                    UserDefaults.standard.removeObject(forKey: firstNameKey)
                    UserDefaults.standard.removeObject(forKey: lastNameKey)
                    UserDefaults.standard.removeObject(forKey: emailKey)
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Text("Log out")
                        .font(.custom("Karla-Bold", size: 16))
                }
                .buttonStyle(yellowButtonStyle())
                
                Spacer()
            }
            .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
            .padding([.leading, .trailing])
            
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
