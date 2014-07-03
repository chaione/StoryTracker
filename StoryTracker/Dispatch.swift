//
//  Dispatch.swift
//  StoryTracker
//
//  Created by ben on 7/3/14.
//  Copyright (c) 2014 Fickle Bits. All rights reserved.
//

import UIKit

struct Dispatch {
    static func background(closure: () -> () ) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            closure()
        }
    }
    
    static func main(closure: () -> ()) {
        dispatch_async(dispatch_get_main_queue()) {
            closure()
        }
    }
}
