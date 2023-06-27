//
//  Onboarding.swift
//  littlelemon
//
//  Created by Milo Edelbi on 23.03.23.
//

import SwiftUI

let firstNameKey = "first name key"
let lastNameKey = "last name key"
let emailKey = "email name key"
let isLoggedInKey = "is logged in key"

struct Onboarding: View {
    
    @State var email = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var isLoggedIn = false
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 20){
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
                Image("LogoPortait")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200)
                
                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundTextFieldStyle())
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundTextFieldStyle())
                TextField("Email", text: $email)
                    .textFieldStyle(RoundTextFieldStyle())
                
                Button {
                    if(!email.isEmpty && !firstName.isEmpty && !lastName.isEmpty && isValidEmail(email)){
                        
                        UserDefaults.standard.set(firstName, forKey: firstNameKey)
                        UserDefaults.standard.set(lastName, forKey: lastNameKey)
                        UserDefaults.standard.set(email, forKey: emailKey)
                    }
                    UserDefaults.standard.set(true, forKey: isLoggedInKey)
                    isLoggedIn = true
                } label: {
                    Text("Register")
                        .font(.custom("Karla-Regular", size: 20))
                }
                .buttonStyle(RoundedButtonStyle())
                
                Spacer()
            }
            .onAppear{
                if UserDefaults.standard.bool(forKey: isLoggedInKey){
                    isLoggedIn = true
                }
            }
            .padding(10)
//            .navigationTitle("Onboarding")
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }
    
}

struct Onbording_Preview: PreviewProvider {
    
    static var previews: some View {
        Onboarding()
    }
    
}
