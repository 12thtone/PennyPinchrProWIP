//
//  GroupViewController.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/14/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var percentSpentLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var settingsButton: UIButton!
    
    var users = [GroupMemberModel]()
    var budget: BudgetModel?
    
    var alertController = UIAlertController()
    
    var tfCounter = 0
    var tfString = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        loadingIndicator.isHidden = true
        
        if HelperService.hs.isLogedIn() {
            tableView.isHidden = true
            percentSpentLabel.isHidden = true
            
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
            
            loadGroupUsers()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if HelperService.hs.isLogedIn() == false {
            let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as! AuthViewController
            let navController = UINavigationController(rootViewController: authVC)
            
            self.present(navController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadGroupUsers() {
        DataService.ds.getGroupData(group: HelperService.hs.prefGroup) {
            (result: [String: AnyObject]) in
            
            print(result)
            
            self.budget = BudgetModel(budget: result)
            
            if let members = result["memberBudgets"] as? [[String: AnyObject]] {
                
                for member in members {
                    
                    let memberUser = GroupMemberModel.init(member: member.values.first as! [String : AnyObject])
                    
                    self.users.append(memberUser)
                    
                    if members.count == self.users.count {
                        self.tableView.reloadData()
                        self.setViews()
                    }
                }
            } else {
                self.loadingIndicator.isHidden = true
                self.loadingIndicator.stopAnimating()
            }
        }
    }
    
    func setViews() {
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
        
        percentSpentLabel.text = "\(budget!.percentOfBudget)% of Budget Spent"
        
        tableView.isHidden = false
        percentSpentLabel.isHidden = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTVC") as? GroupTableViewCell {
            let aUser = users[indexPath.row]
            
            var budgetStatusImage: UIImage?
            
            if Double(aUser.budget)! < Double(aUser.spentCash)! {
                budgetStatusImage = UIImage(named: "caution")
            } else {
                budgetStatusImage = UIImage(named: "logo")
            }
            
            cell.userImageView.image = aUser.memberImage
            cell.budgetStatusImageView.image = budgetStatusImage
            cell.nameLabel.text = "\(aUser.name)"
            cell.budgetLabel.text = "Budget: \(HelperService.hs.toMoney(rawMoney: Double(aUser.budget)!))"
            cell.cashLabel.text = "Cash Spent: \(HelperService.hs.toMoney(rawMoney: Double(aUser.spentCash)!))"
            cell.creditLabel.text = "Credit Spent: \(HelperService.hs.toMoney(rawMoney: Double(aUser.spentCredit)!))"
            
            return cell
        }
        return SettingsTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileViewController
        profileVC.userImage = users[indexPath.row].memberImage
        profileVC.userID = users[indexPath.row].memberID
        profileVC.userName = users[indexPath.row].name
        profileVC.userBudget = users[indexPath.row].budget
        profileVC.userCash = users[indexPath.row].spentCash
        profileVC.userCredit = users[indexPath.row].spentCredit

        let navController = UINavigationController(rootViewController: profileVC)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func editBudgetTapped(_ sender: Any) {
        alertController = UIAlertController(title: "New Master Budget", message: "Please enter a budget amount for the group.", preferredStyle: .alert)
        
        alertController.textFields?[0].delegate = self
        
        alertController.addTextField { (textField) in
            textField.placeholder = "New Budget:"
            textField.keyboardType = .numberPad
            textField.clearButtonMode = .always
        }
        
        let okAction = UIAlertAction(title: "Save", style: .default) { (action) in
            self.setNewBudget(amount: self.alertController.textFields![0].text!)
        }
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true) {
            
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        tfCounter += 1
        tfString += string
        
        alertController.textFields?[0].text = HelperService.hs.toMoney(rawMoney: Double(HelperService.hs.moneyDouble(rawString: "\(tfString)", charCount: tfCounter))!)
        
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        tfCounter = 0
        tfString = ""
        
        return true
    }
    
    func setNewBudget(amount: String) {
        DataService.ds.updateGroupBudget(group: HelperService.hs.prefGroup, budget: amount) {
            (result: String) in
            
            DataService.ds.postMessage(sender: HelperService.hs.userID, senderName: HelperService.hs.name, receiver: HelperService.hs.prefGroupUsers, messageType: "masterChanged", messageData: HelperService.hs.prefGroup)
            
            self.setViews()
        }
    }
}
