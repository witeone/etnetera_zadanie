//
//  Dictionary+Extension.swift
//  Sportnetera
//
//  Created by Marek Polak on 09/11/2024.
//

import Foundation

extension Dictionary {
    var JSON: Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        } catch {
            return Data()
        }
    }
}
