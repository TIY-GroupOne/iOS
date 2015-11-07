//
//  Card.swift
//  Cardyo
//
//  Created by Mac Bellingrath on 11/6/15.
//  Copyright © 2015 TeamOne. All rights reserved.

//#REGISTRATION CONTROLLER
//post "/signup", to: "registrations#create"
//delete "/signup", to: "registrations#destroy"
//post "/login", to: "registrations#login"
//get "/logout", to: "registrations#logout"
//
//#USER CONTROLLERS
//get "/users", to: "users#index"
//get "/users/:id", to: "users#info" , as: "user"
//post "/users/new", to: "users#new"
//get "/users/:id/profile", to: "users#profile", as: "profile"
//
//#DECK AND CARD ROUTES
//get "/index" , to: "deck#index"
//get "/decks/:id/cards" , to: "deck#retrieve", as: "deck"
//get "/decks/cards/:id", to: "card#show", as: "card"
//post "/decks" , to: "deck#create"
//post "/decks/:id/cards" , to: "card#create"
//delete "/decks/:id" , to: "deck#delete"
//delete "/decks/cards/:id" , to: "card#delete"
//put "/decks/cards/:id", to: "card#editcard"
//
//#GUESS CONTROLLER
//get "/answers", to: "guess#retrieve"
//post "/answers", to: "guess#record"
////

import Foundation
import RealmSwift

class User: Object {
    dynamic var id: String = "123"
    dynamic var name: String = ""
    dynamic var token: String = ""
}


class Card: Object {
   
   dynamic var id: String = ""
   dynamic var term: String = ""
   dynamic var definition: String = ""
   dynamic var deck: Deck?
    
}


class Deck: Object {
    dynamic var id: Int = 0
    var cards = List<Card>()
    dynamic var title: String = ""
    dynamic var user: User?
    
}






