//
//  HelperService.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/18/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class HelperService {
    static let hs = HelperService()
    
    let defaults = UserDefaults.standard
    
    var userID: String {
        if defaults.string(forKey: "userID") != nil {
            return defaults.string(forKey: "userID")!
        }
        return ""
    }
    
    var name: String {
        if defaults.string(forKey: "name") != nil {
            return defaults.string(forKey: "name")!
        }
        return ""
    }
    
    var prefGroup: String {
        if defaults.string(forKey: "prefGroup") != nil {
            return defaults.string(forKey: "prefGroup")!
        }
        return ""
    }
    
    var prefGroupSessions: String {
        if defaults.string(forKey: "prefGroupSessions") != nil {
            return defaults.string(forKey: "prefGroupSessions")!
        }
        return ""
    }
    
    var groups: String {
        if defaults.string(forKey: "groups") != nil {
            return defaults.string(forKey: "groups")!
        }
        return ""
    }
    
    var groupID: String {
        if defaults.string(forKey: "groupID") != nil {
            return defaults.string(forKey: "groupID")!
        }
        return ""
    }
    
    var allUsers: String {
        if defaults.string(forKey: "allUsers") != nil {
            return defaults.string(forKey: "allUsers")!
        }
        return ""
    }
    
    func isLogedIn() -> Bool {
        return defaults.bool(forKey: "isLoggedIn")
    }
    
    func toMoney(rawMoney: Double) -> String {
        return "\(moneyCommaFormat(rawMoney: String(format: "%.2f", rawMoney)))"
    }
    
    func toMoneyNDS(rawMoney: Double) -> String {
        return "\(String(format: "%.2f", rawMoney))"
    }
    
    func moneyDouble(rawString: String, charCount: Int) -> String {
        let cleanString = rawString.replacingOccurrences(of: "$", with: "")
        
        return "\(Double(cleanString)! / 100.0)"
    }
    
    func moneyCommaFormat(rawMoney: String) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale!
        
        return formatter.string(from: NSNumber(value: Double(rawMoney)!))!
    }
    
    func cleanDoubleMoney(dirtyString: String) -> Double {
        return Double(dirtyString.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: ""))!
    }
    
    func taxArray() -> [Int] {
        var taxes = [Int]()
        
        for tax in 0...9 {
            taxes.append(tax)
        }
        
        return taxes
    }
    
    func priceWithTax(rawPrice: Double, tax: Double) -> Double {
        var price = 0.0
        
        price = rawPrice * ((tax / 100) + 1)
        
        return price
    }
    
    func dateToday() -> String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        
        return formatter.string(from: today)
    }
    
    func settingsArray() -> [String] {
        return ["Switch Budgets", "Add Budget", "Info", "Logout"]
    }
}
