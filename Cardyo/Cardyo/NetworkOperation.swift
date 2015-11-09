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
//


import UIKit
import Alamofire
import RealmSwift


private let _nm = NetworkManager()
private let _d = NSUserDefaults.standardUserDefaults()

class NetworkManager: NSObject {
    
    //MARK: NETWORKING CONFIG
    private let baseURL = "https://cardyo.herokuapp.com"
    
    
    
    //Returns singleton
    class func sharedManager() -> NetworkManager { return _nm }
    
    
    //User Auth Token
    static var token: String? {
        get { return _d.objectForKey("token") as? String }
        set { _d.setObject(newValue, forKey: "token") }
    }
    
    
    //REGISTRATION
//    
//    func register(username: String, password: String, email: String, success: (Bool) -> Void) {
//        let info = RequestInfo(endPoint: "/signup", methodType: .POST, parameters: [ "username": username, "password": password, "email": email ], headers: nil)
//        
//        Alamofire.request(.POST, info.url, parameters: info.parameters, encoding: .JSON, headers: info.headers).responseJSON(options: .MutableContainers) { (response) -> Void in
//            switch response.result {
//            case .Failure(let error) :
//                print(error)
//                success(false)
//            case .Success(let value):
//                print(value)
//                if let jsonDict = value as? NSDictionary {
//                    if let user = jsonDict["user"] as? [String: AnyObject] {
//                        if let token = user["access_token"] as? String {
//                            NetworkManager.token = token
//                            
//                            let newUser = User(
//                            User.save(newUser)
//                            success(true)
//                        }
//                    }
//                }
//            }
//
//        }
    
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
    
    
 
    
    
    
    
    //LOGIN
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
                            if let token = user["access_token"] as? String {
                                NetworkManager.token = token
                                callback(success: true)
                            }
                        }
                    }
                }
            }
    }
    
    
    
    func request() {
        
    }
    
    
    
    //Download DECKS
    func createDeck(withTitle: String){
        let token: String = "16dbf0279998c0fb0a5c360b3d5e51a1"
        
        let base = "https://cardyo.herokuapp.com"
        let headers = ["access_token":token]
        let deckURL = base + "/decks"
        let deckparams = ["title": withTitle]
        Alamofire.request(.POST, deckURL, parameters: deckparams , encoding: .JSON, headers: headers).responseJSON(options: .MutableContainers) { (response) -> Void in
            switch response.result {
            case .Failure(let error) : print(error)
            case .Success(let value):
                print(value)
                if let jsonDict = value as? NSDictionary {
                    if let deck = jsonDict["deck"] as? [String: AnyObject] {
                        let realm =  try! Realm()
                        
                        try! realm.write({ () -> Void in
                            realm.create(Deck.self, value: deck, update: true)
                            
                        })
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


