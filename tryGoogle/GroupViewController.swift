//
//  SecondViewController.swift
//  MeetUpGroup
//
//  Created by ChongSun on 29/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    let groupTitles = ["download", "music", "travel", "travel2", "travel3", "logo"]
    let imageArray = [UIImage(named: "download"), UIImage(named: "music"), UIImage(named: "travel"), UIImage(named: "travel2"), UIImage(named: "travel3"), UIImage(named: "logo")]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupTitles.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell2 = collectionView.dequeueReusableCellWithReuseIdentifier("cell2", forIndexPath: indexPath) as! CollectionViewCell2
        cell2.imageView?.image = self.imageArray[indexPath.row]!
        cell2.titleLabel?.text = self.groupTitles[indexPath.row]
        
        return cell2
    }



}

