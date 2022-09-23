//
//  HeaderCollectionReusableView.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 17.08.2022.
//

import UIKit

final class HeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet private weak var headerLabel: UILabel!
    
    func setHeaderLabel(_ title: String) {
        self.headerLabel.text = title
    }
    
    static let cellHeight: CGFloat = 40
}
