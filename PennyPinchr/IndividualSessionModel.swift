//
//  IndividualSessionModel.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/20/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import Foundation

class IndividualSessionModel {
    
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
    
    init(session: [String: AnyObject]) {
        
        if session["date"] != nil {
            self._date = "\(session["date"]!)"
        } else {
            self._date = ""
        }
        
        if session["spent"] != nil {
            self._spent = "\(session["spent"]!)"
        } else {
            self._spent = ""
        }
        
        if session["spentCash"] != nil {
            self._spentCash = "\(session["spentCash"]!)"
        } else {
            self._spentCash = ""
        }
        
        if session["spentCredit"] != nil {
            self._spentCredit = "\(session["spentCredit"]!)"
        } else {
            self._spentCredit = ""
        }
        
        if session["budget"] != nil {
            self._budget = "\(session["budget"]!)"
        } else {
            self._budget = ""
        }
        
        if session["budgetID"] != nil {
            self._budgetID = "\(session["budgetID"]!)"
        } else {
            self._budgetID = ""
        }
    }
}
