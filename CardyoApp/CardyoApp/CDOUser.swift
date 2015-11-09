//
//  CDOUser.swift
//  CardyoApp
//
//  Created by Mac Bellingrath on 11/8/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit

class CDOUser: NSObject {
     var userName: String = ""
     var email: String = ""
     var password: String = ""
     var token: String = ""
    
    init(username: String, email: String, password: String, token: String) {
        
        self.userName = username
        self.password = password
        self.email = email
        self.token = token
        
//        super.init()
        
    }
    
    


}
//User Model
//
//Username
//Full Name
//Email
//Password
