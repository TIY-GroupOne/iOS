//: Playground - noun: a place where people can play

import UIKit

class User {
    var id = 12345
}

class Card {
    let user: User
    var title: String
    var definition: String
    
    init(user: User, title: String, definition: String) {
        self.user = user
        self.title = title
        self.definition = definition
    }
    
}


class Deck {
    let id: Int
    var title: String
    let user: User
    var cards: [Card] = []
    
    init(id: Int, title: String, user: User) {
        self.id = id
        self.title = title
        self.user = user
    }
    
    func addCard(card: Card) {
        self.cards.append(card)
    }
}

let me = User()

let card = Card(user: me, title: "Foo", definition: "Bar")

let deck = Deck(id: 1, title: "Test Deck", user: me)

deck.addCard(card)

