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
    private var _spent: String!
    private var _cashSpent: String!
    private var _creditSpent: String!
    
    var budget: String {
        return _budget
    }
    
    var spent: String {
        return _spent
    }
    
    var cashSpent: String {
        return _cashSpent
    }
    
    var creditSpent: String {
        return _creditSpent
    }
    
    init(curBudget: [String: String]) {
        if let currentBudget = curBudget["currentBudget"] {
            if currentBudget != "" {
                self._budget = "\(currentBudget)"
            } else {
                self._budget = "0.00"
            }
        } else {
            self._budget = "0.00"
        }
        
        if let currentSpent = curBudget["currentSpent"] {
            if currentSpent != "" {
                self._spent = "\(currentSpent)"
            } else {
                self._spent = "0.00"
            }
        } else {
            self._spent = "0.00"
        }
        
        if let currentCashSpent = curBudget["currentSpentCash"] {
            if currentCashSpent != "" {
                self._cashSpent = "\(currentCashSpent)"
            } else {
                self._cashSpent = "0.00"
            }
        } else {
            self._cashSpent = "0.00"
        }
        
        if let currentCreditSpent = curBudget["currentSpentCredit"] {
            if currentCreditSpent != "" {
                self._creditSpent = "\(currentCreditSpent)"
            } else {
                self._creditSpent = "0.00"
            }
        } else {
            self._creditSpent = "0.00"
        }
    }
}
