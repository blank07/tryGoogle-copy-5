//
//  FourthTableViewController.swift
//  MeetUp
//
//  Created by ChongSun on 21/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit
import GoogleMaps

class FourthTableViewController: UITableViewController {
    var data: String!
    var placePicker: GMSPlacePicker?
    var coords: CLLocationCoordinate2D!
    
    var locationLatitude =  0.0//-37.815343
    var locationLongitude = 0.0// 144.963228
    var apiKey = "AIzaSyChJAJxebowJ7B0jff7uXJwdJpnKb4uF4g"

    var placeDic = Dictionary<String, Array<Double>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNear(locationLatitude, longit: locationLongitude)
      //  self.tabBarController?.tabBar.hidden = true
    }
    func getNear(lati: Double, longit: Double){
        placeDic.removeAll()
        
        let urlString = String(format: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%+f,%+f&radius=500&types=transit_station&key=%@",locationLatitude,locationLongitude,apiKey)
        
        let url : NSURL = NSURL(string: urlString)!
        let jsonData: NSData = NSData(contentsOfURL: url)!
        
        do{
            
            let jsonData: NSDictionary = try (NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary)!
            let result : NSArray = (jsonData["results"] as? NSArray)!
            
            for  i in 0  ..< result.count {
                
                if let item = result[i] as? [String: AnyObject] {
                    
                    let name = item["name"] as! String
                    let geometry = item["geometry"] as? [String: AnyObject]
                    let location = geometry!["location"] as? [String: AnyObject]
                    let lat = location!["lat"] as? Double
                    let lng = location!["lng"] as? Double
                    
                    placeDic["\(name)"] = [lat!,lng!]
                    
                }
            }
            
        }catch let error as NSError{
            NSLog(error.description)
        }
        
    }
    
    
    func getDataLatLng(){
        
            let geocoder = CLGeocoder()
            print(data)
            geocoder.geocodeAddressString(self.data, completionHandler: {(placemarks,error) -> Void in
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
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return placeDic.count
    }
   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let key = Array(self.placeDic.keys)[indexPath.row]
        let value = Array(self.placeDic.values)[indexPath.row]

        cell.textLabel?.text = key
        cell.detailTextLabel?.text = "\(value)"
        return cell
    }
   
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)

        let value = Array(self.placeDic.values)[indexPath.row]

        self.locationLatitude = value[0]
        self.locationLongitude = value[1]
        showLocation()
    }
    
    func showLocation(){
        
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
    
}
