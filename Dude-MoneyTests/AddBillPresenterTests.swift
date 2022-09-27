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
    
    func testPriceTpyeValueChanged() {
        XCTAssertFalse(addBillView.invokedConfigurePriceTpyeSegmentedControlByDebt)
        addBillPresenter.priceTpyeValueChanged(PriceType.Debt.rawValue)
        XCTAssertTrue(addBillView.invokedConfigurePriceTpyeSegmentedControlByDebt)
        
        XCTAssertFalse(addBillView.invokedConfigurePriceTpyeSegmentedControlByReceivable)
        addBillPresenter.priceTpyeValueChanged(PriceType.Receivable.rawValue)
        XCTAssertTrue(addBillView.invokedConfigurePriceTpyeSegmentedControlByReceivable)
    }
    
    func testAddBill() {
        addBillPresenter.selectFriend(People.exampleModel)
        XCTAssertFalse(addBillInteractor.invokedSavePeople)
        XCTAssertFalse(addBillRouter.invokedPopView)
        addBillPresenter.addBill(amount: "100")
        XCTAssertTrue(addBillInteractor.invokedSavePeople)
        XCTAssertTrue(addBillRouter.invokedPopView)
    }
    
    func testGetFriends() {
        addBillInteractor.stubbedReadPeople = People.exampleModel
        XCTAssertNil(addBillPresenter.getFriends)
        addBillPresenter.notifyViewLoaded()
        XCTAssertEqual(addBillPresenter.getFriends?.count, 1)
    }
    
    func testPullDownButtonIsEnabled() {
        addBillInteractor.stubbedReadPeople = People.exampleModel
        XCTAssertFalse(addBillPresenter.pullDownButtonIsEnabled)
        addBillPresenter.notifyViewLoaded()
        XCTAssertTrue(addBillPresenter.pullDownButtonIsEnabled)
    }
    
    func testPopView() {
        XCTAssertFalse(addBillRouter.invokedPopView)
        addBillPresenter.popView()
        XCTAssertTrue(addBillRouter.invokedPopView)
    }
    
    func testNotifyViewLoaded() {
        XCTAssertFalse(addBillInteractor.invokedReadPeopleGetter)
        addBillPresenter.notifyViewLoaded()
        XCTAssertTrue(addBillInteractor.invokedReadPeopleGetter)
    }
    
    func testNotifyViewWillAppear() {
        XCTAssertFalse(addBillView.invokedConfigureFriendPullDownButton)
        addBillPresenter.notifyViewWillAppear()
        XCTAssertTrue(addBillView.invokedConfigureFriendPullDownButton)
    }
}
