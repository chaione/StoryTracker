//
//  IssuesViewController.swift
//  StoryTracker
//
//  Created by ben on 8/1/14.
//  Copyright (c) 2014 Fickle Bits. All rights reserved.
//

import UIKit

class StoriesViewController : UITableViewController {
    
    var project: Project? {
        didSet {
            self.title = project?.name
        }
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if project {
            return 5
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.textLabel.text = "test cell"
        return cell
    }
}