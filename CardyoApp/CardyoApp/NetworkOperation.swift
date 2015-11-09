//
//  NetworkOperation.swift
//  Cardyo
//
//  Created by Mac Bellingrath on 11/6/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//


import UIKit
import Alamofire



private let _nm = NetworkManager()
private let _d = NSUserDefaults.standardUserDefaults()

class NetworkManager: NSObject {
    
    /// The base URL used when making an API call.
    private let baseURL = "https://cardyo.herokuapp.com"
    
    
    
    //Returns singleton
    static func sharedManager() -> NetworkManager { return _nm }
    
    
    //User Auth Token
    var token: String? {
        get { return _d.objectForKey("token") as? String }
        set { _d.setObject(newValue, forKey: "token") }
    }
    
    
    /**
    Registers User
    
    - parameter username: Username
    - parameter password: Password
    - parameter email:    user email
    - parameter success:  Completion with response
    */
    
    func register(username: String, password: String, email: String, success: (Bool) -> Void) {
        let info = RequestInfo(endPoint: "/signup", methodType: .POST, parameters: [ "username": username, "password": password, "email": email ], headers: nil)
        
        Alamofire.request(.POST, info.url, parameters: info.parameters, encoding: .JSON, headers: info.headers).responseJSON(options: .MutableContainers) { (response) -> Void in
            switch response.result {
            case .Failure(let error) :
                print(error)
                success(false)
            case .Success(let value):
                print(value)
                if let jsonDict = value as? NSDictionary {
                    if let user = jsonDict["user"] as? [String: AnyObject] {
                        if let token = user["access_token"] as? String {
                            self.token = token
                            success(true)
                        }
                    }
                }
            }

        }
    }
    
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

//    }
    
    /**
    This method will attempt to login the user with the credentials below and return a callback upon completion
    
    - parameter username: The user's username credential
    - parameter password: The user's password credential
    - parameter callback: A callback that will run upon completion.
    */
    func login(username: String, password: String, callback: (success: Bool)-> ()) {
        let info = RequestInfo(endPoint: "/login", methodType: .POST, parameters: [ "username": username, "password": password], headers: nil)
        
        Alamofire.request(.POST, info.url, parameters: info.parameters, encoding: .JSON, headers: info.headers).responseJSON(options:
            
            NSJSONReadingOptions.MutableContainers) { (response) -> Void in
                
                switch response.result {
                case .Failure(let error) :
                     print(error)
                    callback(success: false)
                case .Success(let value):
                    print(value)
                    if let jsonDict = value as? NSDictionary {
                        if let user = jsonDict["user"] as? [String: AnyObject] {
                            if let _token = user["access_token"] as? String {
                                print("token: \(_token)")
                                self.token = _token
                                callback(success: true)
                            }
                        }
                    }
                }
            }
        }
    
    //Download DECKS
    func getAllDecks(completion:([CardyoDeck]?) -> Void ) {
        let info = RequestInfo(endPoint: "/index", methodType: .GET , parameters: [:], headers: ["access-token":self.token!])
        Alamofire.request(.GET, info.url, parameters: nil, encoding: .JSON, headers: info.headers).responseJSON(options: .MutableContainers) { (response) -> Void in
            switch response.result {
            case .Failure(let error):
                completion(nil)
                print(error)
            case .Success(let value):
                print(value)
                
                if let jsonDict = value as? NSDictionary {
                    if let decks = jsonDict["decks"] as? [[String: AnyObject]] {
                        var dx = [CardyoDeck]()
                        decks.map{ dx.append(CardyoDeck(json: $0)!) }
                        print(dx)
                        completion(dx)
                    }
                }
            }
        }
        
    }

 
    
    

func createDeck(withTitle: String){
    guard NetworkManager.sharedManager().token != nil else { return }
    //****
    
        let base = "https://cardyo.herokuapp.com"
        let headers = ["access_token": NetworkManager.sharedManager().token!]
        let deckURL = base + "/decks"
        let deckparams = ["title": withTitle]
        Alamofire.request(.POST, deckURL, parameters: deckparams , encoding: .JSON, headers: headers).responseJSON(options: .MutableContainers) { (response) -> Void in
            switch response.result {
            case .Failure(let error) : print(error)
            case .Success(let value):
                print(value)
                if let jsonDict = value as? NSDictionary {
                    if let deck = jsonDict["deck"] as? [String: AnyObject] {
                        
                    print(deck)
                    }
                }
            }
        }
    }
}









struct RequestInfo {
    
    enum MethodType: String {
        case POST, GET, DELETE
    }
    
    private let base = "https://cardyo.herokuapp.com"
    var endPoint: String!
    var methodType: MethodType = .GET
    var parameters: [String:AnyObject] = [:]
    var headers: [String : String]?
    var url: String {
        return base + self.endPoint
    }
}


