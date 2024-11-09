//
//  InputFieldView.swift
//  Sportnetera
//
//  Created by Marek Polak on 09/11/2024.
//

import SwiftUI

struct InputFieldView: View {
    var text: Binding<String>
    var icon: String
    var placeholder: String
    var description: String?
    var keyboardType: UIKeyboardType = .default
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)

                TextField(text: text) {
                    Text(placeholder)
                }
                .font(.headline)
                .keyboardType(keyboardType)
                .submitLabel(.done)
                .scrollDismissesKeyboard(.immediately)
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20, style: RoundedCornerStyle.continuous)
                    .stroke(.gray.opacity(0.5), lineWidth: 1)
            }

            if let description {
                Text(description)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    InputFieldView(text: .constant(""), icon: "pencil.line", placeholder: "Name", description: "Zadajte miesto, kde ste trénovali")
}
