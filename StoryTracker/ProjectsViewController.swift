//
//  ProjectsViewController.swift
//  StoryTracker
//
//  Created by ben on 6/27/14.
//  Copyright (c) 2014 Fickle Bits. All rights reserved.
//

import UIKit

class ProjectsViewController: UITableViewController {
    
    var projects: [Project] = []
    
    deinit {
        stopListeningForNotifications()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let credentialStore = CredentialStore()
        if credentialStore.loggedIn {
            refreshProjects()
        } else {
            performSegueWithIdentifier("loginSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listenForNotifications()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func listenForNotifications() {
        NSNotificationCenter.defaultCenter().addObserverForName(StoryTrackerNotifications.UserLoggedIn.toRaw(),
            object: nil,
            queue: NSOperationQueue.mainQueue()) { [unowned self]
                (notification) in
                self.refreshProjects()
        }
    }
    
    func stopListeningForNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func refreshProjects() {
        let apiToken = CredentialStore().trackerApiToken!
        TrackerApiClient().getProjects(apiToken) {
            (projects, errorResponse) in
            if projects {
                self.projects = projects!
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Error fetching projects",
                    message: "¯\\(°_o)/¯ no idea what went wrong.  Try signing out and back in again.",
                    preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
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
