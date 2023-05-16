//
//  HeroView.swift
//  littlelemon
//
//  Created by Milo Edelbi on 16.05.23.
//

import SwiftUI

struct HeroView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(hex: "#495E57"))

                HStack{
                    VStack(alignment: .leading, spacing: 0){
                        Text("Little Lemon")
                            .font(.custom("MarkaziText-Medium", size: 50))
                            .foregroundColor(Color(hex: "#F4CE14"))
                            .padding(0)
                        Text("Chicago")
                            .font(.custom("MarkaziText-Medium", size: 40))
                            .foregroundColor(Color(hex: "#EDEFEE"))
                            .padding(0)
                            .offset(y: -10)
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                            .font(.custom("Karla-Regular", size: 20))
                            .foregroundColor(Color(hex: "#EDEFEE"))
                            .padding(.top, 20)
                    }
                    Image("Hero image")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 120)
                        .mask {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxHeight: 120)
                        }
                        .offset(y: 40)
                }
                .padding([.leading, .trailing, .bottom], 10)
        }
    }
}
