//
//  RailsRequest.swift
//  RR
//
//  Created by Mac Bellingrath on 11/5/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//


//post "/signup", to: "registrations#create"
//delete "/signup", to: "registrations#destroy"
//post "/login", to: "registrations#login"
//get "/logout", to: "registrations#logout"

import UIKit

private let _rr = RailsRequest()

private let _d = NSUserDefaults.standardUserDefaults()


class RailsRequest: NSObject {
    
    class func session() -> RailsRequest { return _rr }

    var token: String? {
        get { return _d.objectForKey("token") as? String }
        set { _d.setObject(newValue, forKey: "token") }
    }
    
    
    
    
    private let base = "https://cardyo.herokuapp.com"
    
    func loginWithUsername(username: String, andPassword password: String) {
        var info = RequestInfo()
        info.endPoint = "/signup"
        info.methodType = .POST
        
        info.parameters = [
            "username" : username,
            "password" : password
        
        ]
        
//        requestWithInfo(info) { (returnedInfo) -> () in
//            
//            if let user = returnedInfo?["user"] as? [String: AnyObject] {
//                
//                if let key = user["access_key"] as? String {
//                    
//                    self.token = key
//                    
//                    
//                }
//                
//            }
//        }
    }
    
    
    
    
    
    
    
    func requestWithInfo(info: RequestInfo, completion: (returnedInfo: AnyObject?) -> ()) {
        let fullURL = base + info.endPoint
       
        guard let url = NSURL(string: fullURL) else { return }
        
        //request
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = info.methodType.rawValue
        
        
        // add token if we have one
        if let token = token {
            //header field could be Authorization
            
            request.setValue(token, forHTTPHeaderField: "Authorization")
        }
        
        
        // add parameters to body
        
        if let requestData = try? NSJSONSerialization.dataWithJSONObject(info.parameters, options: .PrettyPrinted) {
            
            if let jsonString = NSString(data: requestData, encoding: NSUTF8StringEncoding) {
            request.setValue("\(jsonString.length)", forHTTPHeaderField: "Content-Length")
            
            let postData = jsonString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                
                request.HTTPBody = postData
            }
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            //work with data
            guard let _data = data, _response = response  else { return }
            
            guard let returnedInfo = try? NSJSONSerialization.JSONObjectWithData(_data, options: .MutableContainers) as? [ String: AnyObject] else { return }
            completion(returnedInfo: returnedInfo)
                

        }
        
        task.resume()

        
        
        
    }
}


struct RequestInfo {
    
    enum MethodType: String {
    case POST, GET, DELETE
    }
    
    var endPoint: String!
    var methodType: MethodType = .GET
    var parameters: [String:AnyObject] = [:]
}

