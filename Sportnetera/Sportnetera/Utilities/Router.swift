//
//  Router.swift
//  Sportnetera
//
//  Created by Marek Polak on 05/11/2024.
//

import Foundation
import Combine
import SwiftUI

final class Router: ObservableObject {

    public enum Destination: Codable, Hashable {
        case inputData
        case detail
    }

    @Published var navPath = NavigationPath()

    func navigate(to destination: Destination) {
        navPath.append(destination)
    }

    func navigateBack() {
        navPath.removeLast()
    }

    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
