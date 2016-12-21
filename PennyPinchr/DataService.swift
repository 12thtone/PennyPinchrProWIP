//
//  DataService.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/11/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class DataService {
    static let ds = DataService()
    
    let defaults = UserDefaults.standard
    
    func saveUserImage(imageToSave: UIImage, completion:@escaping (_ result: String) -> Void) {
        let randomNumber = Int(arc4random_uniform(9999999))
        
        let imageId = "\(HelperService.hs.userID)-\(randomNumber)"
        let newPath = "/profile-image/\(imageId).jpg"
        
        let imageData = UIImageJPEGRepresentation(imageToSave , 0.1)
        
        FB_STORAGE_REF.child(newPath).put(imageData!, metadata: nil) { metadata, error in
            if (error != nil) {
                completion("error")
            } else {
                let downloadURL = metadata!.downloadURL()!.absoluteString
                completion(downloadURL)
            }
        }
    }
    
    func saveGroup(groupName: String, name: String, completion:@escaping (_ result: String) -> Void) {
        
        let sessionsDict = ["name": name,
                           "groupName": groupName,
                           "budget": "0.00",
                           "spentCash": "0.00",
                           "spentCredit": "0.00"]
        
        let sessionsRef = FB_DATABASE_REF.child("sessions").childByAutoId()
        let sessionsID = sessionsRef.key
        
        defaults.set(sessionsID, forKey: "prefGroupSessions")
        
        sessionsRef.setValue(sessionsDict) { (error, ref) -> Void in
            if error == nil {
                self.defaults.set(ref.key, forKey: "prefGroup")
                
                let groupfinancials = ["budget": "0.00",
                                       "spent": "0.00",
                                       "spentCash": "0.00",
                                       "spentCredit": "0.00",
                                       "sessionsID": sessionsID,
                                       "name": name]
                
                let memberBudgets = [HelperService.hs.userID: groupfinancials]
                
                let groupDict = ["name": groupName as AnyObject,
                                 "budget": "0.00" as AnyObject,
                                 "spent": "0.00" as AnyObject,
                                 "spentCash": "0.00" as AnyObject,
                                 "spentCredit": "0.00" as AnyObject,
                                 "memberBudgets": memberBudgets as AnyObject] as [String : AnyObject]
                
                let ref = FB_DATABASE_REF.child("groups").childByAutoId()
                let groupID = ref.key
                
                ref.setValue(groupDict) { (error, ref) -> Void in
                    if error == nil {
                        self.defaults.set(ref.key, forKey: "prefGroup")
                        
                        completion(groupID)
                    } else {
                        print("\(error.debugDescription)")
                        completion("error")
                    }
                }
            } else {
                print("\(error.debugDescription)")
                completion("error")
            }
        }
    }
    
    func updateGroupBudget(group: String, budget: String, completion:@escaping (_ result: String) -> Void) {
        
        // Update existing budget in Group's budget
        
        let newBudgetDict = ["budget": budget]
        
        FB_DATABASE_REF.child("groups").child(group).updateChildValues(newBudgetDict) { (error, ref) -> Void in
            if error == nil {
                completion("done")
            } else {
                print("\(error.debugDescription)")
                completion("error")
            }
        }
    }
    
    func updateSessionGroupBudget(group: String, groupSpentCash: String, groupSpentCredit: String, member: String, spentCash: String, spentCredit: String, completion:@escaping (_ result: String) -> Void) {
        
        // Update Group's budget data to account for a Session
        // ALL SPENT VALUES ACCURATE PRIOR TO ENTERING FUNCTION
        
        let memberBudgets = ["spent": "\(Double(spentCash)! + Double(spentCredit)!)",
                             "spentCash": spentCash,
                             "spentCredit": spentCredit]
        
        let member = [HelperService.hs.userID: memberBudgets]
        
        let groupDict = ["spent": "\(Double(groupSpentCash)! + Double(groupSpentCredit)!)" as AnyObject,
                         "spentCash": groupSpentCash as AnyObject,
                         "spentCredit": groupSpentCredit as AnyObject,
                         "memberBudgets": member as AnyObject] as [String : AnyObject]
        
        FB_DATABASE_REF.child("groups").child(group).updateChildValues(groupDict) { (error, ref) -> Void in
            if error == nil {
                completion("done")
            } else {
                print("\(error.debugDescription)")
                completion("error")
            }
        }
    }
    
    func updateMemberGroupBudget(group: String, member: String, budget: String, completion:@escaping (_ result: String) -> Void) {
        
        // Update a Member's portion of the Group's budget
        
        let memberDict = ["budget": budget]
        
        FB_DATABASE_REF.child("groups").child(group).child("memberBudgets").child(member).updateChildValues(memberDict) { (error, ref) -> Void in
            if error == nil {
                completion("done")
            } else {
                print("\(error.debugDescription)")
                completion("error")
            }
        }
    }
    
    func getGroupData(group: String, completion:@escaping (_ result: [String: AnyObject]) -> Void) {
        var groupDict = [String: AnyObject]()
        
        FB_DATABASE_REF.child("groups").child(group).observe(FIRDataEventType.value, with: { (snapshot) in
            let returnedDict = snapshot.value as? [String : AnyObject] ?? [:]
            
            groupDict["groupID"] = group as AnyObject?
            
            if returnedDict["groupName"] != nil {
                groupDict["groupName"] = "\(returnedDict["groupName"]!)" as AnyObject?
            } else {
                groupDict["groupName"] = "" as AnyObject?
            }
            
            if returnedDict["spent"] != nil {
                groupDict["spent"] = "\(returnedDict["spent"]!)" as AnyObject?
            } else {
                groupDict["spent"] = "" as AnyObject?
            }
            
            if returnedDict["budget"] != nil {
                groupDict["budget"] = "\(returnedDict["budget"]!)" as AnyObject?
            } else {
                groupDict["budget"] = "" as AnyObject?
            }
            
            if returnedDict["spentCash"] != nil {
                groupDict["spentCash"] = "\(returnedDict["spentCash"]!)" as AnyObject?
            } else {
                groupDict["spentCash"] = "" as AnyObject?
            }
            
            if returnedDict["spentCredit"] != nil {
                groupDict["spentCredit"] = "\(returnedDict["spentCredit"]!)" as AnyObject?
            } else {
                groupDict["spentCredit"] = "" as AnyObject?
            }
            
            if returnedDict["memberBudgets"] != nil {
                
                var memberArray = [[String: AnyObject]]()
                
                for (k, v) in returnedDict["memberBudgets"] as! [String: AnyObject] {
                    let valueDict = v as! [String: String]
                    print("\(valueDict["spent"]!)")
                    
                    self.getImage(member: k) {
                        (theImage: UIImage) in
                        
                        let memberDict = ["budget": "\(valueDict["budget"]!)" as AnyObject,
                            "spent": "\(valueDict["spent"]!)" as AnyObject,
                            "sessionsID": "\(valueDict["sessionsID"]!)" as AnyObject,
                            "name": "\(valueDict["name"]!)" as AnyObject,
                            "spentCash": "\(valueDict["spentCash"]!)" as AnyObject,
                            "spentCredit": "\(valueDict["spentCredit"]!)" as AnyObject,
                            "userImage": theImage] as [String : AnyObject]
                        
                        memberArray.append([k: memberDict as AnyObject])
                        groupDict["memberBudgets"] = memberArray as AnyObject?
                        
                        print("\((returnedDict["memberBudgets"] as! [String: AnyObject]).count) - \(memberArray.count)")
                        
                        if k == HelperService.hs.userID {
                            self.defaults.set("\(valueDict["sessionsID"]!)", forKey: "prefSessionsID")
                        }
                                                
                        if (returnedDict["memberBudgets"] as! [String: AnyObject]).count == memberArray.count {
                            completion(groupDict)
                        }
                    }
                }
            }
        })
    }
    
    func userImage(imageURL: String, completion:@escaping (_ result: UIImage) -> Void) {
        Alamofire.request(imageURL).responseData { response in
            guard let data = response.result.value else { return }
            completion(UIImage(data: data, scale:1)!)
        }
    }
    
    func getImage(member: String, completion:@escaping (_ result: UIImage) -> Void) {
        
        // Get members imageURL + return UIImage using Alamofire
        
        FB_DATABASE_REF.child("users").child(member).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.childSnapshot(forPath: "imageURL").value ?? "NOTHING")
            
            if snapshot.childSnapshot(forPath: "imageURL").value != nil {
                Alamofire.request("\(snapshot.childSnapshot(forPath: "imageURL").value!)").responseData { response in
                    guard let data = response.result.value else { return }
                    
                    completion(UIImage(data: data, scale:1)!)
                }
            }
        })
    }
    
    func getUserData(completion:@escaping (_ result: [String: String]) -> Void) {
        var userDict = [String: String]()
        
        FB_DATABASE_REF.child("users").child(HelperService.hs.userID).observeSingleEvent(of: .value, with: { (snapshot) in
            let returnedDict = snapshot.value as? [String : String] ?? [:]
            
            if returnedDict["name"] != nil {
                userDict["name"] = "\(returnedDict["name"]!)"
            } else {
                userDict["name"] = ""
            }
            
            if returnedDict["imageURL"] != nil {
                userDict["imageURL"] = "\(returnedDict["imageURL"]!)"
            } else {
                userDict["imageURL"] = ""
            }
            
            if returnedDict["groups"] != nil {
                userDict["groups"] = "\(returnedDict["groups"]!)"
                self.defaults.set("\(returnedDict["groups"]!)", forKey: "groups")
            } else {
                userDict["groups"] = ""
            }
            
            if returnedDict["email"] != nil {
                userDict["email"] = "\(returnedDict["email"]!)"
            } else {
                userDict["email"] = ""
            }
            
            completion(userDict)
        })
    }
    
    // Sessions
    
    func getSessions(completion:@escaping (_ result: [String: AnyObject]) -> Void) {
        
        var sessionsDict = [String: AnyObject]()
        
        FB_DATABASE_REF.child("sessions").child(HelperService.hs.prefGroupSessions).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let returnedDict = snapshot.value as? [String : AnyObject] ?? [:]
            
            if returnedDict["name"] != nil {
                sessionsDict["name"] = "\(returnedDict["name"]!)" as AnyObject?
            } else {
                sessionsDict["name"] = "" as AnyObject?
            }
            
            if returnedDict["groupName"] != nil {
                sessionsDict["groupName"] = "\(returnedDict["groupName"]!)" as AnyObject?
            } else {
                sessionsDict["groupName"] = "" as AnyObject?
            }
            
            if returnedDict["budget"] != nil {
                sessionsDict["budget"] = "\(returnedDict["budget"]!)" as AnyObject?
            } else {
                sessionsDict["budget"] = "" as AnyObject?
            }
            
            if returnedDict["spentCash"] != nil {
                sessionsDict["spentCash"] = "\(returnedDict["spentCash"]!)" as AnyObject?
            } else {
                sessionsDict["spentCash"] = "" as AnyObject?
            }
            
            if returnedDict["spentCredit"] != nil {
                sessionsDict["spentCredit"] = "\(returnedDict["spentCredit"]!)" as AnyObject?
            } else {
                sessionsDict["spentCredit"] = "" as AnyObject?
            }
            
            if returnedDict["individualSessions"] != nil {
                
                var sessionsArray = [[String: AnyObject]]()
                
                for (_, v) in returnedDict["individualSessions"] as! [String: AnyObject] {
                    let valueDict = v as! [String: String]
                    
                    let individualSessionsDict = ["budget": "\(valueDict["budget"]!)" as AnyObject,
                                      "spent": "\(valueDict["spent"]!)" as AnyObject,
                                      "spentCash": "\(valueDict["spentCash"]!)" as AnyObject,
                                      "spentCredit": "\(valueDict["spentCredit"]!)" as AnyObject,
                                      "date": "\(valueDict["date"]!)" as AnyObject]
                    
                    sessionsArray.append(individualSessionsDict)
//                    sessionsArray.append([k: individualSessionsDict as AnyObject])
                    sessionsDict["individualSessions"] = sessionsArray as AnyObject?
                    
                    if (returnedDict["individualSessions"] as! [String: AnyObject]).count == sessionsArray.count {
                        completion(sessionsDict)
                    }
                }
            } else {
                completion(sessionsDict)
            }
        })
    }
    
    func saveNewSession(spentCashMaster: String, spentCreditMaster: String, budget: String, spent: String, spentCash: String, spentCredit: String, completion:@escaping (_ result: String) -> Void) {
        
        let individualDict = ["date": HelperService.hs.dateToday(),
                           "budget": budget,
                           "spent": spent,
                           "spentCash": spentCash,
                           "spentCredit": spentCredit]
        
        let sessionDict = ["spentCash": String(format: "%.2f", (Double(spentCashMaster)!) + (Double(spentCash)!)),
                           "spentCredit": String(format: "%.2f", (Double(spentCreditMaster)!) + (Double(spentCredit)!))]
//                           "individualSessions": individualDict as AnyObject] as [String : AnyObject]
        
        FB_DATABASE_REF.child("sessions").child(HelperService.hs.prefGroupSessions).updateChildValues(sessionDict) { (error, ref) -> Void in
            
            if error == nil {
                FB_DATABASE_REF.child("sessions").child(HelperService.hs.prefGroupSessions).child("individualSessions").childByAutoId().updateChildValues(individualDict) { (error, ref) -> Void in
                    
                    if error == nil {
                        self.updateBudgetSession(spent: spent, spentCash: spentCash, spentCredit: spentCredit)
                        completion("done")
                    } else {
                        print("\(error.debugDescription)")
                        completion("error")
                    }
                }
            } else {
                print("\(error.debugDescription)")
                completion("error")
            }
        }
    }
    
    func updateBudgetSession(spent: String, spentCash: String, spentCredit: String) {
        
        // Group data transaction
        
        FB_DATABASE_REF.child("groups").child(HelperService.hs.prefGroup).runTransactionBlock({ (currentData: FIRMutableData) -> FIRTransactionResult in
            
            if var budgetData = currentData.value as? [String : AnyObject] {
//                budgetData["spent"]!    String(format: "%.2f", (spentAmt - budgetAmt))
                
                if budgetData["spent"] != nil {
                    
                    var spentSaved = budgetData["spent"] as? String
                    spentSaved = String(format: "%.2f", (Double(spentSaved!)!) + (Double(spent)!))
                    budgetData["spent"] = spentSaved as AnyObject?
                }
                
                if budgetData["spentCash"] != nil {
                    var cashSaved = budgetData["spentCash"] as? String
                    cashSaved = String(format: "%.2f", (Double(cashSaved!)!) + (Double(spentCash)!))
                    budgetData["spentCash"] = cashSaved as AnyObject?
                }
                
                if budgetData["spentCredit"] != nil {
                    var creditSaved = budgetData["spentCredit"] as? String
                    creditSaved = String(format: "%.2f", (Double(creditSaved!)!) + (Double(spentCredit)!))
                    budgetData["spentCredit"] = creditSaved as AnyObject?
                }
            
                currentData.value = budgetData
                
                return FIRTransactionResult.success(withValue: currentData)
            }
            return FIRTransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        // Member data transaction
        
        FB_DATABASE_REF.child("groups").child(HelperService.hs.prefGroup).child("memberBudgets").child(HelperService.hs.userID).runTransactionBlock({ (currentData: FIRMutableData) -> FIRTransactionResult in
            
            if var budgetData = currentData.value as? [String : AnyObject] {
                //                budgetData["spent"]!    String(format: "%.2f", (spentAmt - budgetAmt))
                
                if budgetData["spent"] != nil {
                    var spentSaved = budgetData["spent"] as? String
                    spentSaved = String(format: "%.2f", (Double(spentSaved!)!) + (Double(spent)!))
                    budgetData["spent"] = spentSaved as AnyObject?
                }
                
                if budgetData["spentCash"] != nil {
                    var cashSaved = budgetData["spentCash"] as? String
                    cashSaved = String(format: "%.2f", (Double(cashSaved!)!) + (Double(spentCash)!))
                    budgetData["spentCash"] = cashSaved as AnyObject?
                }
                
                if budgetData["spentCredit"] != nil {
                    var creditSaved = budgetData["spentCredit"] as? String
                    creditSaved = String(format: "%.2f", (Double(creditSaved!)!) + (Double(spentCredit)!))
                    budgetData["spentCredit"] = creditSaved as AnyObject?
                }
                
                currentData.value = budgetData
                
                return FIRTransactionResult.success(withValue: currentData)
            }
            return FIRTransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // Auth
    
    func createAccount(email: String, password: String, completion:@escaping (_ result: String) -> Void) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                
                self.defaults.set("\(user!.uid)", forKey: "userID")
                self.defaults.set(true, forKey: "isLoggedIn")
                
                completion("done")
            } else {
                completion("error")
                print("CREATE ISSUE: \(error.debugDescription)")
                
            }
        }
    }
    
    func completeAccount(email: String, name: String, image: UIImage, groupName: String, completion:@escaping (_ result: String) -> Void) {
        
        saveGroup(groupName: groupName, name: name) {
            (result: String) in
            
            self.defaults.set("\(HelperService.hs.groups)\(result),", forKey: "groups")
            
            self.saveUserImage(imageToSave: image) {
                (resultImage: String) in
                
                let userDict = ["name": name,
                                "imageURL": resultImage,
                                "groups": HelperService.hs.groups,
                                "email": email]
                
                FB_DATABASE_REF.child("users").child(HelperService.hs.userID).setValue(userDict) { (error, ref) -> Void in
                    if error == nil {
                        completion("done")
                    } else {
                        print("\(error.debugDescription)")
                        
                        completion("error")
                    }
                }
            }
        }
    }
    
    func login(email: String, password: String, completion:@escaping (_ result: String) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            self.getUserData() {
                (result: [String: String]) in
                
                self.defaults.set(true, forKey: "isLoggedIn")
                completion("done")
            }
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
}
