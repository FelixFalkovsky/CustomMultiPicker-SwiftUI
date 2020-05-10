//
//  Modifiers.swift
//  CustomMultiPickerSwiftUI
//
//  Created by Felix Falkovsky on 10.05.2020.
//  Copyright © 2020 Felix Falkovsky. All rights reserved.
//

import Foundation
import SwiftUI

//MARK: Style Neumorphic
struct NeumorphicStyleButton: ViewModifier {

    @State var isPressed: Bool = false
    var bgColor = "bgColor"
    var bg = "bg"

    func body(content: Content) -> some View {
        content
            .background(
                Color(bgColor)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.2), radius: 6, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.2), radius: 6, x: -8, y: -8)
                   
        )
            .scaleEffect(self.isPressed ? 0.98: 1)
            .animation(.spring())
    }
}

struct ButtonModifier: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
        .background(Color("bgColor"))
            .cornerRadius(15)
            .overlay(
                VStack {
                if configuration.isPressed {
                     RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black.opacity(0.05), lineWidth: 0.5)
                        .blur(radius: 0.5)
                    .shadow(color: Color.black.opacity(0.2), radius: 3, x: -5, y: -5)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(color: Color.black.opacity(0.2), radius: 3, x: 5, y: 5)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            })
            .shadow(color: Color.black.opacity(configuration.isPressed ? 0 : 0.2), radius: 6, x: 5, y: 5)
            .shadow(color: Color.white.opacity(configuration.isPressed ? 0 : 0.7), radius: 6, x: -5, y: -5)
    }
}
