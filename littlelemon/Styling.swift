//
//  Styling.swift
//  littlelemon
//
//  Created by Milo Edelbi on 01.05.23.
//

import SwiftUI

struct RoundTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray.opacity(0.3), lineWidth: 1)
                    .background(Color.white)
            )
    }
}

struct RoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(.forestGreen))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ContentView: View {
    var body: some View {
        Button("Press Me") {
            print("Button pressed!")
        }
        .buttonStyle(RoundedButtonStyle())
    }
}

extension CGColor {
    public static var forestGreen: CGColor {
        return CGColor(red: 72/255, green: 94/255, blue: 87/255, alpha: 1.0)
    }
}

struct contentview_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
