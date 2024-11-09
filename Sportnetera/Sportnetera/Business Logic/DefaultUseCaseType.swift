//
//  DefaultUseCaseType.swift
//  Sportnetera
//
//  Created by Marek Polak on 09/11/2024.
//

import Foundation
import RealmSwift
import Combine

public protocol DefaultUseCaseType {
    func observe<TokenHolderObject, Out: MirrorableType & Object>(
        object: Out.Type,
        holder: TokenHolderObject,
        path: WritableKeyPath<TokenHolderObject, NotificationToken?>
    ) -> AnyPublisher<[Out.Mirror], Error>?
}

extension Worker: DefaultUseCaseType {
    public func observe<TokenHolderObject, Out: MirrorableType & Object>(
        object: Out.Type,
        holder: TokenHolderObject,
        path: WritableKeyPath<TokenHolderObject, NotificationToken?>
    ) -> AnyPublisher<[Out.Mirror], Error>? {
        try? Realm()
            .objects(object)
            .collectionPublisher
            .subscribe(on: queue)
            .saveToken(on: holder, at: path)
            .threadSafeReference()
            .map({ $0.compactMap({ try? $0.mirror() }) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
