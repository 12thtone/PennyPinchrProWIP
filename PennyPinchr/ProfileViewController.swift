//
//  ProfileViewController.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/15/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userImageView: ImageViewRadius!
    @IBOutlet weak var budgetStatusImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userBudgetLabel: UILabel!
    @IBOutlet weak var editBudgetButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var user: UserModel?
    var historicArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        let editImage = UIImage(named: "edit")
        editBudgetButton.imageView?.contentMode = .scaleAspectFit
        editBudgetButton.setImage(editImage, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTVC") as? ProfileTableViewCell {
            
            return cell
        }
        return ProfileTableViewCell()
    }
    
    @IBAction func editBudgetTapped(_ sender: Any) {
        
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
