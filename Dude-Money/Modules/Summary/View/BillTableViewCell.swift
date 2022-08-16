//
//  BillTableViewCell.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 15.08.2022.
//

import UIKit

class BillTableViewCell: UITableViewCell {
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var setProfileImageWithNamed: String? {
        didSet {
            self.profileImageView.image = UIImage(named: setProfileImageWithNamed ?? "") ?? UIImage(systemName: "person.circle")
        }
    }
    
    
    var setProfileImageWithSystemName: String? {
        didSet {
            self.profileImageView.image = UIImage(systemName: setProfileImageWithSystemName ?? "") ?? UIImage(systemName: "person.circle")
        }
    }
    
    var setNameLabel: String? {
        didSet {
            self.nameLabel.text = setNameLabel
        }
    }
    
    var setAmountLabel: Double? {
        didSet {
            if let setAmountLabel = setAmountLabel {
                self.amountLabel.text = setAmountLabel.format + "₺"
            } else {
                self.amountLabel.text = ""
            }
        }
    }
}
