//
//  LoginViewController.swift
//  Selfie
//
//  Created by Mac Bellingrath on 10/26/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController, UITextFieldDelegate    {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBAction func  loginButtonPressed(sender: UIButton) {
        logIn()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = AppTheme.sharedTheme().themeColor

        // Do any additional setup after loading the view.
    }
    

    
    func logIn(){
        
        guard let userName = userNameTextField.text, let password = passwordTextfield.text else { return }
        
        let mainsb = UIStoryboard(name: "Main", bundle: nil)
            NetworkManager.sharedManager().login(userName, password: password) { (success) in
                if success {
                    if let tab = mainsb.instantiateInitialViewController() as? UITabBarController
                    {
                        self.navigationController?.pushViewController(tab, animated: true)
                    } else  {
                        self.alertError(message: "Log in failed.", reason: "Please try again.")
                        
                }
            }
        }
    }

    
    
    //MARK: Textfield
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == userNameTextField {
            passwordTextfield.becomeFirstResponder()
        }
        else {
        textField.resignFirstResponder()
        
        }
        return true
    }
}



        
//        PFUser.logInWithUsernameInBackground(userName, password: password) { (user, error) in
//            
//        guard (user != nil) else {
//                let ac = UIAlertController(title: "Oops", message: "We couldn't log you in using the username and password provided. Try again.", preferredStyle: .Alert)
//                ac.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
//                self.presentViewController(ac, animated: true, completion: nil)
//                return
//            }
//            
//            
//            let main = UIStoryboard(name: "Main", bundle: nil)
//            let nc = main.instantiateInitialViewController()
//            
//           UIApplication.sharedApplication().windows.first?.rootViewController = nc

    
        



