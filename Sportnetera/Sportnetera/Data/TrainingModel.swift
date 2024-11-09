//
//  TrainingModel.swift
//  Sportnetera
//
//  Created by Marek Polak on 06/11/2024.
//

import Foundation

class TrainingModel: DictionaryType, MirrorableType, Identifiable {

    let id: String
    let name: String
    let location: String
    let length: Int
    let date: Int64
    let isRemote: Bool

    init(id: String, name: String, location: String, length: Int, date: Int64, isRemote: Bool) {
        self.id = id
        self.name = name
        self.location = location
        self.length = length
        self.date = date
        self.isRemote = isRemote
    }

    func createDic() -> [String : Any]? {
        guard let dic = self.dictionary else {
            return nil
        }

        return dic
    }
    
    func mirror() throws -> RLMTrainingModel {
        .init(id: id, name: name, location: location, length: length, date: date, isRemote: isRemote)
    }
}
