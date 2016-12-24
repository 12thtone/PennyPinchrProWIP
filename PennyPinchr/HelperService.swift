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
    
    var prefPersonalBudgetSpent: String {
        if defaults.string(forKey: "prefPersonalBudgetSpent") != nil {
            return defaults.string(forKey: "prefPersonalBudgetSpent")!
        }
        return "0.00"
    }
    
    var prefPersonalBudgetRemaining: String {
        if defaults.string(forKey: "prefPersonalBudgetRemaining") != nil {
            return defaults.string(forKey: "prefPersonalBudgetRemaining")!
        }
        return "0.00"
    }
    
    var prefGroupSessions: String {
        if defaults.string(forKey: "prefGroupSessions") != nil {
            return defaults.string(forKey: "prefGroupSessions")!
        }
        return ""
    }
    
    var prefGroupUsers: String {
        if defaults.string(forKey: "prefGroupUsers") != nil {
            return defaults.string(forKey: "prefGroupUsers")!
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
    
    func settingsImageArray() -> [String] {
        return ["switch_groups_mod", "new_group_mod", "info_mod", "logout_mod"]
    }
    
    func calculatedCash(spentAmt: Double, budgetAmt: Double) -> String {
        if spentAmt < budgetAmt {
            return "\(spentAmt)"
        }
        return "\(budgetAmt)"
    }
    
    func calculatedCredit(spentAmt: Double, budgetAmt: Double) -> String {
        if spentAmt < budgetAmt {
            return "0.00"
        }
        return String(format: "%.2f", (spentAmt - budgetAmt))
    }
    
    func sortedArrayByDate(arrayToSort: [[String: AnyObject]]) -> [[String: AnyObject]] {
        let arrangedArray = arrayToSort.sorted(by: compareDates)
        
        return arrangedArray
    }
    
    func compareDates(d1:[String: AnyObject], d2:[String: AnyObject]) -> Bool {
        var date1 = d1["date"]
        var date2 = d2["date"]
        
        if date1 == nil {
            date1 = d1["postDate"]
            date2 = d2["postDate"]
        }
        
        return dateFromString(dateString: "\(date1!)") > dateFromString(dateString: "\(date2!)")
    }
    
    func dateFromString(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        return dateFormatter.date(from: dateString)!
    }
    
    func sessionAverage(sessions: [SessionModel]) -> String {
        var totalSpent = 0.0
        for eachSession in sessions {
            totalSpent += Double(eachSession.spent)!
        }
        return String(format: "%.2f", (totalSpent / Double(sessions.count)))
    }
    
    func sessionMax(sessions: [SessionModel]) -> String {
        var amounts = [Double]()
        for eachSession in sessions {
            amounts.append(Double(eachSession.spent)!)
        }
        return String(format: "%.2f", (amounts.max())!)
    }
    
    func messageText(type: String) -> String {
        if type == "yay" {
            return "Nice job on your budget!"
        } else if type == "invite" {
            return "You're invited to join our budget!"
        } else if type == "overMaster" {
            return "Uh oh... Your master budget has been exceeded."
        } else if type == "overPersonal" {
            return "Oops... You've overspent your personal budget."
        } else if type == "masterChanged" {
            return "Your master budget has been changed."
        } else if type == "personalChanged" {
            return "Your personal budget has been changed."
        } else if type == "welcomeApp" {
            return "Welcome to PennyPinchr - Your Budgeting Team App"
        } else if type == "welcomeGroup" {
            return "Welcome to the group!"
        }

        return "MESSAGE ERROR"
    }
}
