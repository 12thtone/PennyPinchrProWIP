//
//  SessionViewController.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/10/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

protocol SessionDelegate {
    func reloadSessions()
}

class SessionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SessionDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var spentLabel: UILabel!
    
    var sessions = [IndividualSessionModel]()
    var sessionDetails: SessionModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        sessions.removeAll()
        
        DataService.ds.getSessions() {
            (result: [String: AnyObject]) in
            
            print(result)
            
            self.sessionDetails = SessionModel(session: result)
            
            if let individualSessions = result["individualSessions"] as? [[String: AnyObject]] {
                
                for individual in individualSessions {
                    
                    let ind = IndividualSessionModel.init(session: individual)
                    
                    self.sessions.append(ind)
                    
                    if individualSessions.count == self.sessions.count {
                        self.tableView.reloadData()
                        self.setViews()
                    }
                }
            } else {
                self.tableView.reloadData()
                self.setViews()
            }
        }
    }
    
    func setViews() {
        
        groupLabel.text = sessionDetails!.name
        budgetLabel.text = "Budget: \(HelperService.hs.toMoney(rawMoney: Double(sessionDetails!.budget)!))"
        
        if sessionDetails == nil {
            spentLabel.text = "Cash Spent: $0.00 & Credit Spent: $0.00"
        } else {
            spentLabel.text = "Cash Spent: \(HelperService.hs.toMoney(rawMoney: Double(sessionDetails!.spentCash)!)) & Credit Spent: \(HelperService.hs.toMoney(rawMoney: Double(sessionDetails!.spentCredit)!))"
        }
        
        if sessions.isEmpty == false {
            if Double(sessionDetails!.spent)! > Double(sessionDetails!.budget)! {
                handleOverBudget()
            }
        }
        
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let session = sessions[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SessionTVC") as? SessionTableViewCell {
            cell.dateLabel.text = "\(session.date)"
            cell.totalLabel.text = "Total Spent: \(session.spent)"
            cell.cashLabel.text = "Cash: \(session.spentCash)"
            cell.creditLabel.text = "Credit: \(session.spentCredit)"
            
            return cell
        }
        return SessionTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newSessionVC = self.storyboard?.instantiateViewController(withIdentifier: "NewSessionVC") as! NewSessionViewController
        newSessionVC.session = sessions[indexPath.row]
        newSessionVC.sessionCashSpent = sessionDetails!.spentCash
        newSessionVC.sessionCreditSpent = sessionDetails!.spentCredit
        let navController = UINavigationController(rootViewController: newSessionVC)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sessions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func reloadSessions() {
        loadData()
        
        if Double(sessionDetails!.spent)! > Double(sessionDetails!.budget)! {
            overBudgetAlert()
        }
    }
    
    @IBAction func newSessionTapped(_ sender: Any) {
        
        let newSessionVC = self.storyboard?.instantiateViewController(withIdentifier: "NewSessionVC") as! NewSessionViewController
        newSessionVC.sessionCashSpent = sessionDetails!.spentCash
        newSessionVC.sessionCreditSpent = sessionDetails!.spentCredit
        newSessionVC.delegate = self
        let navController = UINavigationController(rootViewController: newSessionVC)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    // Over budget
    
    func handleOverBudget() {
        spentLabel.textColor = UIColor.red
        spentLabel.font = UIFont(name: "Avenir-Black", size: 14)
        spentLabel.text = "Period Spent: \(HelperService.hs.toMoney(rawMoney: Double(sessionDetails!.spent)!))!!"
    }
    
    func overBudgetAlert() {
        let alertController = UIAlertController(title: "Over Budget!", message: "Swipe to delete transactions if you saved the receipt!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true) {
            
        }
    }
}
