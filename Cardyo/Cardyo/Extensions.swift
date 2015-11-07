//
//  Extensions.swift
//  Cardyo
//
//  Created by Mac Bellingrath on 11/5/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var alertError: (message: String, reason: String ) -> () { return
        {
            message, reason in let alertVC = UIAlertController(title: message, message: reason, preferredStyle: .Alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alertVC, animated: true, completion: nil)
        }
    }
}