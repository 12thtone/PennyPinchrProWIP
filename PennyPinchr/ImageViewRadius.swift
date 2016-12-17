//
//  ImageViewRadius.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/16/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class ImageViewRadius: UIImageView {
    
    override func awakeFromNib() {
        self.layoutIfNeeded()
        
        layer.cornerRadius = 13
        self.clipsToBounds = true
    }
}