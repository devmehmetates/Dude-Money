//
//  MockSummaryManager.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 30.08.2022.
//

import Foundation

final class MockSummaryManager: SaveManagerInterface {

    var invokedSaveUser = false
    var invokedSaveUserCount = 0
    var invokedSaveUserParameters: (people: People, Void)?
    var invokedSaveUserParametersList = [(people: People, Void)]()

    func saveUser(_ people: People) {
        invokedSaveUser = true
        invokedSaveUserCount += 1
        invokedSaveUserParameters = (people, ())
        invokedSaveUserParametersList.append((people, ()))
    }

    var invokedReadUser = false
    var invokedReadUserCount = 0
    var stubbedReadUserResult: People!

    func readUser() -> People? {
        invokedReadUser = true
        invokedReadUserCount += 1
        return stubbedReadUserResult
    }
}
