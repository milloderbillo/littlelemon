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

struct Onboarding: View {
    
    @State var isLoggedIn: Bool = false
    @State var email = ""
    @State var firstName = ""
    @State var lastName = ""
    
    var body: some View {
        
        NavigationView {
            VStack{
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                
                Button {
                    if(email.isEmpty || firstName.isEmpty || lastName.isEmpty && isValidEmail(email)){
                        
                        UserDefaults.standard.set(firstName, forKey: firstNameKey)
                        UserDefaults.standard.set(lastName, forKey: lastNameKey)
                        UserDefaults.standard.set(email, forKey: emailKey)
                    }else{
                        isLoggedIn = true
                    }
                } label: {
                    Text("Register")
                }

            }
            .navigationTitle("Onboarding")
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
