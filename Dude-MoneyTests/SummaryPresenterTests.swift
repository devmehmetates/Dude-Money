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
}
