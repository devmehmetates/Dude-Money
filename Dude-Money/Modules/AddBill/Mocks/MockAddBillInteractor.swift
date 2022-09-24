//
//  MockAddBillInteractor.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 24.09.2022.
//

final class MockAddBillInteractor: AddBillInteractorInterface {

    var invokedReadPeopleGetter = false
    var invokedReadPeopleGetterCount = 0
    var stubbedReadPeople: People!

    var readPeople: People? {
        invokedReadPeopleGetter = true
        invokedReadPeopleGetterCount += 1
        return stubbedReadPeople
    }

    var invokedSavePeople = false
    var invokedSavePeopleCount = 0
    var invokedSavePeopleParameters: (people: People?, Void)?
    var invokedSavePeopleParametersList = [(people: People?, Void)]()

    func savePeople(_ people: People?) {
        invokedSavePeople = true
        invokedSavePeopleCount += 1
        invokedSavePeopleParameters = (people, ())
        invokedSavePeopleParametersList.append((people, ()))
    }
}
