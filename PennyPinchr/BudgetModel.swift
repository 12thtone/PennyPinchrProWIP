//
//  BudgetModel.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/12/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import Foundation

class BudgetModel {
    
    private var _budget: Double!
    private var _spent: Double!
    private var _percentOfBudget: Int!
    
    var budget: Double {
        return _budget
    }
    
    var spent: Double {
        return _spent
    }
    
    var percentOfBudget: Int {
        return _percentOfBudget
    }
    
    init(budget: [String: AnyObject]) {
        
        if budget["budget"] != nil {
            _budget = Double("\(budget["budget"]!)")!
        } else {
            _budget = 0.00
        }
        
        if budget["spent"] != nil {
            _spent = Double("\(budget["spent"]!)")!
        } else {
            _spent = 0.00
        }
        
        if budget["budget"] != nil {
            
            _percentOfBudget = Int((_spent! / _budget!) * 100)
        } else {
            _percentOfBudget = 0
        }
    }
}
