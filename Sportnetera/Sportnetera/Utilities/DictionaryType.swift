//
//  DictionaryType.swift
//  Sportnetera
//
//  Created by Marek Polak on 08/11/2024.
//

import Foundation

protocol DictionaryType: Codable {
    func createDic() -> [String: Any]?
}


extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments)
        ).flatMap { $0 as? [String: Any] }
    }
}
