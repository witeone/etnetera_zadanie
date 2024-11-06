//
//  InputTrainingDataView.swift
//  Sportnetera
//
//  Created by Marek Polak on 05/11/2024.
//

import SwiftUI

struct InputTrainingDataView: View {
    @ObservedObject var viewModel: InputTrainingDataVM
    @EnvironmentObject var router: Router

    var body: some View {
        VStack {
            TextField(text: $viewModel.training) {
                Text("Zadajte názov tréningu")
            }
            .padding()
            .border(Color.gray)

            TextField(text: $viewModel.place) {
                Text("Zadajte miesto tréningu")
            }
            .padding()
            .border(Color.gray)

            TextField(text: $viewModel.length) {
                Text("Zadajte dĺžku tréningu")
            }
            .padding()
            .border(Color.gray)

            DatePicker(selection: $viewModel.date) {
                Text("Zadajte dátum tréningu")
            }

            Button {
                viewModel.submit()
            } label: {
                Text("Uložiť")
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    InputTrainingDataView(viewModel: .init())
}
