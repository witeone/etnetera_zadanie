//
//  RLMTrainingModel.swift
//  Sportnetera
//
//  Created by Marek Polak on 06/11/2024.
//

import Foundation
import RealmSwift

class RLMTrainingModel: Object, MirrorableType {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var location: String
    @Persisted var length: Int
    @Persisted var date: Int64
    @Persisted var isRemote: Bool

    convenience init(id: String, name: String, location: String, length: Int, date: Int64, isRemote: Bool) {
        self.init()
        self.id = id
        self.name = name
        self.location = location
        self.length = length
        self.date = date
        self.isRemote = isRemote
    }

    func mirror() throws -> TrainingModel {
        .init(id: id, name: name, location: location, length: length, date: date, isRemote: isRemote)
    }
}
