//
//  DetailView.swift
//  Sportnetera
//
//  Created by Marek Polak on 09/11/2024.
//

import SwiftUI

struct DetailView: View {
    var data: TrainingModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DetailView(
        data: .init(
            id: "",
            name: "trening",
            location: "doma", length: 45, date: Date().millisecondsSince1970 * 1000, isRemote: true))
}
