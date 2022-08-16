//
//  SummaryInteractor.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 14.08.2022.
//

import Foundation

protocol SummaryInteractorInterface: AnyObject {
    func readPeople() -> People?
}

final class SummaryInteractor { }

// MARK: - Interface Setup
extension SummaryInteractor: SummaryInteractorInterface {
    
    func readPeople() -> People? {
        LocalSaveService.readUser()
    }
}
