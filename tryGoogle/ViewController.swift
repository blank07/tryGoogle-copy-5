//
//  ViewController.swift
//  MeetUpGroup
//
//  Created by Pro on 2/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pswField: UITextField!
    
    var loginModel = LoginModel()
    var userModel = UserModel()
    
    var user: User?
    
    @IBAction func loginBtnPressed(sender: UIButton) {
        self.checkPassword(emailField.text!, pwd: pswField.text!)
        if(user != nil) {
            let model = NSUserDefaults.standardUserDefaults()
            model.setValue(user?.email, forKey: "email")
            model.setValue(user?.name, forKey: "name")
            model.setValue(user?.city, forKey: "userCity")
            model.setValue(user?.protrait, forKey: "protraitData")
        } else {
            let controller = UIAlertController(title: "Invalid email or password", message: "Please try again", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            controller.addAction(okAction)
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func signUpBtnPressed(sender: UIButton) {
        //jump to sign up page
    }
    
    @IBAction func onTapGestureRecognized(sender: AnyObject) {
        emailField.resignFirstResponder()
        pswField.resignFirstResponder()
    }
    
    func checkPassword(email: String, pwd: String) -> Bool {
        user = userModel.checkUserByEmailAndPwd(email, password: pwd) as? User
        if self.user != nil {
            return true
        }
        return false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMainPage" {
            let mainPage: MeetUpTabBarController = segue.destinationViewController as! MeetUpTabBarController
            mainPage.user = self.user
        }
    }
}

