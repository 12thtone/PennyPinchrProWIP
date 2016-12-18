//
//  BudgetModel.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/12/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import Foundation
import CoreData

class BudgetModel {
    
    private var _budget: String!
    private var _budgetID: String!
    private var _spent: String!
    private var _spentCash: String!
    private var _spentCredit: String!
    
    var budget: String {
        return _budget
    }
    
    var budgetID: String {
        return _budgetID
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
    
    init(budget: [String: String]) {
        if let currentBudget = budget["budget"] {
            if currentBudget != "" {
                self._budget = "\(currentBudget)"
            } else {
                self._budget = "0.00"
            }
        } else {
            self._budget = "0.00"
        }
        
        if let currentBudgetID = budget["budgetID"] {
            if currentBudgetID != "" {
                self._budgetID = "\(currentBudgetID)"
            } else {
                self._budgetID = "0.00"
            }
        } else {
            self._budgetID = "0.00"
        }
        
        if let currentSpent = budget["spent"] {
            if currentSpent != "" {
                self._spent = "\(currentSpent)"
            } else {
                self._spent = "0.00"
            }
        } else {
            self._spent = "0.00"
        }
        
        if let currentSpentCash = budget["spentCash"] {
            if currentSpentCash != "" {
                self._spentCash = "\(currentSpentCash)"
            } else {
                self._spentCash = "0.00"
            }
        } else {
            self._spentCash = "0.00"
        }
        
        if let currentSpentCredit = budget["spentCredit"] {
            if currentSpentCredit != "" {
                self._spentCredit = "\(currentSpentCredit)"
            } else {
                self._spentCredit = "0.00"
            }
        } else {
            self._spentCredit = "0.00"
        }
    }
}
