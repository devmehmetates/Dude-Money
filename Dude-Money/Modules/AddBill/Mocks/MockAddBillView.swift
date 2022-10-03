//
//  MockAddBillView.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 24.09.2022.
//

import UIKit

final class MockAddBillView: AddBillViewInterface {

    var invokedConfigureFriendPullDownButton = false
    var invokedConfigureFriendPullDownButtonCount = 0
    var invokedConfigureFriendPullDownButtonParameters: (friends: [People], Void)?
    var invokedConfigureFriendPullDownButtonParametersList = [(friends: [People], Void)]()

    func configureFriendPullDownButton(_ friends: [People]) {
        invokedConfigureFriendPullDownButton = true
        invokedConfigureFriendPullDownButtonCount += 1
        invokedConfigureFriendPullDownButtonParameters = (friends, ())
        invokedConfigureFriendPullDownButtonParametersList.append((friends, ()))
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

