//
//  GrowingButtonStyle.swift
//  Sportnetera
//
//  Created by Marek Polak on 09/11/2024.
//

import SwiftUI

struct GrowingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()

            configuration.label
                .fixedSize(horizontal: true, vertical: false)
                .padding()

            Spacer()
        }
        .background(.blue)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .scaleEffect(configuration.isPressed ? 1.2 : 1)
        .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    Button {

    } label: {
        Text("ahoj")
    }.buttonStyle(GrowingButtonStyle())
}
