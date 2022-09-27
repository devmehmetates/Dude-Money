//
//  MockAddBillView.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 24.09.2022.
//

import UIKit

final class MockAddBillView: AddBillViewInterface {

    var invokedCreateFriendUIActions = false
    var invokedCreateFriendUIActionsCount = 0
    var invokedCreateFriendUIActionsParameters: (friends: [People]?, Void)?
    var invokedCreateFriendUIActionsParametersList = [(friends: [People]?, Void)]()
    var stubbedCreateFriendUIActionsResult: [UIMenuElement]! = []

    func createFriendUIActions(_ friends: [People]?) -> [UIMenuElement] {
        invokedCreateFriendUIActions = true
        invokedCreateFriendUIActionsCount += 1
        invokedCreateFriendUIActionsParameters = (friends, ())
        invokedCreateFriendUIActionsParametersList.append((friends, ()))
        return stubbedCreateFriendUIActionsResult
    }

    var invokedConfigureFriendPullDownButton = false
    var invokedConfigureFriendPullDownButtonCount = 0

    func configureFriendPullDownButton() {
        invokedConfigureFriendPullDownButton = true
        invokedConfigureFriendPullDownButtonCount += 1
    }

    var invokedConfigurePriceTpyeSegmentedControlByDebt = false
    var invokedConfigurePriceTpyeSegmentedControlByDebtCount = 0

    func configurePriceTpyeSegmentedControlByDebt() {
        invokedConfigurePriceTpyeSegmentedControlByDebt = true
        invokedConfigurePriceTpyeSegmentedControlByDebtCount += 1
    }

    var invokedConfigurePriceTpyeSegmentedControlByReceivable = false
    var invokedConfigurePriceTpyeSegmentedControlByReceivableCount = 0

    func configurePriceTpyeSegmentedControlByReceivable() {
        invokedConfigurePriceTpyeSegmentedControlByReceivable = true
        invokedConfigurePriceTpyeSegmentedControlByReceivableCount += 1
    }
}

