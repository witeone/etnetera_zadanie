//
//  TrainingDataUseCase.swift
//  Sportnetera
//
//  Created by Marek Polak on 06/11/2024.
//

import Foundation
import RealmSwift
import Combine

protocol TrainingDataUseCaseType {
    func saveTrainingData(_ trainingData: TrainingModel)
    func fetchTrainingData() -> AnyPublisher<[TrainingModel], AppError>
    func removeTrainingData(_ trainingData: TrainingModel) -> AnyPublisher<Void, AppError>
}

extension Worker: TrainingDataUseCaseType {
    func removeTrainingData(_ trainingData: TrainingModel) -> AnyPublisher<Void, AppError> {
        Future { promise in
            if !trainingData.isRemote,
               let realm = try? Realm(),
               let mirror = try? trainingData.mirror() {
                realm.delete(mirror)
                promise(.success(()))
            } else {
                self.database.child("trainings/\(trainingData.id)").removeValue() { error, _ in
                    if error != nil {
                        promise(.failure(.firebaseDeleteError))
                    } else {
                        promise(.success(()))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func saveTrainingData(_ trainingData: TrainingModel) {
        if !trainingData.isRemote,
           let mirror = try? trainingData.mirror(),
           let realm = try? Realm() {
            try? realm.write {
                realm.add(mirror)
            }
        } else {
            database.child("trainings/\(trainingData.id)").setValue(trainingData.createDic())
        }
    }

    func fetchTrainingData() -> AnyPublisher<[TrainingModel], AppError> {
        Future { promise in
            self.database.child("trainings/").observe(.value) { snapshot  in
                if let result = try? JSONDecoder().decode([TrainingModel].self, from: snapshot.listToJSON) {
                    promise(.success(result))
                } else {
                    promise(.failure(.firebaseDecoding))
                }
            }
        }.eraseToAnyPublisher()
    }
}
