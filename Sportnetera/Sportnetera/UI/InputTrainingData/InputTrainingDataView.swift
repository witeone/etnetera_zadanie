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
        ScrollView {
            VStack(spacing: 22) {
                
                Text("Na tejto obrazovke môžete zadať informácie o svojom tréningu. Vyplňte názov tréningu, miesto, trvanie a dátum. Tieto údaje vám pomôžu udržiavať prehľad o vašom pokroku a plánovať ďalšie aktivity.")
                    .font(.subheadline)
                
                InputFieldView(text: $viewModel.name, icon: "pencil.line", placeholder: "Zadajte názov tréningu", description: "Názov tréningu by mal byť krátky a výstižný")
                
                InputFieldView(text: $viewModel.location, icon: "location", placeholder: "Zadajte miesto tréningu", description: "Zadajte miesto, kde ste tréning vykonávali.")
                
                InputFieldView(text: $viewModel.length, icon: "figure.run", placeholder: "Zadajte dĺžku tréningu", description: "Dĺžku tréningu zadajte v minútach.", keyboardType: .numberPad)

                Divider()

                DatePicker(selection: $viewModel.date) {
                    Text("Zadajte dátum tréningu")
                        .font(.headline)
                }

                Divider()

                Toggle(isOn: $viewModel.storeRemotely) {
                    VStack(alignment: .leading) {
                        Text("Uložiť online")
                            .font(.headline)
                        
                        Text("Váš tréning sa uloží na online úložisko a bude dostupný na všetkych zariadeniach.")
                            .font(.caption)
                    }
                }.toggleStyle(.switch)

                Divider()

                Button {
                    viewModel.submit {
                        router.navigateToRoot()
                    }
                } label: {
                    Text("Uložiť")
                }
                .disabled(!viewModel.isValid)
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .navigationTitle("Záznam tréningu")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

#Preview {
    InputTrainingDataView(viewModel: .init())
}
