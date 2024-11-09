//
//  MirrorableType.swift
//  Sportnetera
//
//  Created by Marek Polak on 08/11/2024.
//

import Foundation

public protocol MirrorableType {
    associatedtype Mirror
    
    func mirror() throws -> Mirror
}
