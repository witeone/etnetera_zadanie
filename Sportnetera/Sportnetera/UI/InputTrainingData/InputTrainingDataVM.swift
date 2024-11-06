//
//  InputTrainingDataVM.swift
//  Sportnetera
//
//  Created by Marek Polak on 05/11/2024.
//

import Foundation
import Combine

class InputTrainingDataVM: ObservableObject {
    @Published var training: String = ""
    @Published var place: String = ""
    @Published var date: Date = Date()
    @Published var length: String = ""
    @Published var storeLocally = false

    init() {

    }

    public func submit() {
        
    }
}
