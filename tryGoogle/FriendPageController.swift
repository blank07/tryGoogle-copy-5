//
//  FriendPageController.swift
//  MeetUp
//
//  Created by Pro on 20/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class FriendPageController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var user: User?
    var myFriends: [Friends]?
    var friendModel = FriendModel()
    var userModel = UserModel()
    var friend: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        myFriends = friendModel.getFriendsByMyEmail((user?.email)!)
    }
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (myFriends?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! FriendPageCellController
        friend = userModel.fetchUserByEmail(myFriends![indexPath.row].friendEmail!)
        cell.protraitImg.image = UIImage(data: (friend?.protrait)!)
        cell.nameLbl.text = friend?.name
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        friend = userModel.fetchUserByEmail(myFriends![indexPath.row].friendEmail!)
        self.performSegueWithIdentifier("showUserInfo", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showUserInfo" {
            let userPageController: UserPageController = segue.destinationViewController as! UserPageController
            userPageController.friend = self.friend
            userPageController.me = self.user
        }
    }
    

}
