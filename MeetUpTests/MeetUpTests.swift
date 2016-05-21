//
//  MeetUpTests.swift
//  MeetUpTests
//
//  Created by Pro on 14/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import XCTest
@testable import MeetUp

class MeetUpTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    // Unit Testing 1
    internal func testIsEmailValid() {
        let registerTester = RegisterController()
        
        let validEmails = ["chen@gmail.com", "ALDIL@GMAIL.COM", "8248@163.com", "6677@gmail.com"]
        let inValidEmails = ["adlj!@gmail.com", "iijijad", "231312", "#iajdo@gmail.com"]
        
        for validEmail in validEmails {
            XCTAssertEqual(registerTester.isEmailValid(validEmail), true)
        }
        for inValidEmail in inValidEmails {
            XCTAssertEqual(registerTester.isEmailValid(inValidEmail), false)
        }
    }
    
    // Unit Testing 2
    internal func testIsPasswordValid() {
        let pwdTester = ViewController()
        
        let validEmail = "123@qq.com"
        let invalidEmail = "tom@gmail.com"
        let validPassword = "123"
        let invalidPassword = "999"
        
        XCTAssertEqual(pwdTester.checkPassword(validEmail, pwd: validPassword), true)
        XCTAssertEqual(pwdTester.checkPassword(invalidEmail, pwd: invalidPassword), false)
    }
    
    // Unit Testing 3
    internal func testAddNewUser() {
        let insertUserEventTester = UsersEventModel()
        
        let userEmail = "jack@gmail.com"
        let eventTitle = "Punk Rock Show"
        let date = "05-08-2016"
        
        XCTAssertEqual(insertUserEventTester.inserUserAttendEvent(userEmail, title: eventTitle, date: date), true)
    }
    
    // Unit Testing 4
    internal func testIfAttendEvent() {
        let attendEventTester = UsersEventModel()
        
        let validUserEmail = "jack@gmail.com"
        let validEventTitle = "Punk Rock Show"
        let invalidEventTitle = "Football match"
        
        XCTAssertEqual(attendEventTester.checkIfAttend(validUserEmail, title: validEventTitle), true)
        XCTAssertEqual(attendEventTester.checkIfAttend(validUserEmail, title: invalidEventTitle), false)
    }
    
    // Unit Testing 5
    internal func testAddFriend() {
        let addFriendTester = FriendModel()
        
        let myEmail = "jack@gmail.com"
        let friendEmail = "punk@gmail.com"
        
        XCTAssertEqual(addFriendTester.addFriend(myEmail, friendEmail: friendEmail), true)
    }
    
    // Unit Testing 6
    internal func testIsFriend() {
        let isFriendTester = FriendModel()
        
        let myEmail = "jack@gmail.com"
        let validFriendEmail = "punk@gmail.com"
        let invalidFriendEmail = "metal@gmail.com"
        
        XCTAssertEqual(isFriendTester.isFriend(myEmail, friendEmail: validFriendEmail), true)
        XCTAssertEqual(isFriendTester.isFriend(myEmail, friendEmail: invalidFriendEmail), false)
    }
    
    // Unit Testing 7
    internal func testHaveEmptyValue() {
        let registerTester = RegisterController()
        
        let validValue = ["dog@gmail.com", "dog", "23", "6677", "Melbourne"]
        let invalidValue = ["cat@gmail.com", "cat", "", "455", ""]
        
        
        XCTAssertEqual(registerTester.haveEmptyValue(validValue[0], name: validValue[1], age: validValue[2], password: validValue[3], city: validValue[4]), false)
        
        XCTAssertEqual(registerTester.haveEmptyValue(invalidValue[0], name: invalidValue[1], age: invalidValue[2], password: invalidValue[3], city: invalidValue[4]), true)
        
    }
    
    
}
