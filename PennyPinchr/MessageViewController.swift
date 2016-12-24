//
//  MessageViewController.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/23/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var messages = [MessageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        loadMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMessages() {
        
        DataService.ds.getMessages() {
            (result: [[String: AnyObject]]) in
            
            for eachMessage in result {
                self.messages.append(MessageModel.init(message: eachMessage))
                
                if result.count == self.messages.count {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTVC") as? MessageTableViewCell {
            
            let message = messages[indexPath.row]
            
            cell.nameLabel.text = message.senderName
            cell.messageLabel.text = message.message
            cell.userImageView.image = message.senderImage
            
            return cell
        }
        return MessageTableViewCell()
    }
}
