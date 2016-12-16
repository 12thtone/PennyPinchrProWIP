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
    
    init(curBudget: FIRDataSnapshot) {
        if let nameRetrieved = curBudget.value(forKey: "name") {
            self._name = "\(nameRetrieved)"
        }
        
        if let periodBudgetRetrieved = curBudget.value(forKey: "periodBudget") {
            self._periodBudget = "\(periodBudgetRetrieved)"
        }
        
        if let periodTotalSpentRetrieved = curBudget.value(forKey: "periodTotalSpent") {
            self._periodTotalSpent = "\(periodTotalSpentRetrieved)"
        }
        
        if let periodCashSpentRetrieved = curBudget.value(forKey: "periodCashSpent") {
            self._periodCashSpent = "\(periodCashSpentRetrieved)"
        }
        
        if let periodCreditSpentRetrieved = curBudget.value(forKey: "periodCreditSpent") {
            self._periodCreditSpent = "\(periodCreditSpentRetrieved)"
        }
        
        if let imageURLRetrieved = curBudget.value(forKey: "imageURL") {
            self._imageURL = "\(imageURLRetrieved)"
        }
    }
}
