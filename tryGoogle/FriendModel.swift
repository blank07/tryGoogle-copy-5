//
//  FriendModel.swift
//  MeetUp
//
//  Created by Pro on 20/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FriendModel {
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func getFriendsByMyEmail(myEmail: String) -> [Friends] {
        let ed = NSEntityDescription.entityForName("Friends", inManagedObjectContext: moc)
        
        let req = NSFetchRequest()
        req.entity = ed
        
        let cond = NSPredicate(format: "myEmail = %@", myEmail)
        req.predicate = cond
        var result: [Friends]?
        
        do {
            result = try moc.executeFetchRequest(req) as? [Friends]
        } catch let error as NSError {
            
        }
        return result!
        
    }
    
    func isFriend(myEmail: String, friendEmail: String) -> Bool {
        
        let ed = NSEntityDescription.entityForName("Friends", inManagedObjectContext: moc)
        
        let req = NSFetchRequest()
        req.entity = ed
        
        let cond = NSPredicate(format: "myEmail = %@ and friendEmail = %@", myEmail, friendEmail)
        req.predicate = cond
        
        do {
            let result: [Friends] = try moc.executeFetchRequest(req) as! [Friends]
            if result.count > 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            
        }
        return false
    }
    func addFriend(myEmail: String, friendEmail: String) -> Bool {
        let ed = NSEntityDescription.entityForName("Friends", inManagedObjectContext: moc)
        let relationShip = Friends(entity:ed!, insertIntoManagedObjectContext: moc)
        
        relationShip.myEmail = myEmail
        relationShip.friendEmail = friendEmail
        
        do {
            try moc.save()
            return true
        } catch let error as NSError {
            
        }
        return false
    }
    
}
