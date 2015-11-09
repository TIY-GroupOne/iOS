//
//  ViewController.swift
//  ZLSwipeableViewSwiftDemo
//
//  Created by Zhixuan Lai on 4/27/15.
//  Copyright (c) 2015 Zhixuan Lai. All rights reserved.
//

import UIKit
import performSelector_swift
import UIColor_FlatColors
import Cartography
import ReactiveUI
import ZLSwipeableViewSwift


let _themeColor = UIColor.flatWetAsphaltColor()



class ZLSwipeableViewController: UIViewController, CardViewDelegate {

    
    var deck: CDODeck! {
        didSet {
            
        }
    }
    
   var swipeableView: ZLSwipeableView!
   
    
    var colors = ["Turquoise", "Green Sea", "Emerald", "Nephritis", "Peter River", "Belize Hole", "Amethyst", "Wisteria", "Wet Asphalt", "Midnight Blue", "Sun Flower", "Orange", "Carrot", "Pumpkin", "Alizarin", "Pomegranate", "Clouds", "Silver", "Concrete", "Asbestos"]
    var colorIndex = 0
    var loadCardsFromXib = true
    var cardIndex = 0
    
    var reloadBarButtonItem = UIBarButtonItem(title: "Start", style: .Plain) { item in }
    var leftBarButtonItem = UIBarButtonItem(title: "←", style: .Plain) { item in }
    var upBarButtonItem = UIBarButtonItem(title: "↑", style: .Plain) { item in }
    var rightBarButtonItem = UIBarButtonItem(title: "→", style: .Plain) { item in }
    var downBarButtonItem = UIBarButtonItem(title: "↓", style: .Plain) { item in }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        swipeableView?.loadViews()
       
         
        
 
    }
    
    func userMadeChoice(answer: String) {
        
        // handle choice
        
    }
    
    func configureTheme() {
        title = "cardyo"
        
        //change to show toolbar
        navigationController?.setToolbarHidden(true, animated: false)
        
        navigationController?.navigationBar.barTintColor = _themeColor
        navigationController?.toolbar.backgroundColor = _themeColor
        view.backgroundColor = _themeColor
        navigationController?.toolbar.barTintColor = _themeColor
        navigationController?.toolbar.tintColor = UIColor.whiteColor()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        configureTheme()
    
        view.clipsToBounds = true
        
        reloadBarButtonItem.addAction() { item in
            let alertController = UIAlertController(title: nil, message: "Load Cards:", preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                // ...
            }
            alertController.addAction(cancelAction)
            
            let ProgrammaticallyAction = UIAlertAction(title: "Programmatically", style: .Default) { (action) in
                self.loadCardsFromXib = false
                self.colorIndex = 0
                self.swipeableView.discardViews()
                self.swipeableView.loadViews()
            }
            alertController.addAction(ProgrammaticallyAction)
            
            let XibAction = UIAlertAction(title: "From Xib", style: .Default) { (action) in
                self.loadCardsFromXib = true
                self.colorIndex = 0
                self.swipeableView.discardViews()
                self.swipeableView.loadViews()
            }
            alertController.addAction(XibAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        leftBarButtonItem.addAction() { item in
            self.swipeableView.swipeTopView(inDirection: .Left)
        }
        upBarButtonItem.addAction() { item in
            self.swipeableView.swipeTopView(inDirection: .Up)
        }
        rightBarButtonItem.addAction() { item in
            self.swipeableView.swipeTopView(inDirection: .Right)
        }
        downBarButtonItem.addAction() { item in
            self.swipeableView.swipeTopView(inDirection: .Down)
        }
        
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .FixedSpace, action: {item in})
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, action: {item in})
        
        let items = [fixedSpace, reloadBarButtonItem, flexibleSpace, leftBarButtonItem, flexibleSpace, upBarButtonItem, flexibleSpace, rightBarButtonItem, flexibleSpace, downBarButtonItem, fixedSpace]
        toolbarItems = items
        
        swipeableView = ZLSwipeableView()
        view.addSubview(swipeableView)
        swipeableView.didStart = {view, location in
            print("Did start swiping view at location: \(location)")
            
            // Do something here
            self.userMadeChoice("left")
        }
        swipeableView.swiping = {view, location, translation in
            print("Swiping at view location: \(location) translation: \(translation)")
        }
        swipeableView.didEnd = {view, location in
            print("Did end swiping view at location: \(location)")
        }
        swipeableView.didSwipe = {view, direction, vector in
            
            if direction == .Left {
                print("awesome left")
            }
            print("Did swipe view in direction: \(direction), vector: \(vector)")
        }
        swipeableView.didCancel = {view in
            print("Did cancel swiping view")
        }
        swipeableView.nextView = {
            return self.nextCardView()
        }
        
        constrain(swipeableView, view) { view1, view2 in
            view1.left == view2.left+50
            view1.right == view2.right-50
            view1.top == view2.top + 120
            view1.bottom == view2.bottom - 100
        }
    }
    
    // MARK: ()
    func nextCardView() -> UIView? {
        if colorIndex >= colors.count {
            colorIndex = 0
        }
        if cardIndex >= deck.cards.count {
            
            //todo
            print("end game")
        }
        
        
        //configure card view
        let cardView = CardView(frame: swipeableView.bounds)
        cardView.backgroundColor = colorForName(colors[colorIndex])
        
        
        //TODO: - DELEGATE CONFIG
//        cardView.delegate = self
        // set answers
        
        colorIndex++
        
        if loadCardsFromXib {
            let contentView = NSBundle.mainBundle().loadNibNamed("CardyoStackView", owner: self, options: nil).first! as! CardView
            contentView.card = self.deck.cards[cardIndex]
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.backgroundColor = cardView.backgroundColor
            cardView.addSubview(contentView)
            
            
        
            
            
            
            
            // This is important:
            // https://github.com/zhxnlai/ZLSwipeableView/issues/9
            /*// Alternative:
            let metrics = ["width":cardView.bounds.width, "height": cardView.bounds.height]
            let views = ["contentView": contentView, "cardView": cardView]
            cardView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView(width)]", options: .AlignAllLeft, metrics: metrics, views: views))
            cardView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView(height)]", options: .AlignAllLeft, metrics: metrics, views: views))
            */
            constrain(contentView, cardView) { view1, view2 in
                view1.left == view2.left
                view1.top == view2.top
                view1.width == cardView.bounds.width
                view1.height == cardView.bounds.height
            }
        }
        return cardView
    }
    
    func colorForName(name: String) -> UIColor {
        let sanitizedName = name.stringByReplacingOccurrencesOfString(" ", withString: "")
        let selector = "flat\(sanitizedName)Color"
        return UIColor.swift_performSelector(Selector(selector), withObject: nil) as! UIColor
    }
    
}





