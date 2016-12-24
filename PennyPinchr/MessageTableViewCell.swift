//
//  MessageTableViewCell.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/23/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: ImageViewRound!
    @IBOutlet weak var messageIconImageView: ImageViewRound!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
