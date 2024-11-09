//
//  Persistence.swift
//  Sportnetera
//
//  Created by Marek Polak on 08/11/2024.
//

import Foundation
import FirebaseDatabase
import Combine

class Persistence {
    public static let shared = Persistence()
    public let database: DatabaseReference

    private init() {
        database = Database.database().reference(fromURL: "https://flash-chat-530bf.firebaseio.com/")
    }
}

extension DatabaseReference {
    public func toAnyPublisher<T>() -> AnyPublisher<T?, Never> {
        let subject = CurrentValueSubject<T?, Never>(nil)

        let handle = observe(.value, with: { snapshot in
            subject.send(snapshot.value as? T)
        })

        return subject.handleEvents(receiveCancel: {[weak self] in
            self?.removeObserver(withHandle: handle)
        }).eraseToAnyPublisher()
    }
}
