//
//  Project.swift
//  StoryTracker
//
//  Created by ben on 6/27/14.
//  Copyright (c) 2014 Fickle Bits. All rights reserved.
//

import Foundation

class Project {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func grab<T>(key: String, dict: Dictionary<String, AnyObject>) -> T? {
        if let val: AnyObject = dict[key] {
            return val as? T
        }
        return nil
    }
    
    init(attributes: Dictionary<String, AnyObject>) {
        
        self.id = (attributes["id"] as NSNumber).integerValue
        self.name = (attributes["name"] as NSString)
    }
    
    //        // {
    //        "id": 545929,
    //        "kind": "project",
    //        "name": "DeliRadio — Web",
    //        "version": 24269,
    //        "iteration_length": 1,
    //        "week_start_day": "Tuesday",
    //        "point_scale": "0,1,2,3,5,8",
    //        "point_scale_is_custom": false,
    //        "bugs_and_chores_are_estimatable": false,
    //        "automatic_planning": true,
    //        "enable_tasks": true,
    //        "time_zone": {
    //            "kind": "time_zone",
    //            "olson_name": "America/Chicago",
    //            "offset": "-05:00"
    //        },
    //        "velocity_averaged_over": 3,
    //        "number_of_done_iterations_to_show": 12,
    //        "has_google_domain": true,
    //        "enable_incoming_emails": true,
    //        "initial_velocity": 10,
    //        "public": false,
    //        "atom_enabled": false,
    //        "start_time": "2012-05-15T05:00:00Z",
    //        "created_at": "2012-05-08T21:12:43Z",
    //        "updated_at": "2013-08-01T16:33:48Z",
    //        "account_id": 243215,
    //        "current_iteration_number": 111,
    //        "enable_following": true
    //    }
}
