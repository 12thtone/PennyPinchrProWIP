//
//  ProfileTableViewCell.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/15/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
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
