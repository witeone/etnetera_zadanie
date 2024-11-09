//
//  DashboardVM.swift
//  Sportnetera
//
//  Created by Marek Polak on 06/11/2024.
//

import Foundation
import Combine
import SwiftUI

class DashboardVM: CancellableVM, ObservableObject {
    @Published private(set)var trainingData = [TrainingModel]()
    @Published var data = [TrainingModel]()
    @Published var filter: Filter = .all
    @Published var isLoading: Bool = false

    override init() {
        super.init()

        isLoading = true
        businessLogic
            .observe(object: RLMTrainingModel.self, holder: self, path: \.rlmToken)?
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] result in
                self?.trainingData.append(contentsOf: result)
            }
            .store(in: bag)

        businessLogic
            .trainingManager
            .fetchTrainingData()
            .sink { [weak self] error in
                self?.isLoading = false
                print(error)
            } receiveValue: { [weak self] result in
                self?.isLoading = false
                self?.trainingData.append(contentsOf: result)
            }.store(in: bag)

        Publishers.CombineLatest($trainingData, $filter)
            .receive(on: DispatchQueue.main)
            .map { data, filter in
                switch filter {
                case .all: return data
                case .remote: return data.filter(\.isRemote)
                case .local: return data.filter { !$0.isRemote }
                }
            }
            .assign(to: \.data, on: self)
            .store(in: bag)
    }

    func nextFilterState() {
        switch filter {
        case .all: filter = .remote
        case .remote: filter = .local
        case .local: filter = .all
        }
    }

    func removeItems(at offsets: IndexSet) {
        if let firstIndex = offsets.first {
            let item = trainingData[firstIndex]
            businessLogic
                .trainingManager
                .removeTrainingData(item)
                .sink { error in
                    print(error)
                } receiveValue: { [weak self] _ in
                    self?.trainingData.removeAll(where: { model in
                        model.id == item.id
                    })
                }
                .store(in: bag)

        }
    }
}

extension DashboardVM {
    enum Filter: String {
        case all = "Všetky", 
             remote = "Online",
             local = "Lokálne"

        var color: Color? {
            switch self {
            case .all: return nil
            case .local: return .yellow
            case .remote: return .green
            }
        }
    }
}
