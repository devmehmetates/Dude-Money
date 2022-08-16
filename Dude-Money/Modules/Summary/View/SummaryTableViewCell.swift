//
//  SummaryTableViewCell.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 16.08.2022.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    @IBOutlet private var balanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var setBalance: Double? {
        didSet {
            if let setBalance = setBalance {
                balanceLabel.text = setBalance.format + "₺"
            } else {
                balanceLabel.text = 0.format + "₺"
            }
        }
    }

}
