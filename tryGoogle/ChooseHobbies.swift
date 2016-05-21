//
//  ChooseHobbies.swift
//  MeetUpGroup
//
//  Created by Pro on 10/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit


class ChooseHobbies: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var Array = ["Music", "Movie", "Photo", "Sport", "Travel", "Reading"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Array.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        //cell.btn?.title = self.Array[indexPath.row]
        var Button = cell.viewWithTag(1) as! UIButton
        Button.setTitle(Array[indexPath.row], forState: UIControlState.Normal)
        
        return cell
    }
    
    @IBAction func selectHobby(sender: UIButton) {
        if sender.backgroundColor == UIColor.greenColor() {
            sender.backgroundColor = UIColor.orangeColor()
        } else {
            sender.backgroundColor = UIColor.greenColor()
        }
    }

}
