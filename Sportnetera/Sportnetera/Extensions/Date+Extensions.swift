//
//  Date+Extensions.swift
//  Sportnetera
//
//  Created by Marek Polak on 08/11/2024.
//

import Foundation

extension Date {
    var millisecondsSince1970: Int64 {
        Int64(self.timeIntervalSince1970 * 1000)
    }
}
