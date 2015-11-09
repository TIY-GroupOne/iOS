//
//  ViewController.swift
//  RR
//
//  Created by Mac Bellingrath on 11/5/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON





class ViewController: UIViewController {
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let token: String = "16dbf0279998c0fb0a5c360b3d5e51a1"
        let base = "https://cardyo.herokuapp.com"
        let headers = ["access_token":token]
        let deckURL = base + "/decks"
        let deckparams = ["title":"Hello"]
        Alamofire.request(.POST, deckURL, parameters: deckparams , encoding: .JSON, headers: headers).responseJSON(options: .MutableContainers) { (response) -> Void in
            switch response.result {
            case .Success(let value) : print(value)
            case .Failure(let error) : print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

