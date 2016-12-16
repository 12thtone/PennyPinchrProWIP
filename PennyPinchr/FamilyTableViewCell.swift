//
//  FamilyTableViewCell.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/14/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class FamilyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var budgetStatusImageView: UIImageView!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
