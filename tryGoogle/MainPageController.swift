//
//  FirstViewController.swift
//  MeetUpGroup
//
//  Created by ChongSun on 29/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class MainPageController: UIViewController {
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    var userInfo = UserInfo()
    var userModel = UserModel()
    var usersEventModel = UsersEventModel()
    
    var userEmail: String?
    var user: User?
    var myEvents: [MyEvent]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = user?.name
        emailTextField.text = user?.email
        ageTextField.text = user?.age
        cityTextField.text = user?.city
        protrait.image = UIImage(data: user!.protrait!, scale: 1)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let currentDate = NSDate()
        let convertedDate = dateFormatter.stringFromDate(currentDate)
        
        myEvents = usersEventModel.getEventsByUserAndDate((user?.email)!, date: convertedDate)
        var eventsTitle: [String]?
        for event in myEvents! {
            if (eventsTitle?.append(event.title!)) == nil {
                eventsTitle = [event.title!]
            }
        }
        //NSNotificationCenter.defaultCenter().postNotificationName("title", object: nil, userInfo: ["MyTitles": eventsTitle!])
        
        let defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.MeetUpToday")!
        defaults.setObject(eventsTitle, forKey: "titles")
        defaults.synchronize()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
    @IBAction func editProfile(sender: UIBarButtonItem) {
        if(editBarButton.title == "Edit"){
            nameTextField.enabled = true
            emailTextField.enabled = true
            ageTextField.enabled = true
            cityTextField.enabled = true
            editBarButton.title = "Confirm"
        }else{
            nameTextField.enabled = false
            emailTextField.enabled = false
            ageTextField.enabled = false
            cityTextField.enabled = false
            editBarButton.title = "Edit"
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var protrait: UIImageView!
    
    @IBAction func onTapped(sender: AnyObject) {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMyEventsPage" {
            let eventController: MyEventController = segue.destinationViewController as! MyEventController
            eventController.user = self.user
        }
    }
    
}

