//
//  GroupModel.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/18/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import Foundation

class GroupModel {
    
    private var _groupName: String!
    private var _groupID: String!
    private var _budget: String!
    private var _spent: String!
    private var _spentCash: String!
    private var _spentCredit: String!
    private var _memberBudgets: [[String: String]]!
    
    var groupName: String {
        return _groupName
    }
    
    var groupID: String {
        return _groupID
    }
    
    var budget: String {
        return _budget
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
    
    var memberBudgets: [[String: String]] {
        return _memberBudgets
    }
    
    init(group: [String: AnyObject]) {
        
        if group["name"] != nil {
            self._groupName = "\(group["name"]!)"
        } else {
            self._groupName = ""
        }
        
        if group["budget"] != nil {
            self._budget = "\(group["budget"]!)"
        } else {
            self._budget = ""
        }
        
        if group["spent"] != nil {
            self._spent = "\(group["spent"]!)"
        } else {
            self._spent = ""
        }
        
        if group["spentCash"] != nil {
            self._spentCash = "\(group["spentCash"]!)"
        } else {
            self._spentCash = ""
        }
        
        if group["spentCredit"] != nil {
            self._spentCredit = "\(group["spentCredit"]!)"
        } else {
            self._spentCredit = ""
        }
        
        if group["groupName"] != nil {
            self._spentCredit = "\(group["name"]!)"
        } else {
            self._groupName = ""
        }
    }
}
