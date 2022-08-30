//
//  MockSummaryInteractor.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 30.08.2022.
//

import Foundation

final class MockSummaryInteractor: SummaryInteractorInterface {

    var invokedPeopleGetter = false
    var invokedPeopleGetterCount = 0
    var stubbedPeople: People!

    var people: People? {
        invokedPeopleGetter = true
        invokedPeopleGetterCount += 1
        return stubbedPeople
    }
}
