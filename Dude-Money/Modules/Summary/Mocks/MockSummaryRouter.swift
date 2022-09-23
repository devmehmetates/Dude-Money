//
//  MockSummaryRouter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 30.08.2022.
//

import Foundation

final class MockSummaryRouter: SummaryRouterInterface {

    var invokedPopView = false
    var invokedPopViewCount = 0

    func popView() {
        invokedPopView = true
        invokedPopViewCount += 1
    }

    var invokedPresentAddBill = false
    var invokedPresentAddBillCount = 0

    func presentAddBill() {
        invokedPresentAddBill = true
        invokedPresentAddBillCount += 1
    }
}
