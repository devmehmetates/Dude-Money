//
//  AddBillInteractor.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 19.08.2022.
//

import Foundation

protocol AddBillInteractorInterface: AnyObject {
    var readPeople: People? { get }
    func savePeople(_ people: People?)
}

final class AddBillInteractor { }

extension AddBillInteractor: AddBillInteractorInterface {

    func savePeople(_ people: People?) {
        guard let people = people else { return }
        LocalSaveService.saveUser(people)
    }
    
    var readPeople: People? {
        get {
            LocalSaveService.readUser()
        }
    }
}
