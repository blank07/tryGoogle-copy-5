

import Foundation
import CoreData
import UIKit

class UserModel {
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var allEvent: [User]!
    
    func fetchAllUsers() -> [User] {
        let ed = NSEntityDescription.entityForName("User", inManagedObjectContext: moc)
        
        let req = NSFetchRequest()
        req.entity = ed
        
        do {
            let entryObjects = try moc.executeFetchRequest(req)
            self.allEvent = entryObjects as! [User]
            return allEvent
        } catch let error as NSError {
            
        }
        return allEvent
    }
    
    func insertUser(email: String, name: String, age: String, city: String, password: String, protraitData: NSData) -> User {
        let ed = NSEntityDescription.entityForName("User", inManagedObjectContext: moc)
        let user = User(entity:ed!, insertIntoManagedObjectContext: moc)
        
        user.email = email
        user.name = name
        user.age = age
        user.city = city
        user.password = password
        user.protrait = protraitData
        
        do {
            try moc.save()
        } catch let error as NSError {
            
        }
        return user
    }
    
    func fetchUserByEmail(email: String) -> User {
        var user: User?
        let ed = NSEntityDescription.entityForName("User", inManagedObjectContext: moc)
        
        let req = NSFetchRequest()
        req.entity = ed
        
        let cond = NSPredicate(format: "email = %@", email)
        req.predicate = cond
        
        do {
            let result = try moc.executeFetchRequest(req)
            
            
            user = result[0] as! User
            
            return user!
            
        } catch let error as NSError {
            
        }
        return user!
    }
    
    func checkUserByEmailAndPwd(email: String, password: String) -> AnyObject? {
        var user: User?
        let ed = NSEntityDescription.entityForName("User", inManagedObjectContext: moc)
        
        let req = NSFetchRequest()
        req.entity = ed
        
        let cond = NSPredicate(format: "email = %@ and password = %@", email, password)
        req.predicate = cond
        
        do {
            let result = try moc.executeFetchRequest(req)
            
            if result.count > 0 {
                user = result[0] as? User
                return user
            }
            
            return nil
            
        } catch let error as NSError {
            
        }
        return nil
    }
    
    func delete() {
        let ed = NSEntityDescription.entityForName("User", inManagedObjectContext: moc)
        let req = NSFetchRequest()
        req.entity = ed
        
        let events = self.fetchAllUsers()
        for info in events {
            moc.deleteObject(info)
        }
        
    }
}