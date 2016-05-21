//
//  ThirdViewController.swift
//  tryGoogle
//
//  Created by ChongSun on 18/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit
import GoogleMaps

class ThirdViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        getLocationLatitudeAndLongitude(btnAddress)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var place: String!
        place = (btnAddress.titleLabel?.text)!
        (segue.destinationViewController as!FourthTableViewController).data = place
     (segue.destinationViewController as!FourthTableViewController).locationLongitude = self.locationLongitude
        (segue.destinationViewController as!FourthTableViewController).locationLatitude = self.locationLatitude
    }

    
}
