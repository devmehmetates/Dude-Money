//
//  MockSummaryPresenter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 30.08.2022.
//

import Foundation

final class MockSummaryPresenter: SummaryPresenterInterface {

    var invokedGetSectionCountGetter = false
    var invokedGetSectionCountGetterCount = 0
    var stubbedGetSectionCount: Int! = 0

    var getSectionCount: Int {
        invokedGetSectionCountGetter = true
        invokedGetSectionCountGetterCount += 1
        return stubbedGetSectionCount
    }

    var invokedGetUserProfileIconGetter = false
    var invokedGetUserProfileIconGetterCount = 0
    var stubbedGetUserProfileIcon: String!

    var getUserProfileIcon: String? {
        invokedGetUserProfileIconGetter = true
        invokedGetUserProfileIconGetterCount += 1
        return stubbedGetUserProfileIcon
    }

    var invokedGetUserBalanceGetter = false
    var invokedGetUserBalanceGetterCount = 0
    var stubbedGetUserBalance: Double!

    var getUserBalance: Double? {
        invokedGetUserBalanceGetter = true
        invokedGetUserBalanceGetterCount += 1
        return stubbedGetUserBalance
    }

    var invokedGetReceivablesCountGetter = false
    var invokedGetReceivablesCountGetterCount = 0
    var stubbedGetReceivablesCount: Int!

    var getReceivablesCount: Int? {
        invokedGetReceivablesCountGetter = true
        invokedGetReceivablesCountGetterCount += 1
        return stubbedGetReceivablesCount
    }

    var invokedGetReceivablesIsEmptyGetter = false
    var invokedGetReceivablesIsEmptyGetterCount = 0
    var stubbedGetReceivablesIsEmpty: Bool!

    var getReceivablesIsEmpty: Bool? {
        invokedGetReceivablesIsEmptyGetter = true
        invokedGetReceivablesIsEmptyGetterCount += 1
        return stubbedGetReceivablesIsEmpty
    }

    var invokedGetDebtsCountGetter = false
    var invokedGetDebtsCountGetterCount = 0
    var stubbedGetDebtsCount: Int!

    var getDebtsCount: Int? {
        invokedGetDebtsCountGetter = true
        invokedGetDebtsCountGetterCount += 1
        return stubbedGetDebtsCount
    }

    var invokedGetDebtIsEmptyGetter = false
    var invokedGetDebtIsEmptyGetterCount = 0
    var stubbedGetDebtIsEmpty: Bool!

    var getDebtIsEmpty: Bool? {
        invokedGetDebtIsEmptyGetter = true
        invokedGetDebtIsEmptyGetterCount += 1
        return stubbedGetDebtIsEmpty
    }

    var invokedNotifyViewLoaded = false
    var invokedNotifyViewLoadedCount = 0

    func notifyViewLoaded() {
        invokedNotifyViewLoaded = true
        invokedNotifyViewLoadedCount += 1
    }

    var invokedFetchPeople = false
    var invokedFetchPeopleCount = 0

    func fetchPeople() {
        invokedFetchPeople = true
        invokedFetchPeopleCount += 1
    }

    var invokedGetDebtDataByIndex = false
    var invokedGetDebtDataByIndexCount = 0
    var invokedGetDebtDataByIndexParameters: (index: Int, Void)?
    var invokedGetDebtDataByIndexParametersList = [(index: Int, Void)]()
    var stubbedGetDebtDataByIndexResult: (bill: Bill, friend: People)!

    func getDebtDataByIndex(_ index: Int) -> (bill: Bill, friend: People)? {
        invokedGetDebtDataByIndex = true
        invokedGetDebtDataByIndexCount += 1
        invokedGetDebtDataByIndexParameters = (index, ())
        invokedGetDebtDataByIndexParametersList.append((index, ()))
        return stubbedGetDebtDataByIndexResult
    }

    var invokedGetReceivablesDataByIndex = false
    var invokedGetReceivablesDataByIndexCount = 0
    var invokedGetReceivablesDataByIndexParameters: (index: Int, Void)?
    var invokedGetReceivablesDataByIndexParametersList = [(index: Int, Void)]()
    var stubbedGetReceivablesDataByIndexResult: (bill: Bill, friend: People)!

    func getReceivablesDataByIndex(_ index: Int) -> (bill: Bill, friend: People)? {
        invokedGetReceivablesDataByIndex = true
        invokedGetReceivablesDataByIndexCount += 1
        invokedGetReceivablesDataByIndexParameters = (index, ())
        invokedGetReceivablesDataByIndexParametersList.append((index, ()))
        return stubbedGetReceivablesDataByIndexResult
    }
}
