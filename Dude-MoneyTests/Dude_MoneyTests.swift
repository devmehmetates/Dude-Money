//
//  Dude_MoneyTests.swift
//  Dude-MoneyTests
//
//  Created by Mehmet Ateş on 28.08.2022.
//

import XCTest
@testable import Dude_Money

class Dude_MoneyTests: XCTestCase {
    private var summaryRouter: MockSummaryRouter!
    private var summaryInteractor: MockSummaryInteractor!
    private var summaryPresenter: MockSummaryPresenter!

    override func setUpWithError() throws {
        try super.setUpWithError()
        summaryRouter = MockSummaryRouter()
        summaryInteractor = MockSummaryInteractor()
        summaryPresenter = MockSummaryPresenter()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        summaryRouter = nil
        summaryInteractor = nil
        summaryPresenter = nil
    }

    func testRouterPopView() {
        summaryRouter.popView()
        XCTAssertTrue(summaryRouter.invokedPopView)
        XCTAssertTrue(summaryRouter.invokedPopViewCount == 1)
    }
    
    func testInteractorGetPeople() {
        let _ = summaryInteractor.people
        XCTAssertTrue(summaryInteractor.invokedPeopleGetter)
        XCTAssertTrue(summaryInteractor.invokedPeopleGetterCount == 1)
    }
    
    func testPresenterSectionCount() {
        let _ = summaryPresenter.getSectionCount
        XCTAssertTrue(summaryPresenter.invokedGetSectionCountGetter)
        XCTAssertTrue(summaryPresenter.invokedGetSectionCountGetterCount == 1)
    }
}
