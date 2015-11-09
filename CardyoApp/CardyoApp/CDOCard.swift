//
//  CDOCard.swift
//  CardyoApp
//
//  Created by Mac Bellingrath on 11/8/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit

class CDOCard: NSObject {
    var term: String
    var definition: String
    var deckID: String
    var cardID: String
    
    init(term: String, def: String, deckid: String, cardID: String) {
        self.term = term
        self.definition = def
        self.deckID = deckid
        self.cardID = cardID
    
    }

    

    
}
//Card Model
//
//Question
//Answer
//Deck ID
