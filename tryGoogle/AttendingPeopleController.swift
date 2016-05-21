
//
//  AttendingPeopleController.swift
//  MeetUp
//
//  Created by Pro on 20/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class AttendingPeopleController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var myEvents: [MyEvent]?
    var event: Event?
    var user: User?
    var userEventModel = UsersEventModel()
    var userModel = UserModel()
    
    var attendingUser: User?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func viewWillAppear(animated: Bool) {
        myEvents = userEventModel.getUsersByEvent((event?.title)!)
    }
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (myEvents?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! AttendingPeopleCell
        attendingUser = userModel.fetchUserByEmail(myEvents![indexPath.row].email!)
        cell.nameLbl.text = attendingUser?.name
        cell.poster.image = UIImage(data: (attendingUser?.protrait)!)
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        attendingUser = userModel.fetchUserByEmail(myEvents![indexPath.row].email!)
        self.performSegueWithIdentifier("showUserInfo", sender: self)
    }



    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showUserInfo" {
            let userPageController: UserPageController = segue.destinationViewController as! UserPageController
            userPageController.friend = self.attendingUser
            userPageController.me = self.user
        }
    }
    

}
