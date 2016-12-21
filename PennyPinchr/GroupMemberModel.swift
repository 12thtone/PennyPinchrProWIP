//
//  GroupMemberModel.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/20/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class GroupMemberModel {
    
    private var _budget: String!
    private var _spent: String!
    private var _spentCash: String!
    private var _spentCredit: String!
    private var _name: String!
    private var _memberImage: UIImage!
    
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
    
    var name: String {
        return _name
    }
    
    var memberImage: UIImage {
        return _memberImage
    }
    
    init(member: [String: AnyObject]) {
        
        if member["budget"] != nil {
            self._budget = "\(member["budget"]!)"
        } else {
            self._budget = "0.00"
        }
        
        if member["spent"] != nil {
            self._spent = "\(member["spent"]!)"
        } else {
            self._spent = "0.00"
        }
        
        if member["spentCash"] != nil {
            self._spentCash = "\(member["spentCash"]!)"
        } else {
            self._spentCash = "0.00"
        }
        
        if member["spentCredit"] != nil {
            self._spentCredit = "\(member["spentCredit"]!)"
        } else {
            self._spentCredit = "0.00"
        }
        
        if member["name"] != nil {
            self._name = "\(member["name"]!)"
        } else {
            self._name = ""
        }
        
        if member["userImage"] != nil {
            self._memberImage = member["userImage"] as! UIImage
        } else {
            self._memberImage = UIImage(named: "no_img")
        }
    }
}
