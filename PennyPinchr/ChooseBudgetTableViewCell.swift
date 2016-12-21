//
//  ChooseBudgetTableViewCell.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/20/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class ChooseBudgetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var selectedImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
