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
    
    var sessions = [SessionModel]()
    var budget: BudgetModel?
    
    var newUserAlertController = UIAlertController()
    var newPeriodAlertController = UIAlertController()
    var newBudgetCounter = 0
    var newBudgetString = ""
    
    var isEditingPeriodBudget = false

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if budget == nil {
            
            newUserBudget()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        sessions.removeAll()
        
        // Get Sessions
    
//        for savedSession in savedSessions {
//            let session = SessionModel.init(session: savedSession)
//            sessions.append(session)
//        }
        
        // Get Budget
        
//        do {
//            savedBudget = try managedContext.fetch(fetchRequestBudget)
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
        
        //        for onlyBudget in savedBudget {
        //
        //            let budgetDict = ["currentBudget": "", "currentSpent": "", "currentSpentCash": "", "currentSpentCredit": ""]
        //            let theOnlyBudget = BudgetModel.init(curBudget: budgetDict)
        //            budget.append(theOnlyBudget)
        //        }
        
//        if savedBudget.isEmpty == false {
//            var currentBudget = ""
//            var currentSpent = ""
//            var currentSpentCash = ""
//            var currentSpentCredit = ""
//            
//            if let cBudget = savedBudget.first!.value(forKey: "currentBudget") {
//                currentBudget = "\(cBudget)"
//            }
//            
//            if let cSpent = savedBudget.first!.value(forKey: "currentSpent") {
//                currentSpent = "\(cSpent)"
//            }
//            
//            if let cSpentCash = savedBudget.first!.value(forKey: "currentSpentCash") {
//                currentSpentCash = "\(cSpentCash)"
//            }
//            
//            if let cSpentCredit = savedBudget.first!.value(forKey: "currentSpentCredit") {
//                currentSpentCredit = "\(cSpentCredit)"
//            }
//            
//            let budgetDict = ["currentBudget": currentBudget,
//                "currentSpent": currentSpent,
//                "currentSpentCash": currentSpentCash,
//                "currentSpentCredit": currentSpentCredit]
//            
//            budget = BudgetModel.init(curBudget: budgetDict)
//        }
        
        setViews()
    }
    
    func setViews() {
        
        if budget == nil {
            budgetLabel.text = "Period Budget: $0.00"
        } else {
            budgetLabel.text = "Period Budget: \(HelperService.hs.toMoney(rawMoney: Double(budget!.budget)!))"
        }
        
        if sessions.isEmpty {
            spentLabel.text = "Period Spent: $0.00"
        } else {
//            spentLabel.text = "Period Spent: \(HelperService.hs.toMoney(rawMoney: Double(HelperService.hs.totalSpent(sessions: sessions))!))"
        }
        
        if sessions.isEmpty == false {
//            if Double(HelperService.hs.totalSpent(sessions: sessions))! > Double(budget!.budget)! {
//                handleOverBudget()
//            }
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
//            cell.dateLabel.text = "\(session.date)"
//            cell.totalLabel.text = "Total Spent: \(session.total)"
//            cell.cashLabel.text = "Cash: \(session.cash)"
//            cell.creditLabel.text = "Credit: \(session.credit)"
            
            return cell
        }
        return SessionTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newSessionVC = self.storyboard?.instantiateViewController(withIdentifier: "NewSessionVC") as! NewSessionViewController
        newSessionVC.session = sessions[indexPath.row]
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
        
//        if Double(DataService.ds.totalSpent(sessions: sessions))! > Double(budget!.budget)! {
//            overBudgetAlert()
//        }
    }
    
    @IBAction func addShopSession(_ sender: Any) {
        let newSessionVC = self.storyboard?.instantiateViewController(withIdentifier: "NewSessionVC") as! NewSessionViewController
        newSessionVC.delegate = self
        let navController = UINavigationController(rootViewController: newSessionVC)
        
        self.present(navController, animated: true, completion: nil)
    }

    @IBAction func calenderTapped(_ sender: Any) {
        isEditingPeriodBudget = true
        
        newPeriodAlertController = UIAlertController(title: "New Budget Period", message: "Time for a new budged period?\n\nCreating a new one will clear the old.", preferredStyle: .alert)
        
        newPeriodAlertController.addTextField { (textField) in
            self.newPeriodAlertController.textFields![0].delegate = self
            
            textField.placeholder = "$0.00"
            textField.keyboardType = .numberPad
            textField.clearButtonMode = .always
        }
        
        let okAction = UIAlertAction(title: "Create New Budget", style: .default) { (action) in
            self.isEditingPeriodBudget = false
            self.addNewBudget(newBudget: (self.newPeriodAlertController.textFields?[0].text)!)
        }
        newPeriodAlertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.isEditingPeriodBudget = false
        }
        newPeriodAlertController.addAction(cancelAction)
        
        self.present(newPeriodAlertController, animated: true) {
            
        }
    }
    
    func addNewBudget(newBudget: String) {
//        DataService.ds.saveBudgetLocally(budget: newBudget) {
//            (result: String) in
//            
//            print(result)
//            self.budgetLabel.text = "Period Budget: \(DataService.ds.toMoney(rawMoney: Double(result)!))"
//            self.spentLabel.text = "Period Spent: $0.00"
//        }
    }
    
    // Over budget
    
    func handleOverBudget() {
        spentLabel.textColor = UIColor.red
        spentLabel.font = UIFont(name: "Avenir-Black", size: 14)
//        spentLabel.text = "Period Spent: \(HelperService.hs.toMoney(rawMoney: Double(DataService.ds.totalSpent(sessions: sessions))!))!!"
    }
    
    func overBudgetAlert() {
        newUserAlertController = UIAlertController(title: "Over Budget!", message: "Swipe to delete transactions if you saved the receipt!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        newUserAlertController.addAction(okAction)
        
        self.present(newUserAlertController, animated: true) {
            
        }
    }
    
    // New User Mgmt
    
    func newUserBudget() {
        newUserAlertController = UIAlertController(title: "Welcome to PennyPinchr!", message: "To get started, please enter your budget for this period.", preferredStyle: .alert)
        
        newUserAlertController.addTextField { (textField) in
            self.newUserAlertController.textFields![0].delegate = self
            
            textField.placeholder = "$0.00"
            textField.keyboardType = .numberPad
            textField.clearButtonMode = .always
        }
        
        let okAction = UIAlertAction(title: "Create Budget", style: .default) { (action) in
            self.addNewBudget(newBudget: (self.newUserAlertController.textFields![0].text)!)
        }
        newUserAlertController.addAction(okAction)
        
        self.present(newUserAlertController, animated: true) {
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        newBudgetCounter += 1
        newBudgetString += string
        
        if isEditingPeriodBudget {
            newPeriodAlertController.textFields?[0].text = HelperService.hs.toMoney(rawMoney: Double(HelperService.hs.moneyDouble(rawString: "\(newBudgetString)", charCount: newBudgetCounter))!)
        } else {
            newUserAlertController.textFields?[0].text = HelperService.hs.toMoney(rawMoney: Double(HelperService.hs.moneyDouble(rawString: "\(newBudgetString)", charCount: newBudgetCounter))!)
        }
        
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        newBudgetCounter = 0
        newBudgetString = ""
        
        return true
    }
}
