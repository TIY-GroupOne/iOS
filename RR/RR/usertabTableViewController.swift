//
//  usertabTableViewController.swift
//  RR
//
//  Created by Mac Bellingrath on 11/8/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit
import RealmSwift
import AFNetworking
import Alamofire
import SwiftyJSON

class User: Object {
    dynamic var token:String = ""
    dynamic var email: String = ""
    dynamic var username: String = ""
    
    override static func primaryKey() -> String {
        return "token"
    }
}

class Deck: Object {
    dynamic var id: Int = 0
    dynamic var userID: String = ""
    dynamic var title: String = ""
    
    override static func primaryKey() -> String {
        return "id"
    }
}


class DecksTableViewController: UITableViewController {
    
    
    
    var decks = try! Realm().objects(Deck)
    
    @IBAction func signup(sender: AnyObject) {
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
        
        
       

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

  

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return decks.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let deck = decks[indexPath.row] 
        
        

        // Configure the cell...
        cell.textLabel?.text = deck.title

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
