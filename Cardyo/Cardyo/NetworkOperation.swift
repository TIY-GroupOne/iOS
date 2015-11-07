//
//  NetworkOperation.swift
//  Cardyo
//
//  Created by Mac Bellingrath on 11/6/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//


//post "/signup", to: "registrations#create"
//delete "/signup", to: "registrations#destroy"
//post "/login", to: "registrations#login"
//get "/logout", to: "registrations#logout"

import UIKit
import Alamofire

private let _session = NetworkOperation()
private let _d = NSUserDefaults.standardUserDefaults()

class NetworkOperation: NSObject {
   
    private let base = "https://cardyo.herokuapp.com"
    

    
 
    
    func register(withUserName username: String, andPassword password: String, andEmail email: String, completion: (success: Bool) -> () ) {
        var info = RequestInfo()
        info.endPoint = "/signup"
        info.methodType = .POST
        
        info.parameters = [
            "username": username,
            "password" : password,
            "email": email
            
            ]
        
//        if let token = NetworkOperation.sharedSession().token {
//        Alamofire.request(.POST, base, parameters: info.parameters, encoding: ParameterEncoding.JSON, headers: ["access-token": token ])
//        }
        
        
    }
    
    var token: String? {
        get { return _d.objectForKey("token") as? String }
        set { _d.setObject(newValue, forKey: "token") }
    }
    
   class func sharedSession() -> NetworkOperation { return _session }
    
    
}





