//
//  ProfileViewController.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/15/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userImageView: ImageViewRadius!
    @IBOutlet weak var budgetStatusImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    var sessions = [SessionModel]()
    
    var alertController = UIAlertController()
    
    var userID: String?
    var userImage: UIImage?
    var imageURL: String?
    var userName: String?
    var userBudget: String?
    var userCash: String?
    var userCredit: String?
    
    var tfCounter = 0
    var tfString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProfileData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadProfileData() {
        DataService.ds.getIndSessions() {
            (result: [[String: String]]) in
            
            print(result)
            
            for session in result {
                self.sessions.append(SessionModel.init(session: session as [String : AnyObject]))
                
                if result.count == self.sessions.count {
                    self.setViews()
                }
            }
        }
    }
    
    func setViews() {
        if Double(userBudget!)! < Double(userCash!)! {
            budgetStatusImageView.image = UIImage(named: "caution")
        } else {
            budgetStatusImageView.image = UIImage(named: "logo")
        }
        
        userImageView.image = userImage
        nameLabel.text = userName!
        budgetLabel.text = userBudget!
        percentLabel.text = "CALC ME!!!"
        cashLabel.text = userCash!
        creditLabel.text = userCredit!
        countLabel.text = "\(sessions.count)"
        avgLabel.text = HelperService.hs.sessionAverage(sessions: sessions)
        maxLabel.text = HelperService.hs.sessionMax(sessions: sessions)
    }
    
    func enterBudget() {
        alertController = UIAlertController(title: "New Personal Budget", message: "Please enter a personal budget amount for this group budget.", preferredStyle: .alert)
        
        alertController.textFields?[0].delegate = self
        
        alertController.addTextField { (textField) in
            textField.placeholder = "New Budget:"
            textField.keyboardType = .numberPad
            textField.clearButtonMode = .always
        }
        
        let okAction = UIAlertAction(title: "Save", style: .default) { (action) in
            self.saveNewBudget(amount: self.alertController.textFields![0].text!)
        }
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true) {
            
        }
    }
    
    func saveNewBudget(amount: String) {
        DataService.ds.updateMemberGroupBudget(group: HelperService.hs.prefGroup, member: userID!, budget: amount) {
            (result: String) in
            
            DataService.ds.postMessage(sender: HelperService.hs.userID, senderName: HelperService.hs.name, receiver: self.userID!, messageType: "personalChanged", messageData: HelperService.hs.prefGroup)
            
            print(result)
            
            self.setViews()
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
    
    @IBAction func editTapped(_ sender: Any) {
        enterBudget()
    }
    
    @IBAction func messageTapped(_ sender: Any) {
        
    }
    
    @IBAction func yayTapped(_ sender: Any) {
        DataService.ds.postMessage(sender: HelperService.hs.userID, senderName: HelperService.hs.name, receiver: userID!, messageType: "yay", messageData: "")
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
