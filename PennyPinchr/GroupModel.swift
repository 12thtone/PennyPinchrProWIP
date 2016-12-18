//
//  GroupModel.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/18/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import Foundation
import CoreData

class GroupModel {
    
    private var _groupName: String!
    private var _groupID: String!
    private var _budget: String!
    private var _spent: String!
    private var _spentCash: String!
    private var _spentCredit: String!
    
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
    
    init(session: NSManagedObject) {
        
        if let indGroupName = session.value(forKey: "groupName") {
            self._groupName = "\(indGroupName)"
        }
        
        if let indGroupID = session.value(forKey: "groupID") {
            self._groupID = "\(indGroupID)"
        }
        
        if let indBudget = session.value(forKey: "budget") {
            self._budget = "\(indBudget)"
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
    }
}
