//
//  InputTrainingDataVM.swift
//  Sportnetera
//
//  Created by Marek Polak on 05/11/2024.
//

import Foundation
import Combine

class InputTrainingDataVM: CancellableVM, ObservableObject {
    @Published var name: String = ""
    @Published var location: String = ""
    @Published var date: Date = Date()
    @Published var length: String = ""
    @Published var storeRemotely = false
    @Published var isValid: Bool = false

    override init() {
        super.init()

        Publishers.CombineLatest3($name, $location, $length)
            .receive(on: DispatchQueue.main)
            .map { !$0.isEmpty && !$1.isEmpty && !$2.isEmpty }
            .assign(to: \.isValid, on: self)
            .store(in: bag)
    }

    public func submit(_ completion: @escaping () -> Void) {
        guard let lengthInt = Int(length), isValid else { return }
        let request = TrainingModel(
            id: UUID().uuidString,
            name: name,
            location: location,
            length: lengthInt,
            date: date.millisecondsSince1970,
            isRemote: storeRemotely
        )
        businessLogic.trainingManager.saveTrainingData(request)
        completion()
    }
}
