//
//  CredentialStore.swift
//  StoryTracker
//
//  Created by ben on 7/3/14.
//  Copyright (c) 2014 Fickle Bits. All rights reserved.
//

import UIKit

class CredentialStore: NSObject {
    enum UserDefaultKeys: String {
        case TrackerApiKey = "trackerApiToken"
    }
    
    var trackerApiToken: NSString? {
        get {
            return NSUserDefaults.standardUserDefaults().objectForKey(UserDefaultKeys.TrackerApiKey.toRaw()) as? String
        }
        set {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setObject(newValue, forKey: UserDefaultKeys.TrackerApiKey.toRaw())
            userDefaults.synchronize()
        }
    }
    
    var loggedIn: Bool {
        return trackerApiToken != nil
    }
}
