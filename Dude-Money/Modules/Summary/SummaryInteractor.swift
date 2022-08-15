//
//  SummaryInteractor.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 14.08.2022.
//

import Foundation

protocol SummaryInteractorInterface { }

final class SummaryInteractor {
    weak var presenter: SummaryPresenter?
}

// MARK: - Interface Setup
extension SummaryInteractor: SummaryInteractorInterface {
    
}
