
import UIKit
import CoreData
//
//  ThirdViewController.swift
//  tryGoogle
//
//  Created by ChongSun on 18/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import GoogleMaps


class EventController: UIViewController {
    
    
    var placePicker: GMSPlacePicker?
    var apiKey = "AIzaSyChJAJxebowJ7B0jff7uXJwdJpnKb4uF4g"
    
    var placeDic = Dictionary<String, Array<Double>>()
    @IBOutlet var btnAddress: UIButton!
    var coords: CLLocationCoordinate2D!
    
    var locationLatitude = 0.0// -37.815343
    var locationLongitude = 0.0// 144.963228
    
    func getPlaceDic() -> Dictionary<String, Array<Double>> {
        return placeDic
    }
    
   
    @IBAction func pickPlace(sender: UIButton) {
        
        let center = CLLocationCoordinate2DMake(locationLatitude, locationLongitude)
        let northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
        let southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        placePicker = GMSPlacePicker(config: config)
        
        placePicker?.pickPlaceWithCallback({ (place: GMSPlace?, error: NSError?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
        })
    }
    

    
    func getLocationLatitudeAndLongitude(sender: UIButton) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(sender.titleLabel!.text!, completionHandler: {(placemarks,error) -> Void in
            if(error != nil){
                NSLog(": %@", error!)
                return
            }
            if((placemarks != nil ) && (placemarks!.count > 0)){
                
                let placemark: CLPlacemark = placemarks![0]
                
                self.coords = placemark.location!.coordinate
                
                self.locationLatitude = self.coords.latitude
                self.locationLongitude = self.coords.longitude
                
            }
        })
    }
    
    @IBAction func SetLocation(sender: AnyObject) {
        getLocationLatitudeAndLongitude(btnAddress)
        
    }
    

    
    
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
//    @IBOutlet var addressBtn: UIButton!
    
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var attendBtn: UIButton!
    
    var image = UIImage()
    
    var eventModel = EventModel()
    var userEventModel = UsersEventModel()
    var myEvents: MyEvent?
    var event: Event?
    var user: User?
    var isAttend: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.poster.image = self.image
        isAttend = userEventModel.checkIfAttend((user?.email)!, title: (event?.title)!)
        self.showEventInfo()
        getLocationLatitudeAndLongitude(btnAddress)
        self.tabBarController?.tabBar.hidden = true
        
//        self.navigationItem.leftBarButtonItem =
//            [[UIBarButtonItem alloc] initWithTitle:@"Back"
//        style:UIBarButtonItemStyleBordered
//        target:self
//        action:@selector(handleBack:)];
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .Plain, target: self, action: Selector("goBack"))
        
    }

    func goBack() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showEventInfo() {
        titleLbl.text = event!.title
        typeLbl.text = event!.type
        timeLbl.text = event!.date
        cityLbl.text = event!.city
        btnAddress.setTitle("\((event!.address)!)" ,forState: .Normal)
        poster.image = UIImage(data: event!.poster!, scale: 1)
        if isAttend == true {
            changeBtnToNotGoing()
        }
    }
    @IBAction func attendClicked(sender: UIButton) {
        if isAttend == true {
            self.notGoing()
            changeBtnToWillAttend()
            isAttend = false
        } else {
            self.attendEvent()
            changeBtnToNotGoing()
            isAttend = true
        }
    }
    
    func attendEvent() {
        let r = event!.date!.startIndex ..< event!.date!.endIndex.advancedBy(-6)
        let substring = event!.date![r]
        // insert userEvent
        userEventModel.inserUserAttendEvent((user?.email)!, title: (event?.title)!, date: substring)
    }
    func notGoing() {
        userEventModel.delete((user?.email)!, title: (event?.title)!)
    }
    func changeBtnToNotGoing() {
        attendBtn.setTitle("I'm Not Going", forState: .Normal)
    }
    func changeBtnToWillAttend() {
        attendBtn.setTitle("I'll Attend", forState: .Normal)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showAttendingPeople" {
            let attendingPeopleController: AttendingPeopleController = segue.destinationViewController as! AttendingPeopleController
            print(event?.title)
            attendingPeopleController.event = self.event
            attendingPeopleController.user = self.user
        }
        if segue.identifier == "show" {
        var place: String!
        place = (btnAddress.titleLabel?.text)!
        (segue.destinationViewController as!FourthTableViewController).data = place
        (segue.destinationViewController as!FourthTableViewController).locationLongitude = self.locationLongitude
        (segue.destinationViewController as!FourthTableViewController).locationLatitude = self.locationLatitude
        }
    }
}
