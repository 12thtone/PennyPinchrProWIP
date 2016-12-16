//
//  CreateUserViewController.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/15/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addImageTapped(_:)))
        userImageView.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addImageTapped(_ sender: UITapGestureRecognizer) {
        
    }
    
    @IBAction func saveUserTapped(_ sender: Any) {
        
    }
}
