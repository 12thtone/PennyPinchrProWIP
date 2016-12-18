//
//  FamilyViewController.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/14/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class FamilyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var percentSpentLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var reportsButton: UIButton!
    
    var users = [UserModel]()
    var budget: BudgetModel?

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadGroupUsers() {
        DataService.ds.getAccountData() {
            (result: [String: String]) in
            
            print(result)
            
            self.budget = BudgetModel(curBudget: result)
            
            var totalSpent = 0.0
            var userBudget = 0.0
            
            if let tSpent = self.budget?.spent {
                totalSpent = Double("\(tSpent)")!
            }
            
            if let uBudget = self.budget?.budget {
                userBudget = Double("\(uBudget)")!
            }
            
            let percent = Int(totalSpent / userBudget)
            
            self.percentSpentLabel.text = "\(percent)% of Budget Spent"
            
            if result["groupUsers"]! != "" {
                UserService.us.getUserData(userString: result["groupUsers"]!) {
                    (resultUsers: [[String: AnyObject]]) in
                    
                    print(resultUsers)
                    
                    for eachUser in resultUsers {
                        let modelUser = UserModel.init(user: eachUser)
                        self.users.append(modelUser)
                    }
                    
                    self.tableView.reloadData()
                    
                    self.hideShowViews(toHide: false)
                    
                    self.loadingIndicator.isHidden = true
                    self.loadingIndicator.stopAnimating()
                    
                }
            } else {
                self.loadingIndicator.isHidden = true
                self.loadingIndicator.stopAnimating()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTVC") as? FamilyTableViewCell {
            let aUser = users[indexPath.row]
            
            var budgetStatusImage: UIImage?
            
            if Double(aUser.periodBudget)! < Double(aUser.periodCashSpent)! + Double(aUser.periodCreditSpent)! {
                budgetStatusImage = UIImage(named: "caution")
            } else {
                budgetStatusImage = UIImage(named: "logo")
            }
            
            cell.userImageView.image = aUser.userImage
            cell.budgetStatusImageView.image = budgetStatusImage
            cell.nameLabel.text = "\(aUser.name)"
            cell.budgetLabel.text = "Period Budget: \(DataService.ds.toMoney(rawMoney: Double(aUser.periodBudget)!))"
            cell.cashLabel.text = "Cash Spent: \(DataService.ds.toMoney(rawMoney: Double(aUser.periodCashSpent)!))"
            cell.creditLabel.text = "Credit Spent: \(DataService.ds.toMoney(rawMoney: Double(aUser.periodCreditSpent)!))"
            
            return cell
        }
        return SettingsTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileViewController
        profileVC.user = users[indexPath.row]
        let navController = UINavigationController(rootViewController: profileVC)
        
        self.present(navController, animated: true, completion: nil)
    }
}
