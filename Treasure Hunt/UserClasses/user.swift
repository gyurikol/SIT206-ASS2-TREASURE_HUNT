//
//  user.swift
//  Treasure Hunt
//
//  Created by George Kolecsanyi on 11/5/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import Foundation

// user class that acts as identity of device user
class User {
    // Properties
    var person : PersonDetails
    var treasures : [Treasure] = []     // Treasures associated with the user
    var friends : [User] = []           // Other Users associated with current device user
    var foundTreasure : [Int] = []      // Identities of Treasures Found
    
    // Initializer
    init( details: PersonDetails )
    {
        self.person = details           // set person details
    }
    
    // function to get the next assignable treasure id
    func getNextTid () -> Int {
        // current max treasure id
        var max : Int = -1
        
        // build list of treasures
        var treasureList = treasures
        for user in friends {
            for friendTreasure in user.treasures {
                treasureList.append(friendTreasure)
            }
        }
        
        // find max integer
        for tres in treasureList {
            if tres.getIdentity() > max {
                max = tres.getIdentity()
            }
        }
        
        // return next treasure id
        return (max + 1)
    }
}
