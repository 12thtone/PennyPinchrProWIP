//
//  SettingsViewController.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/15/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HelperService.hs.settingsArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTVC") as? SettingsTableViewCell {
            cell.settingActionLabel.text = HelperService.hs.settingsArray()[indexPath.row]
            
            return cell
        }
        return SettingsTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        ["Switch Budgets", "Add Budget", "Info", "Logout"]
        
        if indexPath.row == 0 {
            let chooseBudgetVC = self.storyboard?.instantiateViewController(withIdentifier: "ChooseBudgetVC") as! ChooseBudgetViewController
            let navController = UINavigationController(rootViewController: chooseBudgetVC)
            
            self.present(navController, animated: true, completion: nil)
        } else if indexPath.row == 1 {
            let createGroupVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateGroupVC") as! CreateGroupViewController
            let navController = UINavigationController(rootViewController: createGroupVC)
            
            self.present(navController, animated: true, completion: nil)
        } else if indexPath.row == 2  {
            
        } else {
            
        }
    }
}
