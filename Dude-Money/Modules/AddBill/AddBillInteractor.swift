//
//  AddBillInteractor.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 19.08.2022.
//

import Foundation

protocol AddBillInteractorInterface: AnyObject {
    var readPeople: People? { get }
}

final class AddBillInteractor { }

extension AddBillInteractor: AddBillInteractorInterface {
    var readPeople: People? {
        get {
            LocalSaveService.readUser()
        }
    }
}
