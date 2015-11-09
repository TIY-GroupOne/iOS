//
//  CDOGuesses.swift
//  CardyoApp
//
//  Created by Mac Bellingrath on 11/8/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit

class CDOGuess: NSObject {
    var cardID: String
    var userID: String
    var duration: Int
    var correct: Bool
    
    init(cardID: String, userID: String, duration: Int, correct: Bool) {
        self.cardID = cardID
        self.userID = userID
        self.duration = duration
        self.correct = correct
    }


}
//User Guesses Model
//
//Card ID
//User ID
//Duration (lenght of time to answer)
//Correct (boolean)


//Hard Mode Ideas
//
//Flaging
//Multiple Choice
//Voting System (Like, Star)
//Deck Dompletion