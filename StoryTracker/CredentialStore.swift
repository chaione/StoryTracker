//
//  CredentialStore.swift
//  StoryTracker
//
//  Created by ben on 7/3/14.
//  Copyright (c) 2014 Fickle Bits. All rights reserved.
//

import UIKit

class CredentialStore: NSObject {
    enum CredentialKeys: String {
        case TrackerApiKey = "trackerApiToken"
    }
    
    var trackerApiToken: NSString? {
        get {
            return SSKeychain.passwordForService(CredentialKeys.TrackerApiKey.toRaw(), account: "StoryTracker")
        }
        set {
            SSKeychain.setPassword(newValue, forService: CredentialKeys.TrackerApiKey.toRaw(), account: "StoryTracker")
        }
    }
    
    var loggedIn: Bool {
        return trackerApiToken != nil
    }
}
