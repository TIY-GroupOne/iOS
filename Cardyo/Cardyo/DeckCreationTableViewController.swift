//
//  DeckCreationTableViewController.swift
//  Cardyo
//
//  Created by Mac Bellingrath on 11/7/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit
import RealmSwift

class DeckCreationTableViewController: UITableViewController {
    
    
    var cards = try! Realm().objects(Card)
    
    var cardsArray = [Card]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var titleLabel: UITextField!

    @IBAction func addCardButtonClicked(sender: AnyObject) {
        
        let ac = UIAlertController(title: "Add Card", message: "Enter a term and definition", preferredStyle: .Alert)
        ac.addTextFieldWithConfigurationHandler { (termfield) -> Void in
            termfield.placeholder = "Term"
        }
       ac.addTextFieldWithConfigurationHandler { (defTextField) -> Void in
            defTextField.placeholder = "Definition"
            
        }
        ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
            guard let term = ac.textFields?.first?.text, let def = ac.textFields?.last?.text else { return }
            let card = Card()
            card.term = term
            card.definition = def
            
            self.cardsArray.append(card)
        
      
 
        }))
        presentViewController(ac, animated: true, completion: nil)
        

    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        guard let deckTitle = titleLabel.text else { return }
        // Get the default Realm
        let deck = Deck()
        deck.title = deckTitle
        
        for card in cards {
            deck.cards.append(card)
        }
        
        
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
//        guard let c = cards else { return 0 }
        return cardsArray.count
    }
    
    
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        
        let card = cardsArray[indexPath.row]
        
        cell.textLabel?.text = card.term
        cell.detailTextLabel?.text = card.definition
        
        
        
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
