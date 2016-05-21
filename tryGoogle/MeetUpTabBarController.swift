//
//  MeetUpTabBarController.swift
//  MeetUp
//
//  Created by Pro on 17/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class MeetUpTabBarController: UITabBarController {
    var usersEventModel = UsersEventModel()
    
    
    var user: User?
    var myEvents: [MyEvent]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainPageNavigation = self.viewControllers![0] as! UINavigationController
        let mainPage = mainPageNavigation.topViewController as! MainPageController
        let eventPageNavigation = self.viewControllers![1] as! UINavigationController
        let eventPage = eventPageNavigation.topViewController as! AllEventController
        let friendPageNavigation = self.viewControllers![2] as! UINavigationController
        let friendPage = friendPageNavigation.topViewController as! FriendPageController
        mainPage.user = self.user
        eventPage.user = self.user
        friendPage.user = self.user

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let currentDate = NSDate()
        let convertedDate = dateFormatter.stringFromDate(currentDate)
        
        myEvents = usersEventModel.getEventsByUserAndDate((user?.email)!, date: convertedDate)
        
        let defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.app-ID")!
        defaults.setObject(["One", "Two"], forKey: "bookmarks")
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
