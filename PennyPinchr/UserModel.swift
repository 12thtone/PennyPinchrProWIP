//
//  UserModel.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/15/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import Foundation
import Firebase

class UserModel {
    
    private var _name: String!
    private var _spent: String!
    private var _spentCash: String!
    private var _spentCredit: String!
    
    ////
    
    private var _email: String!
    private var _prefGroup: String!
    private var _userGroups: String!
    private var _userBudgets: String!
    private var _imageURL: String!
    private var _userImage: UIImage!
    private var _userID: String!
    private var _userSessions: String!
    
    var name: String {
        return _name
    }
    
    var spent: String {
        return _spent
    }
    
    var spentCash: String {
        return _spentCash
    }
    
    var spentCredit: String {
        return _spentCredit
    }
    
    ////
    
    var email: String {
        return _email
    }
    
    var prefGroup: String {
        return _prefGroup
    }
    
    var userGroups: String {
        return _userGroups
    }
    
    var userBudgets: String {
        return _userBudgets
    }
    
    var imageURL: String {
        return _imageURL
    }
    
    var userImage: UIImage {
        return _userImage
    }
    
    var userID: String {
        return _userID
    }
    
    var userSessions: String {
        return _userSessions
    }
    
    init(user: [String: AnyObject]) {
        
        if let nameRetrieved = user["name"] {
            self._name = "\(nameRetrieved)"
        } else {
            self._name = ""
        }
        
        if let emailRetrieved = user["email"] {
            self._email = "\(emailRetrieved)"
        } else {
            self._email = ""
        }
        
        if let prefGroupRetrieved = user["prefGroup"] {
            self._prefGroup = "\(prefGroupRetrieved)"
        } else {
            self._prefGroup = ""
        }
        
        if let userGroupsRetrieved = user["userGroups"] {
            self._userGroups = "\(userGroupsRetrieved)"
        } else {
            self._userGroups = ""
        }
        
        if let userBudgetsRetrieved = user["userBudgets"] {
            self._userBudgets = "\(userBudgetsRetrieved)"
        } else {
            self._userBudgets = ""
        }
        
        if let imageURLRetrieved = user["imageURL"] {
            self._imageURL = "\(imageURLRetrieved)"
        } else {
            self._imageURL = ""
        }
        
        if let userImageRetrieved = user["userImage"] {
            self._userImage = userImageRetrieved as! UIImage
        } else {
            self._userImage = UIImage(named: "no_img")
        }
        
        if let userIDRetrieved = user["userID"] {
            self._userID = "\(userIDRetrieved)"
        } else {
            self._userID = ""
        }
        
        if let userSessionsRetrieved = user["userSessions"] {
            self._userSessions = "\(userSessionsRetrieved)"
        } else {
            self._userSessions = ""
        }
    }
}
