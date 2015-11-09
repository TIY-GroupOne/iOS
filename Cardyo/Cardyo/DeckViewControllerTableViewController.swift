//
//  DeckViewControllerTableViewController.swift
//  Cardyo
//
//  Created by Mac Bellingrath on 11/7/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire




class DecksTableViewController: UITableViewController {
    
    var decks = try? Realm().objects(Deck)

    
    @IBAction func addDeckButtonPressed(sender: AnyObject) {
        let token: String = "16dbf0279998c0fb0a5c360b3d5e51a1"
        let base = "https://cardyo.herokuapp.com"
        let headers = ["access_token":token]
        let deckURL = base + "/decks"
        let deckparams = ["title":"World"]
       
        Alamofire.request(.POST, deckURL, parameters: deckparams , encoding: .JSON, headers: headers).responseJSON(options: .MutableContainers) { (response) -> Void in
            switch response.result {
            case .Failure(let error) : print(error)
            case .Success(let value):
                print(value)
                if let deck = value["deck"] as? [String: AnyObject] {
                    let realm =  try! Realm()
                    
                    try! realm.write({ () -> Void in
                        realm.create(Deck.self, value: deck, update: true)
                        self.tableView.reloadData()
                    })
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationItem.leftBarButtonItem = self.editButtonItem()
////        let users = try! Realm().objects(User).filter{ $0.accessToken == NSUserDefaults.standardUserDefaults().objectForKey("token") as? String }
//        print(users)
//        title = users.first?.username
//        
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let decks = decks else { return 0 }
        return decks.count
    }

        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            guard let decks = decks else { return UITableViewCell() }
      
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            
            
            let deck = decks[indexPath.row]
            
            cell.textLabel?.text = deck.title
            cell.detailTextLabel?.text = String(deck.cards.count)

   

        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
         
            let realm = try! Realm()
           
            realm.beginWrite()
            realm.delete(decks![indexPath.row])
           
            try! realm.commitWrite()
        }
        tableView.reloadData()
    }




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
