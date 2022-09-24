//
//  AddBillPresenterTests.swift
//  Dude-MoneyTests
//
//  Created by Mehmet Ateş on 24.09.2022.
//

import XCTest
@testable import Dude_Money

class AddBillPresenterTests: XCTestCase {
    
    private var addBillView: MockAddBillView!
    private var addBillRouter: MockAddBillRouter!
    private var addBillInteractor: MockAddBillInteractor!
    private var addBillPresenter: AddBillPresenterInterface!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        addBillView = MockAddBillView()
        addBillRouter = MockAddBillRouter()
        addBillInteractor = MockAddBillInteractor()
        addBillPresenter = AddBillPresenter(view: addBillView, router: addBillRouter, interactor: addBillInteractor)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        addBillView = nil
        addBillRouter = nil
        addBillInteractor = nil
        addBillPresenter = nil
    }
    
    func testAddBill() {
        XCTAssertFalse(addBillInteractor.invokedSavePeople)
        XCTAssertFalse(addBillRouter.invokedPopView)
        addBillPresenter.notifyViewLoaded()
        addBillPresenter.addBill(whose: "friend", amount: "100", type: .Debt)
        XCTAssertTrue(addBillInteractor.invokedSavePeople)
        XCTAssertTrue(addBillRouter.invokedPopView)
    }
}

