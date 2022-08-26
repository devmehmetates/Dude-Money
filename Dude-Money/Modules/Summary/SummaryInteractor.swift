//
//  SummaryInteractor.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 14.08.2022.
//

import Foundation

protocol SummaryInteractorInterface: AnyObject {
    var people: People? { get }
}

final class SummaryInteractor { }

// MARK: - Interface Setup
extension SummaryInteractor: SummaryInteractorInterface {
    var people: People? {
        get {
            LocalSaveService.readUser()
        }
    }
}
