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
            .background(Color(hex: "#495E57"))
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

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct searchViewTesting: View{
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(hex: "#495E57"))
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(hex: "#EDEFEE"))
                Spacer()
            }
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct yellowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], 100)
            .padding([.top, .bottom], 15)
            .background(Color(hex: "#F4CE14"))
            .foregroundColor(Color(hex: "#333333"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct greenFilledButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(hex: "#495E57"))
            .foregroundColor(Color(hex: "#EDEFEE"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct greenBorderButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.white)
            .border(Color(hex: "#495E57"), width: 1)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct contentview_Previews: PreviewProvider {
    static var previews: some View {
        searchViewTesting()
    }
}

extension View {
    func placeholder(
        _ text: String,
        when shouldShow: Bool,
        alignment: Alignment = .leading) -> some View {
            
        placeholder(when: shouldShow, alignment: alignment) { Text(text).foregroundColor(.white) }
    }
}
