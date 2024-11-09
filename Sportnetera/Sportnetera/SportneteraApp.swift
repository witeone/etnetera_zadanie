//
//  SportneteraApp.swift
//  Sportnetera
//
//  Created by Marek Polak on 05/11/2024.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct SportneteraApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject var router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                DashboardView(viewModel: .init())
                    .navigationDestination(for: Router.Destination.self) { route in
                        switch route {
                        case .inputData:
                            InputTrainingDataView(viewModel: .init())
                        case .detail:
                            InputTrainingDataView(viewModel: .init())
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
