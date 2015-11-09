//
//  RailsRequest.swift
//  RR
//
//  Created by Mac Bellingrath on 11/5/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//




import UIKit
import Alamofire
import SwiftyJSON

private let _rr = RailsRequest()

private let _d = NSUserDefaults.standardUserDefaults()


class RailsRequest: NSObject {

    enum RequestError: ErrorType {
        
        case NoConnection, BadData
        
    }
    
    class func session() -> RailsRequest { return _rr }

    var token: String? {
        get { return _d.objectForKey("token") as? String }
        set { _d.setObject(newValue, forKey: "token") }
    }
    
    private let base = "https://cardyo.herokuapp.com"
    
    func loginWithUsername(username: String, andPassword password: String) {
        
        var info = RequestInfo()
        info.endPoint = "/login"
        info.methodType = .POST
        
        info.parameters = [
            "username" : username,
            "password" : password
        
        ]
        
        if let token = token {
      
            info.headers = [
            "Access-Token" : token
           
            ]
        
        
        Alamofire.request(.POST, info.url, parameters: info.parameters, encoding: .JSON, headers: info.headers).responseJSON(options: .MutableContainers) { (response) -> Void in
            
            guard response.result.error == nil else {
                print(response.result.error!)
                
//                completion(json: nil, error: .BadData)
                
                return
            }
            
            if let value = response.result.value {
            let json = JSON(value)
                
                print(json)
//                completion(json: json, error: nil)
            
//                // handle the results as JSON, without a bunch of nested if loops
//                let user = JSON(value)
//                // now we have the results, let's just print them though a tableview would definitely be better UI:
//                print("User " + user.description)
//                
//                if let key = user["key"].string {
//                    self.token = key
//                    print(self.token)
//                }
            
              
        }
 
        }
    }
    
//        requestWithInfo(info) { (returnedInfo) -> () in
//            // grab access token and user id and also save them
//            
//            if let user = returnedInfo?["user"] as? [String: AnyObject] {
//                
//                if let key = user["access_token"] as? String {
//                    
//                    self.token = key
//                    print(self.token)
//                    success(true)
//                }
//                
//            }
//        }
//    }
    
//    
//    func register(withUserName username: String, andPassword password: String, andEmail email: String, completion: () -> () ) {
//        var info = RequestInfo()
//        info.endPoint = "/signup"
//        info.methodType = .POST
//        
//        info.parameters = [
//            "username": username,
//            "password" : password,
//            "email": email
//        
//        ]
//        
//       
//        
//        requestWithInfo(info) { (returnedInfo) -> () in
//            print(returnedInfo)
//            
//            if let user = returnedInfo?["user"] as? [String: AnyObject] {
//                
//                if let key = user["access_token"] as? String {
//                    
//                    self.token = key
//                    print(self.token)
//                    completion()
//                }
//        }
//        
//    }
//    
//    
//    
//
//    }
//    
//    func getDeckWithCompletion(withDeckTitle title: String, completion: () -> ()) {
//        
//        //add throw statement?
//        guard let token =  RailsRequest.session().token else { return }
//        var info = RequestInfo()
//        info.endPoint = "/decks"
//        info.methodType = .GET
//        
//        
//        info.parameters = [
//            "acces-token": token,
//            "title" : title,
//        ]
        
        
//        "created_at" : "2015-11-06T14:15:26.152Z",
//        "id" : 5,
//        "title" : null,
//        "updated_at" : "2015-11-06T14:15:26.152Z",
//        "user_id" : 5
        
//        
//        requestWithInfo(info) { (returnedInfo) -> () in
//          
//            print("returned info \(returnedInfo)")
//            
//            if let deck = returnedInfo?["deck"] as? [String: AnyObject] {
//                
//                print(deck)
//               
//                }
//                
//            }
//            completion()
//            
//    }
//

    

    
    
    func requestWithInfo(info: RequestInfo, completion: (returnedInfo: AnyObject?) -> ()) {
        let fullURL = base + info.endPoint
       
        guard let url = NSURL(string: fullURL) else { return }
        
        //request
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = info.methodType.rawValue
        
        print("url: \(url) - request: \(request)")
        
        
        // add token if we have one
        if let token = token {
            //header field could be Authorization
            
            request.setValue(token, forHTTPHeaderField: "Access-Token")
            print(token)
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
            
            print(data)
            print(response)
            
            guard let _data = data, _response = response  else { return }
            
            if let returnedInfo = try? NSJSONSerialization.JSONObjectWithData(_data, options: .MutableContainers) {
                print("returnedinfo: ", returnedInfo)
                completion(returnedInfo: returnedInfo)
            }
            
                

        }
        
        task.resume()

        
        
        
        }
    }
}





