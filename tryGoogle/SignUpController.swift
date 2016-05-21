//
//  SignUpController.swift
//  MeetUpGroup
//
//  Created by Pro on 4/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class SignUpController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var pswField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var cityPicker: UIPickerView!
    
    private let cityNames = ["Melbourne", "Sydney", "Perth"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityPicker.delegate = self
        cityPicker.dataSource = self
        cityField.inputView = cityPicker
        cityPicker.removeFromSuperview()
        emailField.becomeFirstResponder()
    }
    
    var loginModel = LoginModel()
    var userInfoModel = UserInfo()
    
    @IBAction func signUp(sender: UIButton) {
        if(!loginModel.checkEmail(emailField.text!)) {
            //alert the email has already been used
        } else {
            loginModel.userList.updateValue(pswField.text!, forKey: emailField.text!)
            userInfoModel.userInfo.updateValue(emailField.text!, forKey: "email")
            userInfoModel.userInfo.updateValue(nameField.text!, forKey: "name")
            userInfoModel.userInfo.updateValue(ageField.text!, forKey: "age")
            userInfoModel.userInfo.updateValue(cityField.text!, forKey: "city")
            //store user info and jump to choose hobby page
        }
    }
    @IBAction func onTapGestureRecognized(sender: AnyObject) {
        emailField.resignFirstResponder()
        nameField.resignFirstResponder()
        ageField.resignFirstResponder()
        pswField.resignFirstResponder()
        cityField.resignFirstResponder()
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityNames.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityField.text = cityNames[row]
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityNames[row]
    }
    
    @IBAction func selectCity(sender: AnyObject) {
        //cityPicker.hidden = false;
    }

    
}
