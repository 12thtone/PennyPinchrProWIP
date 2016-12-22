//
//  ProfileViewController.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/15/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userImageView: ImageViewRadius!
    @IBOutlet weak var budgetStatusImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    var sessions = [SessionModel]()
    
    var userImage: UIImage?
    var userName: String?
    var userBudget: String?
    var userCash: String?
    var userCredit: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProfileData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadProfileData() {
        DataService.ds.getIndSessions() {
            (result: [[String: String]]) in
            
            print(result)
            
            for session in result {
                self.sessions.append(SessionModel.init(session: session as [String : AnyObject]))
                
                if result.count == self.sessions.count {
                    self.setViews()
                }
            }
        }
    }
    
    func setViews() {
        userImageView.image = userImage
        nameLabel.text = userName!
        budgetLabel.text = userBudget!
        percentLabel.text = "CALC ME!!!"
        cashLabel.text = userCash!
        creditLabel.text = userCredit!
        countLabel.text = "\(sessions.count)"
        avgLabel.text = HelperService.hs.sessionAverage(sessions: sessions)
        maxLabel.text = HelperService.hs.sessionMax(sessions: sessions)
    }
    
    @IBAction func editTapped(_ sender: Any) {
        
    }
    
    @IBAction func messageTapped(_ sender: Any) {
        
    }
    
    @IBAction func yayTapped(_ sender: Any) {
        
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
