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
        
        self.definesPresentationContext = true
//        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.hidesBarsWhenKeyboardAppears = false
        
        

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



        

    
        



