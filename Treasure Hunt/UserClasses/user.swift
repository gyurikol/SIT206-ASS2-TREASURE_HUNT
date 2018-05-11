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
    var treasure : [Treasure]?          // Treasures associated with the user
    var friends : [User]?               // Other Users associated with current device user
    
    // Initializer
    init( details: PersonDetails )
    {
        self.person = details           // set person details
    }
}
