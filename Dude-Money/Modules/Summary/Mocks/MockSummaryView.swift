//
//  MockSummaryView.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 6.09.2022.
//

import UIKit

final class MockSummaryView: SummaryViewInterface {

    var invokedSetupView = false
    var invokedSetupViewCount = 0

    func setupView() {
        invokedSetupView = true
        invokedSetupViewCount += 1
    }

    var invokedSetupToolbar = false
    var invokedSetupToolbarCount = 0

    func setupToolbar() {
        invokedSetupToolbar = true
        invokedSetupToolbarCount += 1
    }

    var invokedReloadData = false
    var invokedReloadDataCount = 0

    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }
}
