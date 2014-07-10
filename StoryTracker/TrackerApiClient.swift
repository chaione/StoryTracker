//
//  TrackerApiClient.swift
//  StoryTracker
//
//  Created by ben on 7/3/14.
//  Copyright (c) 2014 Fickle Bits. All rights reserved.
//

import Foundation

class Profile {
    
}

struct ErrorResponse {
    let body: String
    let error: NSError?
}

class TrackerApiClient {
    enum Endpoint: String {
        case Me = "https://www.pivotaltracker.com/services/v5/me"
        case ProjectList = "https://www.pivotaltracker.com/services/v5/project/:id"
    }
    
    @lazy var sessionConfig: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    @lazy var session: NSURLSession = NSURLSession(configuration: self.sessionConfig)
    
    func basicAuthString(#username: String, password: String) -> String {
        let authString = "\(username):\(password)"
        let data = authString.dataUsingEncoding(NSASCIIStringEncoding)
        if let goodData = data {
            return goodData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.EncodingEndLineWithCarriageReturn)
        }
        return ""
    }
    
    func login(username: String, password: String, completion: (Profile?, ErrorResponse?) -> ()) {
        let req = NSMutableURLRequest(URL: NSURL(string: Endpoint.Me.toRaw()))
        req.HTTPMethod = "GET"
        
        let authString = basicAuthString(username: username, password: password)
        println(authString)
        req.setValue("Basic \(authString)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTaskWithRequest(req) {
            (data: NSData!, response: NSURLResponse!, error: NSError!) in
            if let httpResponse = response as? NSHTTPURLResponse {
                println("Received HTTP \(httpResponse.statusCode)")
                if httpResponse.statusCode == 200 {
                    println(NSString(data: data, encoding: NSUTF8StringEncoding))
                } else {
                    let body = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println(error)
                    completion(Optional<Profile>.None, ErrorResponse(body: body, error: error))
                }
            } else {
                println("response was not an HTTP response, go fishing.")
            }
        }
        task.resume()
    }
    
    func getProjects(token: String, completion: ([Project]?, ErrorResponse?) -> ()) {
        let req = NSMutableURLRequest(URL: NSURL(string: Endpoint.ProjectList.toRaw()))
        req.addValue(token, forHTTPHeaderField: "X-TrackerToken")
        
        let task = session.dataTaskWithRequest(req) {
            (data: NSData!, response: NSURLResponse!, error: NSError!) in
            if let httpResponse = response as? NSHTTPURLResponse {
                println("Received HTTP \(httpResponse.statusCode)")
                if httpResponse.statusCode == 200 {
                    self.parseProjectJson(data, completion)
                } else {
                    let body = NSString(data: data, encoding: NSUTF8StringEncoding)
                    completion(nil, ErrorResponse(body: body, error: error))
                }
            } else {
                println("response was not an HTTP response, go fishing.")
            }
        }
        task.resume()
    }
    
    
    func parseProjectJson(data: NSData, completion: ([Project]?, ErrorResponse?) -> ()) {
        Dispatch.background() {
            var error: NSError?
            let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments,
                error: &error) as Array<Dictionary<String, AnyObject>>
            
            if error == nil {
                var projects = [Project]()
                for projectJson in json {
                    projects += Project(attributes: projectJson)
                }
                
                Dispatch.main() {
                    completion(projects, nil)
                }
            } else {
                Dispatch.main() {
                    completion(nil, ErrorResponse(body: "JSON Parsing Error", error: error!))
                }
            }
            
        }
    }
}
