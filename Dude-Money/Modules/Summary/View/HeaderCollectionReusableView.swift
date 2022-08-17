//
//  HeaderCollectionReusableView.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 17.08.2022.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak private var headerLabel: UILabel!
    
    func setHeaderLabel(_ title: String) {
        self.headerLabel.text = title
    }
    
    static let cellId: String = "headerCell"
    static let cellHeight: CGFloat = 40
}
