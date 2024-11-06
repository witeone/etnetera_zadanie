//
//  SportneteraApp.swift
//  Sportnetera
//
//  Created by Marek Polak on 05/11/2024.
//

import SwiftUI

@main
struct SportneteraApp: App {
    let persistenceController = PersistenceController.shared
    @ObservedObject var router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                ContentView()
                    .navigationDestination(for: Router.Destination.self) { route in
                        switch route {
                        case .inputData:
                            InputTrainingDataView(viewModel: .init())
                        case .detail:
                            InputTrainingDataView(viewModel: .init())
                        }
                    }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .environmentObject(router)
        }
    }
}
