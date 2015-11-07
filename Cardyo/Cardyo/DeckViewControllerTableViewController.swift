//
//  DeckViewControllerTableViewController.swift
//  Cardyo
//
//  Created by Mac Bellingrath on 11/7/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit
import RealmSwift


class DeckViewControllerTableViewController: UITableViewController {
    
    var decks = try? Realm().objects(Deck)
    
    @IBAction func addDeckButtonPressed(sender: AnyObject) {
        
        let deck = Deck()
        deck.title = "Ancient Greece"
        deck.id = 1

        
        // Get the default Realm
        let realm = try! Realm()
        // You only need to do this once (per thread)
        
        // Add to the Realm inside a transaction
        try! realm.write {
            realm.add(deck)
        }
        tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
  
         self.navigationItem.leftBarButtonItem = self.editButtonItem()
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
