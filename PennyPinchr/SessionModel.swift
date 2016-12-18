//
//  SessionModel.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/11/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import Foundation
import CoreData

class SessionModel {
    
    private var _date: String!
    private var _spent: String!
    private var _spentCash: String!
    private var _spentCredit: String!
    private var _budget: String!
    private var _budgetID: String!
    
    var date: String {
        return _date
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
    
    var budget: String {
        return _budget
    }
    
    var budgetID: String {
        return _budgetID
    }
    
    init(session: NSManagedObject) {
        
        if let indDate = session.value(forKey: "date") {
            self._date = "\(indDate)"
        }
        
        if let indSpent = session.value(forKey: "spent") {
            self._spent = "\(indSpent)"
        }
        
        if let indSpentCash = session.value(forKey: "spentCash") {
            self._spentCash = "\(indSpentCash)"
        }
        
        if let indSpentCredit = session.value(forKey: "spentCredit") {
            self._spentCredit = "\(indSpentCredit)"
        }
        
        if let indBudget = session.value(forKey: "budget") {
            self._budget = "\(indBudget)"
        }
        
        if let indBudgetID = session.value(forKey: "budgetID") {
            self._budgetID = "\(indBudgetID)"
        }
    }
}
