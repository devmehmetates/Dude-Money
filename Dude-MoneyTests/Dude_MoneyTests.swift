//
//  Dude_MoneyTests.swift
//  Dude-MoneyTests
//
//  Created by Mehmet Ateş on 28.08.2022.
//

import XCTest
@testable import Dude_Money

class Dude_MoneyTests: XCTestCase {
    private var summaryPresenter: SummaryPresenterInterface!

    override func setUpWithError() throws {
        try super.setUpWithError()
        summaryPresenter = SummaryRouter.createModule(using: UINavigationController()).presenter
        summaryPresenter.fetchPeople()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        summaryPresenter = nil
    }

    func testPresenterSectionCount() throws {
        XCTAssertTrue(summaryPresenter.getSectionCount == 3)
    }
    
    func testPresenterDebtIsEmpty() throws {
        XCTAssertTrue(summaryPresenter.getDebtIsEmpty != nil)
    }
    
    func testPresenterReceivablesIsEmpty() throws {
        XCTAssertTrue(summaryPresenter.getReceivablesIsEmpty != nil)
    }
}
