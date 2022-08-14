//
//  TabbarInteractor.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 13.08.2022.
//

protocol TabBarInteractorInterface { }

final class TabBarInteractor {
    weak var presenter: TabBarPresenter? // Neden weak
}

// MARK: - Interface Setup
extension TabBarInteractor: TabBarInteractorInterface {
    
}
