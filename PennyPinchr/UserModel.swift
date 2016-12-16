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
    private var _periodBudget: String!
    private var _periodTotalSpent: String!
    private var _periodCashSpent: String!
    private var _periodCreditSpent: String!
    private var _imageURL: String!
    private var _userImage: UIImage!
    
    var name: String {
        return _name
    }
    
    var periodBudget: String {
        return _periodBudget
    }
    
    var periodTotalSpent: String {
        return _periodTotalSpent
    }
    
    var periodCashSpent: String {
        return _periodCashSpent
    }
    
    var periodCreditSpent: String {
        return _periodCreditSpent
    }
    
    var imageURL: String {
        return _imageURL
    }
    
    var userImage: UIImage {
        return _userImage
    }
    
    init(user: [String: AnyObject]) {
        if let nameRetrieved = user["name"] {
            self._name = "\(nameRetrieved)"
        }
        
        if let periodBudgetRetrieved = user["periodBudget"] {
            self._periodBudget = "\(periodBudgetRetrieved)"
        }
        
        if let periodTotalSpentRetrieved = user["periodTotalSpent"] {
            self._periodTotalSpent = "\(periodTotalSpentRetrieved)"
        }
        
        if let periodCashSpentRetrieved = user["periodCashSpent"] {
            self._periodCashSpent = "\(periodCashSpentRetrieved)"
        }
        
        if let periodCreditSpentRetrieved = user["periodCreditSpent"] {
            self._periodCreditSpent = "\(periodCreditSpentRetrieved)"
        }
        
        if let imageURLRetrieved = user["imageURL"] {
            self._imageURL = "\(imageURLRetrieved)"
        }
    }
}
