//
//  CDODeck.swift
//  CardyoApp
//
//  Created by Mac Bellingrath on 11/8/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit
import Gloss


struct CardyoDeck: Decodable, Glossy {
    var deckID: Int
    var userID: Int
    var title: String?
    
    init?(json: JSON) {
        guard let dkid: Int = "deck_id" <~~ json else { return nil }
        guard let usrID: Int = "user_id" <~~ json else { return nil }
        
        
        self.deckID = dkid
        self.userID = usrID
        self.title = "title" <~~ json
        
    }
    
    func toJSON() -> JSON? {
       
        return jsonify([
            "deck_id" ~~> self.deckID,
            "user_id" ~~> self.userID,
            "title"  ~~> self.title
            
        ])
    }
}



class CDODeck: NSObject {
    var id: String?
    var userID: String
    var title: String
    var cards: [CDOCard] = []

    
    
    init(userid: String, title: String) {
        self.userID = userid
        self.title = title
        super.init()
    }
    
    init(withCards cards: [CDOCard], title: String, userid: String) {
        self.cards = cards
        self.title = title
        self.userID = userid
        super.init()
    }
}

//Deck Model
//
//User ID
//Title
