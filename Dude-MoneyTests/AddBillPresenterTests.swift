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
    private var addBillManager: MockSummaryManager!
    private var addBillPresenter: AddBillPresenterInterface!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        addBillView = MockAddBillView()
        addBillRouter = MockAddBillRouter()
        addBillManager = MockSummaryManager()
        addBillPresenter = AddBillPresenter(view: addBillView, router: addBillRouter, manager: addBillManager)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        addBillView = nil
        addBillRouter = nil
        addBillManager = nil
        addBillPresenter = nil
    }
    
    func test_priceTpyeValueChanged_selectedIndexEqualPriceTypeReceivable_invokedConfigurePriceTpyeSegmentedControlByReceivable() {
        XCTAssertFalse(addBillView.invokedConfigurePriceTpyeSegmentedControlByDebt)
        XCTAssertFalse(addBillView.invokedConfigurePriceTpyeSegmentedControlByReceivable)
        addBillPresenter.priceTpyeValueChanged(PriceType.Receivable.rawValue)
        XCTAssertFalse(addBillView.invokedConfigurePriceTpyeSegmentedControlByDebt)
        XCTAssertTrue(addBillView.invokedConfigurePriceTpyeSegmentedControlByReceivable)
    }
    
    func test_priceTpyeValueChanged_selectedIndexEqualPriceTypeDebt_invokedConfigurePriceTpyeSegmentedControlByDebt() {
        XCTAssertFalse(addBillView.invokedConfigurePriceTpyeSegmentedControlByDebt)
        XCTAssertFalse(addBillView.invokedConfigurePriceTpyeSegmentedControlByReceivable)
        addBillPresenter.priceTpyeValueChanged(PriceType.Debt.rawValue)
        XCTAssertFalse(addBillView.invokedConfigurePriceTpyeSegmentedControlByReceivable)
        XCTAssertTrue(addBillView.invokedConfigurePriceTpyeSegmentedControlByDebt)
    }
    
    func testAddButtonTapped() {
        addBillPresenter.selectFriend(People.exampleModel)
        addBillManager.stubbedReadUserResult = People.exampleModel
        XCTAssertFalse(addBillManager.invokedSaveUser)
        XCTAssertFalse(addBillManager.invokedReadUser)
        XCTAssertFalse(addBillRouter.invokedPopView)
        addBillPresenter.addButtonTapped(amount: "100")
        XCTAssertTrue(addBillManager.invokedReadUser)
        XCTAssertTrue(addBillManager.invokedSaveUser)
        XCTAssertTrue(addBillRouter.invokedPopView)
    }
    
    func testPullDownButtonIsEnabled() {
        XCTAssertFalse(addBillPresenter.pullDownButtonIsEnabled())
        addBillManager.stubbedReadUserResult = People.exampleModel
        XCTAssertTrue(addBillManager.invokedReadUser)
        XCTAssertTrue(addBillPresenter.pullDownButtonIsEnabled())
    }
    
    func testPopView() {
        XCTAssertFalse(addBillRouter.invokedPopView)
        addBillPresenter.closeButtonTapped()
        XCTAssertTrue(addBillRouter.invokedPopView)
    }
    
    func testNotifyViewLoaded() {
        XCTAssertFalse(addBillManager.invokedReadUser)
        addBillPresenter.notifyViewLoaded()
        XCTAssertTrue(addBillManager.invokedReadUser)
    }
}
