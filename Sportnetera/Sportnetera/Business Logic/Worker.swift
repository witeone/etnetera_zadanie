//
//  Worker.swift
//  Sportnetera
//
//  Created by Marek Polak on 06/11/2024.
//

import Foundation
import Combine
import FirebaseDatabase

public typealias BusinessLogic = Worker

public class Worker {
    public let bag = CancelBag()
    public let database = Persistence.shared.database

    public static func current() -> Worker {
        .init(
            queue: .init(label: "main_app_queue")
        )
    }

#if DEBUG
    private var debugQueue: DispatchQueue
    public var queue: DispatchQueue {
        debugQueue.async { [weak self] in
            Thread.current.name = self?.debugQueue.label
            if Thread.isMainThread {
                fatalError("Worker can't operate on main thread")
            }
        }
        return debugQueue
    }
#else
    let queue: DispatchQueue
#endif
    private static let defaultQueue = DispatchQueue(label: "default_api_task_queue")

    init(queue: DispatchQueue = defaultQueue) {
#if DEBUG
        self.debugQueue = queue
#else
        self.queue = queue
#endif
    }
}

extension Worker {
    var trainingManager: TrainingDataUseCaseType { self }
}
