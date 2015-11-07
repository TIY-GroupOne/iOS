//
//  CardView.swift
//  Cardyo
//
//  Created by Mac Bellingrath on 11/5/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit


protocol CardViewDelegate: class {
    
    func userMadeChoice(answer: String)
}

class CardView: UIView {
    
//    var card: Card = Card(term: "Test", definition: "Test", deckID: "!")
    
    
//    weak var delegate: CardViewDelegate?
    
    
    @IBOutlet weak var left: UILabel!
    @IBOutlet weak var right: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
   

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    
//    override func didMoveToSuperview() {
//        self.titleLabel.text = card.term
//        self.left.text = card.definition
//        
//        //change this
//        self.right.text = "Greece"
//    }
    
    func setup() {
        // Shadow
        
       
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSizeMake(0, 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.mainScreen().scale
        
        // Corner Radius
        layer.cornerRadius = 10.0;
        
       
    }
    deinit {
        print("cardview deinitialized")
    }
}




