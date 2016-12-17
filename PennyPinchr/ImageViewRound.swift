//
//  ImageViewRound.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/16/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class ImageViewRound: UIImageView {
    
    override func awakeFromNib() {
        self.layoutIfNeeded()
        
        layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}
