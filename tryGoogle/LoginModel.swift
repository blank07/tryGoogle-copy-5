//
//  LoginModel.swift
//  MeetUpGroup
//
//  Created by Pro on 4/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation

class LoginModel {
    var userList: Dictionary<String, String> = [
        "abc@gmail.com" : "abc"
    ]
    
    func checkUser(email: String, psw: String) -> Bool {
        if let userEmail = userList[email] {
            if userEmail == psw {
                return true
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
    func checkEmail(email: String) ->Bool {
        if((userList[email]) == nil) {
            return true
        } else {
            return false
        }
    }
    
}