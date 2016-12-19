//
//  AuthViewController.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/18/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var alertController = UIAlertController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            enterName()
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
    
    func loginUser() {
        DataService.ds.login(email: emailField.text!, password: passwordField.text!) {
            (result: String) in
            
            if result == "error" {
                
            }
        }
    }
    
    func enterName() {
        alertController = UIAlertController(title: "Name", message: "Please enter a name by which you will be recognized in your groups.", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Name:"
            textField.keyboardType = .default
            textField.clearButtonMode = .always
        }
        
        let okAction = UIAlertAction(title: "Continue", style: .default) { (action) in
            self.createAccount(name: self.alertController.textFields![0].text!)
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true) {
            
        }
    }
    
    func createAccount(name: String) {
        if name == "" {
            enterName()
        } else {
            DataService.ds.createAccount(email: emailField.text!, password: passwordField.text!) {
                (result: String) in
                
                let createGroupVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateGroupVC") as! CreateGroupViewController
                createGroupVC.isFromAuth = true
                createGroupVC.userName = name
                createGroupVC.email = self.emailField.text!
                
                let navController = UINavigationController(rootViewController: createGroupVC)
                
                self.present(navController, animated: true, completion: nil)
                
                if result == "error" {
                    
                }
            }
        }
    }

    func forgotPasswordConf() {
        DataService.ds.forgotPassword(email: emailField.text!) {
            (result: String) in
            
            let alertController = UIAlertController(title: "Reset Password", message: "Please check your email. We just send a message with instructions for choosing a new password.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true) {
                
            }
        }
    }
}
