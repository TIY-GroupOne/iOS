//
//  ChoiceViewController.swift
//  Selfie
//
//  Created by Mac Bellingrath on 10/26/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit



class ChoiceViewController: UIViewController {
 
    @IBAction func loginWithTwitterButtonPressed(sender: UIButton) {
  
        
    }

    @IBAction func loginButtonPressed(sender: AnyObject) {
        
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        if let initial = mainSB.instantiateInitialViewController() as? UINavigationController {
            UIApplication.sharedApplication().windows.first?.rootViewController = initial

        }
    }
}
