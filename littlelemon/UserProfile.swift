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
            Text("Personal Information")
            Image("Profile")
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
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
