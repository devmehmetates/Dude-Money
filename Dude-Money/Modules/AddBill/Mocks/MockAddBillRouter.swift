//
//  MockAddBillRouter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 24.09.2022.
//

final class MockAddBillRouter: AddBillRouterInterface {

    var invokedPopView = false
    var invokedPopViewCount = 0

    func popView() {
        invokedPopView = true
        invokedPopViewCount += 1
    }
}
