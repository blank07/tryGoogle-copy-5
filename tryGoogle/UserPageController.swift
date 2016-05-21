//
//  UserPageController.swift
//  MeetUp
//
//  Created by Pro on 20/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class UserPageController: UIViewController {
    var friend: User?
    var me: User?
    var relationShip: Friends?
    
    var userModel = UserModel()
    var friendModel = FriendModel()
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var protrait: UIImageView!
    @IBOutlet weak var addBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.freshUserInfo()
        if friendModel.isFriend((me?.email)!, friendEmail: (friend?.email)!) {
            addBtn.setTitle("You are already been friend", forState: UIControlState.Normal)
            addBtn.enabled = false
        }
    }
    
    @IBAction func addFriend(sender: UIButton) {
        friendModel.addFriend((me?.email)!, friendEmail: (friend?.email)!)
        addBtn.setTitle("You are already been friend", forState: UIControlState.Normal)
        addBtn.enabled = false
    }
    
    func freshUserInfo() {
        nameLbl.text = friend?.name
        emailLbl.text = friend?.email
        ageLbl.text = friend?.age
        cityLbl.text = friend?.city
        protrait.image = UIImage(data: (friend?.protrait)!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
