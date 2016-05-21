//
//  MyEventController.swift
//  MeetUp
//
//  Created by Pro on 19/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class MyEventController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var user: User?
    var myEvents: [MyEvent]?
    var event: Event?
    var userEventModel = UsersEventModel()
    var eventModel = EventModel()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        myEvents = userEventModel.getEventsByUser((user?.email)!)
         
    }

   

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (myEvents?.count)!
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyEventCellController
        cell.titleLbl.text = myEvents![indexPath.row].title
        event = eventModel.getEventByTitle(myEvents![indexPath.row].title!)
        cell.poster.image = UIImage(data: (event?.poster)!)
    
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        event = eventModel.getEventByTitle(myEvents![indexPath.row].title!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEventPage" {
            let eventController: EventController = segue.destinationViewController as! EventController
            eventController.event = self.event
            eventController.user = self.user
        }
    }
    

}
