//
//  SummaryPresenterTests.swift
//  SummaryPresenterTests
//
//  Created by Mehmet Ateş on 28.08.2022.
//

import XCTest
@testable import Dude_Money

class SummaryPresenterTests: XCTestCase {
    
    private var summaryRouter: MockSummaryRouter!
    private var summaryManager: MockSummaryManager!
    private var summaryView: MockSummaryView!
    private var summaryPresenter: SummaryPresenterInterface!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        summaryRouter = MockSummaryRouter()
        summaryManager = MockSummaryManager()
        summaryView = MockSummaryView()
        summaryPresenter = SummaryPresenter(view: summaryView, router: summaryRouter, manager: summaryManager)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        summaryRouter = nil
        summaryManager = nil
        summaryView = nil
        summaryPresenter = nil
    }
    
    func testNotifyViewWillAppear() {
        XCTAssertFalse(summaryView.invokedReloadData)
        summaryPresenter.notifyViewWillAppear()
        XCTAssertTrue(summaryView.invokedReloadData)
    }
    
    func testGetUserProfileIcon() {
        XCTAssertEqual(summaryPresenter.getUserProfileIcon, "")
        summaryManager.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertEqual(summaryPresenter.getUserProfileIcon, "example4")
    }
    
    func testGetReceivablesCount() {
        XCTAssertEqual(summaryPresenter.getReceivablesCount, 1)
        summaryManager.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertEqual(summaryPresenter.getReceivablesCount, 3)
    }
    
    func testGetReceivablesIsEmpty() {
        XCTAssertEqual(summaryPresenter.getReceivablesIsEmpty, false) // default 1 cell
        summaryManager.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertEqual(summaryPresenter.getReceivablesIsEmpty, false) // 3 cell
    }
    
    func testGetDebtsCount() {
        XCTAssertEqual(summaryPresenter.getDebtsCount, 1)
        summaryManager.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertEqual(summaryPresenter.getDebtsCount, 3)
    }
    
    func testGetDebtsIsEmpty() {
        XCTAssertEqual(summaryPresenter.getDebtIsEmpty, false) // default 1 cell
        summaryManager.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertEqual(summaryPresenter.getDebtIsEmpty, false) // 3 cell
    }
    
    func testGetUserBalance() {
        XCTAssertEqual(summaryPresenter.getUserBalance, 0.0)
        summaryManager.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertEqual(summaryPresenter.getUserBalance, 100.0)
    }
    
    func testGetSectionCount() {
        XCTAssertEqual(summaryPresenter.getSectionCount, 3)
    }
    
    func testGetDebtDataByIndex() {
        XCTAssertNil(summaryPresenter.getDebtDataByIndex(0))
        summaryManager.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertEqual(summaryPresenter.getDebtDataByIndex(0)?.bill.ammount, 100)
        XCTAssertEqual(summaryPresenter.getDebtDataByIndex(0)?.friend.username, "friend")
    }
    
    func testGetReceivablesDataByIndex() {
        XCTAssertNil(summaryPresenter.getReceivablesDataByIndex(0))
        summaryManager.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertEqual(summaryPresenter.getReceivablesDataByIndex(0)?.bill.ammount, 100)
        XCTAssertEqual(summaryPresenter.getReceivablesDataByIndex(0)?.friend.username, "friend")
    }
    
    func testFetchPeople() {
        summaryPresenter.fetchPeople()
        XCTAssertTrue(summaryManager.invokedReadUser)
    }
    
    func testNotifyViewDidLoad() {
        XCTAssertFalse(summaryView.invokedSetupToolbar)
        XCTAssertFalse(summaryView.invokedSetupView)
        summaryPresenter.notifyViewLoaded()
        XCTAssertTrue(summaryView.invokedSetupToolbar)
        XCTAssertTrue(summaryView.invokedSetupView)
    }
}
