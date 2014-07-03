//
//  ProjectsViewController.swift
//  StoryTracker
//
//  Created by ben on 6/27/14.
//  Copyright (c) 2014 Fickle Bits. All rights reserved.
//

import UIKit

class ProjectsViewController: UITableViewController {
    
    var projects: Project[] = []

    @lazy var sessionConfig: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    @lazy var session: NSURLSession = NSURLSession(configuration: self.sessionConfig)
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let credentialStore = CredentialStore()
        if !credentialStore.loggedIn {
            performSegueWithIdentifier("loginSegue", sender: self)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }

    func projectAtIndexPath(indexPath: NSIndexPath) -> Project {
        return projects[indexPath.row]
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let project = projectAtIndexPath(indexPath)
        cell.textLabel.text = project.name
        return cell
    }
}
