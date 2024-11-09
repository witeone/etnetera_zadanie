//
//  ContentView.swift
//  Sportnetera
//
//  Created by Marek Polak on 05/11/2024.
//

import SwiftUI
import CoreData

struct DashboardView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: DashboardVM

    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                VStack {
                    ProgressView()
                    Text("Načítavam záznamy...")
                }
            }
            else if viewModel.trainingData.isEmpty {
                VStack {
                    Text("Používateľ zatiaľ nevytvoril žiadne tréningové záznamy. Akonáhle pridáte prvý záznam, bude tu dostupný prehľad aktivít a pokrokov.")
                        .font(.subheadline)
                        .padding()

                    Button {
                        router.navigate(to: .inputData)
                    } label: {
                        Text("Pridať tréningový záznam")
                    }
                }
            } else {
                List {
                    ForEach(viewModel.data) { item in
                        DashboardListItemView(model: item)
                    }
                    .onDelete(perform: viewModel.removeItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            viewModel.nextFilterState()
                        } label: {
                            HStack {
                                if let color = viewModel.filter.color {

                                    Circle().frame(width: 10, height: 10)
                                        .foregroundStyle(color)
                                }
                                Text(viewModel.filter.rawValue)
                            }
                        }

                    }
                    ToolbarItem {
                        Button(action: {
                            router.navigate(to: .inputData)
                        }) {
                            HStack(alignment: .center) {
                                Text("Pridať záznam")

                                Image(systemName: "plus")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    DashboardView(viewModel: .init())
}
