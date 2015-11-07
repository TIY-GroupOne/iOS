//
//  CardyoTests.swift
//  CardyoTests
//
//  Created by Mac Bellingrath on 11/4/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import XCTest
@testable import Cardyo


class CardyoTests: XCTestCase {
    
    
       
  
    
    func testRailsRegistration() {
        
        self.measureBlock { () -> Void in
            
        
        
        let expect = self.expectationWithDescription("expect registration response")
        
        RailsRequest.session().register(withUserName: "Crufty", andPassword: "secrets", andEmail: "crufty@icloud.com") { (success) -> () in
            XCTAssertTrue(success)
            XCTAssertNotNil(RailsRequest.session().token, "token is nil")
            expect.fulfill()
            
        }
        self.waitForExpectationsWithTimeout(20) { (error) -> Void in
            print(error)
        }
    
        
        
        }
        
    }
    
    
    func testCreateDeck() {
        
        self.measureBlock { () -> Void in
       
            let expectation = self.expectationWithDescription("Expect deck is created")
            
            RailsRequest.session().getDeckWithCompletion(withDeckTitle: "Test", completion: { () -> () in
                
                expectation.fulfill()
                
            })
            self.waitForExpectationsWithTimeout(10, handler: { (error) -> Void in
                print(error)
            })
            
            
        }
    }
    
//    func testRailsLogIn() {
//        
//        RailsRequest.session().loginWithUsername("mac", andPassword: "password")
//        
//        let token = RailsRequest.session().token
//        XCTAssertNotNil(token, "token is nil")
//    }
    
}
