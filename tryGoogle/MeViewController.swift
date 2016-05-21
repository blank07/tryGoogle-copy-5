//
//  FirstViewController.swift
//  MeetUpGroup
//
//  Created by ChongSun on 29/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    var userInfo = UserInfo()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.text = userInfo.userInfo["name"]
        emailTextField.text = userInfo.userInfo["email"]
        ageTextField.text = userInfo.userInfo["age"]
        cityTextField.text = userInfo.userInfo["city"]
        
      
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

    @IBAction func onTapped(sender: AnyObject) {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
}

