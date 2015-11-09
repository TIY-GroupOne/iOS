//
//  SessionManager.swift
//  RR
//
//  Created by Mac Bellingrath on 11/7/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


private let _session = SessionManager()


private let _d = NSUserDefaults.standardUserDefaults()

class SessionManager: NSObject {
    
    private static let base = "https://cardyo.herokuapp.com/"
 
    var token: String? {
        get { return _d.objectForKey("token") as? String }
        set { _d.setObject(newValue, forKey: "token") }
    }
   
    
    static func sharedManager() -> SessionManager { return _session }
    
    

}

