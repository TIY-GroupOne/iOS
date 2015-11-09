//
//  DeckCreationTableViewController.swift
//  CardyoApp
//
//  Created by Mac Bellingrath on 11/8/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit
import Alamofire


class DeckCreationTableViewController: UITableViewController, UITextFieldDelegate {
    
    var deck: CDODeck = CDODeck(userid: "0", title: ""){
        didSet{
            print("deck is set")
            tableView.reloadData()
            title = deck.title
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let decktitle = deckTitleLabel.text {
        self.deck.title = decktitle
        }
        
        
    }
    
   
    
    @IBOutlet weak var deckTitleLabel: UITextField! {
        didSet {
            deck.title = deckTitleLabel.text!
            navigationController?.title = deckTitleLabel.text
        }
    }
    private var cardTerm: String = ""
    private var cardDef: String = ""
    
    @IBAction func addCardButtonPressed(sender: AnyObject) {
        let ac = UIAlertController(title: "Add Card", message: "Enter a title and description", preferredStyle: .Alert)
        
      ac.addTextFieldWithConfigurationHandler { (textfield) -> Void in
            textfield.placeholder = "Term"
            
        }
        ac.addTextFieldWithConfigurationHandler { (textfield) -> Void in
            textfield.placeholder = "Definition"
        }
        ac.addAction(UIAlertAction(title: "Done", style: .Default, handler: {(action) -> Void in
            guard let term = ac.textFields?.first?.text, let def = ac.textFields?.last?.text else { print("error with alertcontroller textfields"); return }
            
            //TODO: - change deck id
            let card = CDOCard(term: term, def: def, deckid: "0" , cardID: "0")
            
            self.deck.cards.append(card)
           
//            self.dismissViewControllerAnimated(true, completion: nil)
            self.tableView.reloadData()
        }))
        presentViewController(ac, animated: true, completion: nil)
        
    }
    
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
         deck.title = deckTitleLabel.text!
        //Save Deck

        print(deck.title)
        
        NetworkManager.sharedManager().createDeck(deck.title)
        
        navigationController?.popToRootViewControllerAnimated(true)

        
        
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
        return deck.cards.count
    
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DeckCreationTableViewCell
        
        let card = deck.cards[indexPath.row]
        cell.termLabel.text = card.term
        cell.definitionLabel.text = card.definition

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
    
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
