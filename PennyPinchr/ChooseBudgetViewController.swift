//
//  ChooseBudgetViewController.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/20/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class ChooseBudgetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var groups = [GroupModel]()
    
    var selectedGroupID = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        loadGroups()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadGroups() {
        DataService.ds.getUserGroups() {
            (result: [[String: AnyObject]]) in
            
            for eachGroup in result {
                
                self.groups.append(GroupModel.init(group: eachGroup))
                
                if self.groups.count == result.count {
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseBudgetTVC") as? ChooseBudgetTableViewCell {
            
            let group = groups[indexPath.row]

            cell.budgetLabel.text = group.groupName
            
            if group.groupID == HelperService.hs.prefGroup {
                cell.selectedImageView.isHidden = false
                selectedGroupID = group.groupID
            } else {
                cell.selectedImageView.isHidden = true
            }
            
            return cell
        }
        return SettingsTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGroupID = groups[indexPath.row].groupID
        DataService.ds.updatePrefGroupUI(groupID: selectedGroupID)
        
        tableView.reloadData()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        DataService.ds.updatePrefGroup(groupID: selectedGroupID) {
            (result: String) in
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
