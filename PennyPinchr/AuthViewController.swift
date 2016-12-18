//
//  AuthViewController.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/18/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
