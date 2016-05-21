

import Foundation
import CoreData
import UIKit

class EventModel {
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var allEvent: [Event]!
    
    func fetchAllEvents() -> [Event] {
        let ed = NSEntityDescription.entityForName("Event", inManagedObjectContext: moc)
        let req = NSFetchRequest()
        req.entity = ed
        
        do {
            let entryObjects = try moc.executeFetchRequest(req)
            self.allEvent = entryObjects as! [Event]
            return allEvent
        } catch let error as NSError {
            
        }
        return allEvent
    }
    
    func insertEvent(title: String, type: String, time: String, city: String, address: String, imgData: NSData) -> Event {
        let ed = NSEntityDescription.entityForName("Event", inManagedObjectContext: moc)
        let event = Event(entity:ed!, insertIntoManagedObjectContext: moc)
        
        event.title = title
        event.type = type
        event.date = time
        event.city = city
        event.address = address
        event.poster = imgData
        
        do {
            try moc.save()
        } catch let error as NSError {
            
        }
        return event
    }
    
    func getEventByTitle(title: String) ->Event {
        let ed = NSEntityDescription.entityForName("Event", inManagedObjectContext: moc)
        
        let req = NSFetchRequest()
        req.entity = ed
        
        let cond = NSPredicate(format: "title = %@", title)
        req.predicate = cond
        var result: [Event]?
        
        do {
            result = try moc.executeFetchRequest(req) as? [Event]
        } catch let error as NSError {
            
        }
        return result![0]
    }
    
    func delete() {
        let ed = NSEntityDescription.entityForName("Event", inManagedObjectContext: moc)
        let req = NSFetchRequest()
        req.entity = ed
        
        let events = self.fetchAllEvents()
        for info in events {
            moc.deleteObject(info)
        }
        
    }
}