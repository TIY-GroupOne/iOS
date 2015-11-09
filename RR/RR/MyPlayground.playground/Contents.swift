//: Playground - noun: a place where people can play

import UIKit
import Alamofire
import SwiftyJSON

let username = "swiftyrails"
let password = "secretpassword"
let email = "swiftyrails@icloud.com"


let base = "https://cardyo.herokuapp.com"
let signupURL = base + "/signup"
let params = [ "username": username, "password":password, "email": email ]
var token: String = "16dbf0279998c0fb0a5c360b3d5e51a1"
let headers = ["access_token":token]
let deckURL = base + "/decks"
let deckparams = ["title":"Hello"]
//
////SigningUp
//Alamofire.request(.POST, signupURL, parameters: params, encoding: .JSON, headers: nil).responseJSON { response  in
//    
//    
//
//}
var token: String = "16dbf0279998c0fb0a5c360b3d5e51a1"

let headers = ["access_token":token]
let deckURL = base + "/decks"
let deckparams = ["title":"Hello"]
Alamofire.request(.POST, deckURL, parameters: deckparams , encoding: .JSON, headers: headers).responseJSON(options: .MutableContainers) { (response) -> Void in
    switch response.result {
    case .Success(let value) : print(value)
    case .Failure(let error) : print(error)
    }
}