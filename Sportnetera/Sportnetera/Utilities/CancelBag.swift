//
//  CancelBag.swift
//  Sportnetera
//
//  Created by Marek Polak on 06/11/2024.
//

import Foundation
import Combine

open class CancelBag {
    var subscriptions = Set<AnyCancellable>()

    public init() {

    }

    open func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }

    open func collect(@Builder _ cancellables: () -> [AnyCancellable]) {
        subscriptions.formUnion(cancellables())
    }

    @resultBuilder
    public struct Builder {
        public static func buildBlock(_ cancellables: AnyCancellable...) -> [AnyCancellable] {
            return cancellables
        }
    }
}

public extension AnyCancellable {

    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
