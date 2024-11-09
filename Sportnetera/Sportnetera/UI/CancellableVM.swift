//
//  BaseVM.swift
//  Sportnetera
//
//  Created by Marek Polak on 06/11/2024.
//

import Foundation
import RealmSwift

protocol CancellableVMType {
    var bag: CancelBag { get }
}

public class CancellableVM: CancellableVMType {
    var bag: CancelBag = CancelBag()

    var businessLogic: BusinessLogic {
        Worker.current()
    }

    var realmBag = Set<NotificationToken?>()
    var rlmToken: NotificationToken? {
        willSet {
            realmBag.insert(newValue)
        }
    }

    public init() {

    }

    deinit {
        bag.cancel()
        realmBag.forEach{( $0?.invalidate() )}
    }
}
