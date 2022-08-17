//
//  SummaryInteractor.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 14.08.2022.
//

import Foundation

protocol SummaryInteractorInterface: AnyObject {
    var readPeople: People? { get }
}

final class SummaryInteractor { }

// MARK: - Interface Setup
extension SummaryInteractor: SummaryInteractorInterface {
    var readPeople: People? {
        get {
            LocalSaveService.readUser()
        }
    }
}
