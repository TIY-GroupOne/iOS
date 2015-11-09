//
//  User.swift
//  Cardyo
//
//  Created by Mac Bellingrath on 11/8/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: String = ""
    var username = ""
    var email = ""
    var accessToken: String? {
        get { return NetworkManager.token }
        set { NetworkManager.token = newValue }
    }
    static func save(user: User) {
        NSUserDefaults.standardUserDefaults().setObject(user, forKey: "currentUser")
    }
    
    init(id: String, username: String, email: String) {
        self.id = id
        self.username = username
        self.email = email
    }

}
