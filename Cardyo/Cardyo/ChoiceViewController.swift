//
//  ChoiceViewController.swift
//  Selfie
//
//  Created by Mac Bellingrath on 10/26/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit
import Twitter



class ChoiceViewController: UIViewController {
    

 
    @IBAction func loginWithTwitterButtonPressed(sender: UIButton) {
        
//        PFTwitterUtils.logInWithBlock { (user, error) -> Void in
//            guard user != nil else {
//                print("error logging in using twitter")
//                return
//            }
//          
//            guard user?.isNew != true else {
//                print("User is signed up and logged in with Twitter")
//                let main = UIStoryboard(name: "Main", bundle: nil)
//                if let nc = main.instantiateInitialViewController() {
//                
//                self.navigationController?.presentViewController(nc, animated: true, completion: nil)
//                
//                }
//                return
//            }
//            
//            //User already logged in
//            print("User is logged in with Twitter")
//            let main = UIStoryboard(name: "Main", bundle: nil)
//            if let nc = main.instantiateInitialViewController() {
//            self.navigationController?.presentViewController(nc, animated: true, completion: nil)
//            }
//            
//        }
//    
        
        
    }

    @IBAction func loginButtonPressed(sender: AnyObject) {
        
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        if let initial = mainSB.instantiateInitialViewController() as? UINavigationController {
            UIApplication.sharedApplication().windows.first?.rootViewController = initial

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //create image
        if let image = UIImage(named: "logo_green") {
        let imageView = UIImageView(image: image)
            
        // set the text view to the image view
        self.navigationItem.titleView = imageView
        }
    }
    

   
}
