//
//  UIStoryboardInstantiate.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 24.08.2022.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    func instantiateViewController<T>(ofType type: T.Type) -> T {
        let identifier = String(describing: type)
        guard let viewController = instantiateViewController(withIdentifier: identifier) as? T else {
            preconditionFailure("Expected view controller with identifier \(identifier) to be of type \(type)")
        }
        return viewController
    }
}

