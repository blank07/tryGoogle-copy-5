//
//  myEventController.swift
//  MeetUpGroup
//
//  Created by Pro on 12/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit
import CoreData

class AllEventController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //CoreData
    var user: User?
    var choosedEvent: Event?
    var allEvents: [Event]!
    var eventModel = EventModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // CoreData start
    override func viewWillAppear(animated: Bool) {
        //eventModel.delete()
        allEvents = eventModel.fetchAllEvents()
        self.collectionView.reloadData()
        self.tabBarController?.tabBar.hidden = false
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allEvents.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! AllEventCellController
        
        let event = allEvents[indexPath.row]
        cell.title.text = event.title
        cell.posterImg.image = UIImage(data: event.poster!)
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let event = self.allEvents[indexPath.row]
//        choosedEvent = event
//        self.performSegueWithIdentifier("showEvent", sender: event)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEvent" {
            let cell = sender as! AllEventCellController
            let indexPath = collectionView.indexPathForCell(cell)
            let event = self.allEvents[indexPath!.row]
            choosedEvent = event
            let eventController: EventController = segue.destinationViewController as! EventController
            eventController.event = self.choosedEvent
            eventController.user = self.user
        } else if segue.identifier == "showCreateEventPage" {
            let eventController: CreateEventController = segue.destinationViewController as! CreateEventController
            eventController.user = self.user
        }
    }

    

}
