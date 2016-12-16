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
    @IBOutlet weak var authView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var reportsButton: UIButton!
    
    var users = [UserModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        loadingIndicator.isHidden = true
        
        if UserService.us.isLogedIn() {
            authView.isHidden = true
            tableView.isHidden = true
            percentSpentLabel.isHidden = true
            
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
            
            loadUsers()
        } else {
            settingsButton.isHidden = true
            reportsButton.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUsers() {
        UserService.us.getAccountData() {
            (result: [String: String]) in
            
            print(result)
            
            if result["users"]! != "" {
                UserService.us.getUserData(userString: result["users"]!) {
                    (resultUsers: [[String: AnyObject]]) in
                    
                    print(resultUsers)
                    
                    
                }
            } else {
                self.loadingIndicator.isHidden = true
                self.loadingIndicator.stopAnimating()
            }
        }
    }
    
    func hideShowViews(toHide: Bool) {
        
        authView.isHidden = !toHide
        tableView.isHidden = toHide
        percentSpentLabel.isHidden = toHide
        
        settingsButton.isHidden = toHide
        reportsButton.isHidden = toHide
    }
    
    func loginUser() {
        hideShowViews(toHide: false)
        
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        
        UserService.us.login(email: emailField.text!, password: passwordField.text!) {
            (result: String) in
            
            self.loadUsers()
            
            if result == "error" {
                self.hideShowViews(toHide: true)
            }
        }
    }
    
    func createAccount() {
        hideShowViews(toHide: false)
        
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        
        UserService.us.createAccount(email: emailField.text!, password: passwordField.text!) {
            (result: String) in
            
            self.loadingIndicator.isHidden = true
            self.loadingIndicator.stopAnimating()
            
            if result == "error" {
                self.hideShowViews(toHide: true)
            }
        }
    }
    
    func forgotPasswordConf() {
        UserService.us.forgotPassword(email: emailField.text!) {
            (result: String) in
            
            let alertController = UIAlertController(title: "Reset Password", message: "Please check your email. We just send a message with instructions for choosing a new password.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true) {
                
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTVC") as? SettingsTableViewCell {
            cell.settingActionLabel.text = UserService.us.settingsArray()[indexPath.row]
            
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
    
    @IBAction func loginTapped(_ sender: Any) {
        if emailField.text != "" && passwordField.text != "" {
            loginUser()
        } else {
            let alertController = UIAlertController(title: "Email + Password", message: "Please enter the email and password for your PennyPinchr account.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true) {
                
            }
        }
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        if emailField.text != "" && passwordField.text != "" {
            createAccount()
        } else {
            let alertController = UIAlertController(title: "Email + Password", message: "Please enter an email and password to create your PennyPinchr account.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true) {
                
            }
        }
    }
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        if emailField.text != "" {
            forgotPasswordConf()
        } else {
            let alertController = UIAlertController(title: "Email", message: "Please enter the email address associated with your PennyPinchr account.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true) {
                
            }
        }
    }
}
