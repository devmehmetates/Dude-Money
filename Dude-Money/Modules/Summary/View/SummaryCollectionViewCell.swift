//
//  SummaryCollectionViewCell.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 16.08.2022.
//

import UIKit

class SummaryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var amountLabel: UILabel!
    
    func configureContent(amount: Double) {
        amountLabel.text = amount.format + "₺"
    }
    
    static let cellId: String = "summaryCell"
    static let cellHeight: CGFloat = 210
    
    
}
