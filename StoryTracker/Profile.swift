//
//  Profile.swift
//  StoryTracker
//
//  Created by ben on 7/25/14.
//  Copyright (c) 2014 Fickle Bits. All rights reserved.
//

import Foundation

class Profile {
    class func fromDictionary(dict: NSDictionary) -> Profile {
        var profile = Profile()
        profile.apiToken = dict["api_token"] as? NSString
        return profile
    }
    
    var apiToken: String?
}