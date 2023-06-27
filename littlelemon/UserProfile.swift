//
//  UserProfile.swift
//  littlelemon
//
//  Created by Milo Edelbi on 29.03.23.
//

import SwiftUI

struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    var firstName = UserDefaults.standard.string(forKey: firstNameKey)
    var lastName = UserDefaults.standard.string(forKey: lastNameKey)
    var email = UserDefaults.standard.string(forKey: emailKey)
    
    @State var firstNameTextField: String = ""
    @State var lastNameTextField: String = ""
    @State var emailTextField: String = ""
    
    init() {
        firstNameTextField = self.firstName ?? ""
        lastNameTextField = self.lastName ?? ""
        emailTextField = self.email ?? ""
    }
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
                VStack{
                    HStack{
                        Text("First Name")
                            .font(.custom("Karla-Bold", size: 15))
                            .foregroundColor(Color(hex: "#333333"))
                        Spacer()
                    }
                    TextField(firstName ?? "?", text: $firstNameTextField)
                        .textFieldStyle(RoundTextFieldStyle())
                    HStack{
                        Text("Last Name")
                            .font(.custom("Karla-Bold", size: 15))
                            .foregroundColor(Color(hex: "#333333"))
                        Spacer()
                    }
                    TextField(lastName ?? "?", text: $lastNameTextField)
                        .textFieldStyle(RoundTextFieldStyle())
                    HStack{
                        Text("Email")
                            .font(.custom("Karla-Bold", size: 15))
                            .foregroundColor(Color(hex: "#333333"))
                        Spacer()
                    }
                    TextField(email ?? "?", text: $emailTextField)
                        .textFieldStyle(RoundTextFieldStyle())
                }
                .padding()
                
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
                
                HStack{
                    Button("Discard changes") {
                        
                    }
                    .font(.custom("Karla-Regular", size: 13))
                    .buttonStyle(greenBorderButton())
                    .foregroundColor(Color(hex: "#333333"))
                    .padding(5)
                    
                    Button("Save Changes") {
                        UserDefaults.standard.setValue(firstNameTextField, forKey: firstNameKey)
                        UserDefaults.standard.setValue(lastNameTextField, forKey: lastNameKey)
                        UserDefaults.standard.setValue(emailTextField, forKey: emailKey)
                        
                    }
                    .font(.custom("Karla-Bold", size: 13))
                    .buttonStyle(greenFilledButton())
                    .padding(5)
                }
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
