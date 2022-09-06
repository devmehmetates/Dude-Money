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
    private var summaryInteractor: MockSummaryInteractor!
    private var summaryView: MockSummaryView!
    private var summaryPresenter: SummaryPresenterInterface!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        summaryRouter = MockSummaryRouter()
        summaryInteractor = MockSummaryInteractor()
        summaryView = MockSummaryView()
        summaryPresenter = SummaryPresenter(view: summaryView, router: summaryRouter, interactor: summaryInteractor)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        summaryRouter = nil
        summaryInteractor = nil
        summaryView = nil
        summaryPresenter = nil
    }
    
    func testGetUserProfileIcon() {
        XCTAssertNil(summaryPresenter.getUserProfileIcon)
        summaryInteractor.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertNotNil(summaryPresenter.getUserProfileIcon)
    }
    
    func testGetReceivablesCount() {
        XCTAssertEqual(summaryPresenter.getReceivablesCount, 1)
        summaryInteractor.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertEqual(summaryPresenter.getReceivablesCount, 3)
    }
    
    func testGetReceivablesIsEmpty() {
        XCTAssertNil(summaryPresenter.getReceivablesIsEmpty)
        summaryInteractor.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertNotNil(summaryPresenter.getReceivablesIsEmpty)
        XCTAssertFalse(summaryPresenter.getReceivablesIsEmpty!)
    }
    
    func testGetDebtsCount() {
        XCTAssertEqual(summaryPresenter.getDebtsCount, 1)
        summaryInteractor.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertEqual(summaryPresenter.getDebtsCount, 3)
    }
    
    func testGetDebtsIsEmpty() {
        XCTAssertNil(summaryPresenter.getDebtIsEmpty)
        summaryInteractor.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertNotNil(summaryPresenter.getDebtIsEmpty)
        XCTAssertFalse(summaryPresenter.getDebtIsEmpty!)
    }
    
    func testGetUserBalance() {
        XCTAssertNil(summaryPresenter.getUserBalance)
        summaryInteractor.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertNotNil(summaryPresenter.getUserBalance)
        XCTAssertEqual(summaryPresenter.getUserBalance, 100.0)
    }
    
    func testGetSectionCount() {
        XCTAssertEqual(summaryPresenter.getSectionCount, 3)
    }
    
    func testGetDebtDataByIndex() {
        XCTAssertNil(summaryPresenter.getDebtDataByIndex(0))
        summaryInteractor.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertNotNil(summaryPresenter.getDebtDataByIndex(0))
    }
    
    func testGetReceivablesDataByIndex() {
        XCTAssertNil(summaryPresenter.getReceivablesDataByIndex(0))
        summaryInteractor.stubbedReadUserResult = People.exampleModel
        summaryPresenter.fetchPeople()
        XCTAssertNotNil(summaryPresenter.getReceivablesDataByIndex(0))
    }
    
    func testFetchPeople() {
        summaryPresenter.fetchPeople()
        XCTAssertTrue(summaryInteractor.invokedReadUser)
    }
    
    func testNotifyViewDidLoad() {
        summaryPresenter.notifyViewLoaded()
        XCTAssertTrue(summaryView.invokedSetupToolbar)
        XCTAssertTrue(summaryView.invokedSetupView)
    }
}
