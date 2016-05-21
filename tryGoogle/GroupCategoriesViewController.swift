//
//  GroupCategoriesViewController.swift
//  MeetUpGroup
//
//  Created by ChongSun on 10/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class GroupCategoriesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var groupName = ["Books","Games","Food & Drink","Music","News"]
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupName.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = groupName[indexPath.row]
        return cell
    }

}
