//
//  DecksTableViewController.swift
//  CardyoApp
//
//  Created by Mac Bellingrath on 11/8/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh


class DecksTableViewController: UITableViewController {
    
   
    
    var decks: [CardyoDeck]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        NetworkManager.sharedManager().getAllDecks({ (decks) -> Void in
            guard let d = decks else { return }
            self.decks = d
        })
    }
    
    
    
    
   
    var decktitle = ""
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize tableView
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            // Add your logic here
            self?.tableView.reloadData()
          
            // Do not forget to call dg_stopLoading() at the end
            self?.tableView.dg_stopLoading()
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor.whiteColor())
        tableView.dg_setPullToRefreshBackgroundColor(UIColor(red:0, green:0.5, blue:1, alpha:1))
        
//        let deck = CDODeck(userid: "1", title: "Test Deck")
//        let cdoCard = CDOCard(term: "Hello", def: "World", deckid: "1", cardID: "1")
//        
//        deck.cards = [cdoCard]
//        decks.append(deck)
        
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard  let  d = decks else { return 0 }
        return d.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        guard  let  d = decks else { return UITableViewCell() }
        
        let deck = d[indexPath.row]
        
        cell.textLabel?.text = deck.title

        // Configure the cell...

        return cell
    }
 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        guard  let  d = decks else { return  }
        let deck = d[indexPath.row]
        
        let gameSB = UIStoryboard(name: "Game", bundle: nil)
        if let swipeVC = gameSB.instantiateInitialViewController() as? ZLSwipeableViewController {
//            swipeVC.deck = deck
            
            navigationController?.pushViewController(swipeVC, animated: true)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let vc = segue.destinationViewController as? DeckCreationTableViewController {
//            
//                let deck = CDODeck(userid: "0", title: decktitle)
//          
//                vc.deck = deck
//            
//        }
//
//    }
//    
//
}


extension UIViewController {
    
    
    
    var alert: (message: String, reason: String ) -> () { return
        {
            message, reason in let alertVC = UIAlertController(title: message, message: reason, preferredStyle: .Alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alertVC, animated: true, completion: nil)
        }
    }
}


