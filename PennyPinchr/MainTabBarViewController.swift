//
//  MainTabBarViewController.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/14/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        for item in tabBar.items! {
            item.title = nil
            item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
