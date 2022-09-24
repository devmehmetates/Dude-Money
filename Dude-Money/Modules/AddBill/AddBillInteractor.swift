//
//  AddBillInteractor.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 19.08.2022.
//

import Foundation

protocol AddBillInteractorInterface: AnyObject {
    func savePeople(_ people: People?)
    var readPeople: People? { get }
}

final class AddBillInteractor { }

extension AddBillInteractor: AddBillInteractorInterface {

    func savePeople(_ people: People?) {
        guard let people = people else { return }
        SaveManager.shared.saveUser(people)
    }
    
    var readPeople: People? {
        SaveManager.shared.readUser()
    }
}
