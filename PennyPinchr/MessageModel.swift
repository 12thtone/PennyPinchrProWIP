//
//  MessageModel.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/23/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class MessageModel {
    
    private var _sender: String!
    private var _senderName: String!
    private var _receiver: String!
    private var _senderImage: UIImage!
    private var _message: String!
    private var _messageType: String!
    private var _messageData: String!
    private var _date: String!
    
    var sender: String {
        return _sender
    }
    
    var senderName: String {
        return _senderName
    }
    
    var receiver: String {
        return _receiver
    }
    
    var senderImage: UIImage {
        return _senderImage
    }
    
    var message: String {
        return _message
    }
    
    var messageType: String {
        return _messageType
    }
    
    var messageData: String {
        return _messageData
    }
    
    var date: String {
        return _date
    }
    
    init(message: [String: AnyObject]) {
        
        if message["sender"] != nil {
            self._sender = "\(message["sender"]!)"
        } else {
            self._sender = ""
        }
        
        if message["senderName"] != nil {
            self._senderName = "\(message["senderName"]!)"
        } else {
            self._senderName = ""
        }
        
        if message["receiver"] != nil {
            self._receiver = "\(message["receiver"]!)"
        } else {
            self._receiver = ""
        }
        
        if message["senderImage"] != nil {
            self._senderImage = message["senderImage"] as! UIImage
        } else {
            self._senderImage = UIImage(named: "no_img")
        }
        
        if message["message"] != nil {
            self._message = "\(message["message"]!)"
        } else {
            self._message = ""
        }
        
        if message["messageType"] != nil {
            self._messageType = "\(message["messageType"]!)"
        } else {
            self._messageType = ""
        }
        
        if message["messageData"] != nil {
            self._messageData = "\(message["messageData"]!)"
        } else {
            self._messageData = ""
        }
        
        if message["date"] != nil {
            self._date = "\(message["date"]!)"
        } else {
            self._date = ""
        }
    }
}
