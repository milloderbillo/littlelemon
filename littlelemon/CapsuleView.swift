//
//  CapsuleView.swift
//  littlelemon
//
//  Created by Milo Edelbi on 16.05.23.
//

import SwiftUI

struct CapsuleView: View {
    let category: String
    let isTapped: Bool
    var body: some View {
        ZStack{
            Capsule()
                .foregroundColor(Color(hex: isTapped ? "#495E57" : "#EDEFEE"))
            Text("\(category.capitalized)")
                .font(.custom("Karla-Bold", size: 15))
                .padding(10)
                .foregroundColor(Color(hex: isTapped ? "#EDEFEE" : "#333333"))
        }
    }
}
