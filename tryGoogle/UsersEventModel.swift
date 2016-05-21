import Foundation
import CoreData
import UIKit

class UsersEventModel {
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func inserUserAttendEvent(email: String, title: String, date: String) -> Bool {
        let ed = NSEntityDescription.entityForName("MyEvent", inManagedObjectContext: moc)
        let userEvent = MyEvent(entity:ed!, insertIntoManagedObjectContext: moc)
        
        userEvent.email = email
        userEvent.title = title
        userEvent.date = date
        
        do {
            try moc.save()
            return true
        } catch let error as NSError {
            
        }
        return false
    }
    
    func getEventsByUser(email: String) -> [MyEvent] {
        let ed = NSEntityDescription.entityForName("MyEvent", inManagedObjectContext: moc)
        
        let req = NSFetchRequest()
        req.entity = ed
        
        let cond = NSPredicate(format: "email = %@", email)
        req.predicate = cond
        var result: [MyEvent]?
        
        do {
            result = try moc.executeFetchRequest(req) as! [MyEvent]
        } catch let error as NSError {
            
        }
        return result!
    }
    
    func getUsersByEvent(title: String) -> [MyEvent] {
        let ed = NSEntityDescription.entityForName("MyEvent", inManagedObjectContext: moc)
        
        let req = NSFetchRequest()
        req.entity = ed
        
        let cond = NSPredicate(format: "title = %@", title)
        req.predicate = cond
        var result: [MyEvent]?
        
        do {
            result = try moc.executeFetchRequest(req) as? [MyEvent]
        } catch let error as NSError {
            
        }
        return result!
    }
    
    func getEventsByUserAndDate(email: String, date: String) -> [MyEvent] {
        let ed = NSEntityDescription.entityForName("MyEvent", inManagedObjectContext: moc)
        
        let req = NSFetchRequest()
        req.entity = ed
        
        let cond = NSPredicate(format: "email = %@ And date = %@", email, date)
        
        req.predicate = cond
        var result: [MyEvent]?
        
        do {
            result = try moc.executeFetchRequest(req) as? [MyEvent]
        } catch let error as NSError {
            
        }
        return result!
    }
    
    func checkIfAttend(email: String, title: String) -> Bool {
        
        let ed = NSEntityDescription.entityForName("MyEvent", inManagedObjectContext: moc)
        
        let req = NSFetchRequest()
        req.entity = ed
        
        let cond = NSPredicate(format: "email = %@ and title = %@", email, title)
        req.predicate = cond
        
        do {
            let result: [MyEvent] = try moc.executeFetchRequest(req) as! [MyEvent]
            if result.count > 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            
        }
        return false
    }
    func delete(email: String, title: String) {
        let ed = NSEntityDescription.entityForName("MyEvent", inManagedObjectContext: moc)
        let req = NSFetchRequest()
        req.entity = ed
        
        let events = self.getEventsByUserAndEvent(email, title: title)
        for event in events {
            moc.deleteObject(event)
        }
    }
    func getEventsByUserAndEvent(email: String, title: String) -> [MyEvent] {
        let ed = NSEntityDescription.entityForName("MyEvent", inManagedObjectContext: moc)
        
        let req = NSFetchRequest()
        req.entity = ed
        
        let cond = NSPredicate(format: "email = %@ and title = %@", email, title)
        req.predicate = cond
        var result: [MyEvent]?
        
        do {
            result = try moc.executeFetchRequest(req) as? [MyEvent]
        } catch let error as NSError {
            
        }
        return result!
    }
}
