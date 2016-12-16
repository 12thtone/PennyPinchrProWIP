//
//  UserService.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/16/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import Alamofire

class UserService {
    static let us = UserService()
    
    var groupID: String {
        if defaults.string(forKey: "groupID") != nil {
            return defaults.string(forKey: "groupID")!
        }
        return ""
    }
    
    var allUsers: String {
        if defaults.string(forKey: "allUsers") != nil {
            return defaults.string(forKey: "allUsers")!
        }
        return ""
    }
    
    let defaults = UserDefaults.standard
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var sessions = [NSManagedObject]()
    
    func isLogedIn() -> Bool {
        return defaults.bool(forKey: "isLoggedIn")
    }
    
    func createAccount(email: String, password: String, completion:@escaping (_ result: String) -> Void) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                var initialBudget = "0"
                if self.defaults.string(forKey: "currentBudget") != nil {
                    initialBudget = self.defaults.string(forKey: "currentBudget")!
                }
                let accountDict = ["email": email, "currentBudget": initialBudget]
                
                print("\(user!.uid)")
                self.defaults.set("\(user!.uid)", forKey: "groupID")
                
                FB_DATABASE_REF.child("accounts").child("\(user!.uid)").updateChildValues(accountDict) { (errorDB, ref) -> Void in
                    if errorDB == nil {
                        
                        self.defaults.set(true, forKey: "isLoggedIn")
                        
                        completion("done")
                    } else {
                        print("DB ISSUE: \(errorDB.debugDescription)")
                        
                        completion("error")
                    }
                }
            } else {
                print("CREATE ISSUE: \(error.debugDescription)")
                
            }
        }
    }
    
    func createUser(userDict: [String: String], completion:@escaping (_ result: String) -> Void) {
        FB_DATABASE_REF.child("users").childByAutoId().updateChildValues(userDict) { (error, ref) -> Void in
            if error == nil {
                let newUsers = "\(self.allUsers)\(ref.key),"
                
                FB_DATABASE_REF.child("accounts").child("users").setValue(newUsers) { (error, ref) -> Void in
                    
                    if error == nil {
                        completion("done")
                    } else {
                        completion("error")
                    }
                }
            } else {
                completion("error")
            }
        }
    }
    
    func getAccountData(completion:@escaping (_ result: [String: String]) -> Void) {
        var accountDict = [String: String]()
        
        FB_DATABASE_REF.child("accounts").child(groupID).observe(FIRDataEventType.value, with: { (snapshot) in
            let returnedDict = snapshot.value as? [String : String] ?? [:]
            print(returnedDict)
            
            accountDict = ["email": "\(returnedDict["email"]!)",
                           "currentBudget": "\(returnedDict["currentBudget"]!)"]
            
            if returnedDict["users"] != nil {
                accountDict["users"] = "\(returnedDict["users"]!)"
                self.defaults.set("\(returnedDict["users"]!)", forKey: "allUsers")
            } else {
                accountDict["users"] = ""
            }
            
            if returnedDict["currentSpent"] != nil {
                accountDict["currentSpent"] = "\(returnedDict["currentSpent"]!)"
            } else {
                accountDict["currentSpent"] = ""
            }
            
            if returnedDict["currentSpentCash"] != nil {
                accountDict["currentSpentCash"] = "\(returnedDict["currentSpentCash"]!)"
            } else {
                accountDict["currentSpentCash"] = ""
            }
            
            if returnedDict["currentSpentCredit"] != nil {
                accountDict["currentSpentCredit"] = "\(returnedDict["currentSpentCredit"]!)"
            } else {
                accountDict["currentSpentCredit"] = ""
            }
            
            if returnedDict["historicalPeriods"] != nil {
                accountDict["historicalPeriods"] = "\(returnedDict["historicalPeriods"]!)"
            } else {
                accountDict["historicalPeriods"] = ""
            }
            
            completion(accountDict)
        })
    }
    
    func getUserData(userString: String, completion:@escaping (_ result: [[String: AnyObject]]) -> Void) {
        var userDictArray = [[String: AnyObject]]()
        let userArray = userString.components(separatedBy: ",")
        
        for user in userArray {
            FB_DATABASE_REF.child("users").child(user.replacingOccurrences(of: ",", with: "")).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let returnedDict = snapshot.value as? [String : String] ?? [:]
                print(returnedDict)
                
                var userDict = ["name": "\(returnedDict["name"]!)" as AnyObject,
                                "imageURL": "\(returnedDict["imageURL"]!)" as AnyObject,
                                "currentBudget": "\(returnedDict["currentBudget"]!)" as AnyObject,
                                "currentSpent": "\(returnedDict["currentSpent"]!)" as AnyObject,
                                "currentCashSpent": "\(returnedDict["currentCashSpent"]!)" as AnyObject,
                                "currentCreditSpent": "\(returnedDict["currentCreditSpent"]!)" as AnyObject]
                
                if returnedDict["historicalPeriods"] != nil {
                    userDict["historicalPeriods"] = "\(returnedDict["historicalPeriods"]!)" as AnyObject?
                }
                
                Alamofire.request("\(returnedDict["imageURL"]!)").responseData { response in
                    if let data = response.result.value {
                        userDict["userImage"] =  UIImage(data: data, scale:1)!
                    } else {
                        userDict["userImage"] =  UIImage(named: "no_img")!
                    }
                    
                    userDictArray.append(userDict)
                    
                    if userDictArray.count == userArray.count {
                        completion(userDictArray)
                    }
                }
            })
        }
    }
    
    func login(email: String, password: String, completion:@escaping (_ result: String) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            
            
            completion("done")
//            completion("error")
        }
    }
    
    func logout() {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func forgotPassword(email: String, completion:@escaping (_ result: String) -> Void) {
        completion("done")
        
    }
    
    func settingsArray() -> [String] {
        return ["Add User", "Info", "Logout"]
    }
}
