//
//  person.swift
//  Treasure Hunt
//
//  Created by George Kolecsanyi on 11/5/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import Foundation

// person structure acts as identity of person (user/friend)
class PersonDetails {
    // Properties
    var uid : String                // user identity
    var username : String           // user name
    var firstname: String           // user firstname
    var surname : String            // user surname
    var email : String              // user email
    
    init(
        // Class Initialization Parameters
        UserID: String,
        UserName: String,
        FirstName: String,
        Surname: String,
        eMail: String
    ) {
        // Class Configuration Initialization from Parameters
        uid = UserID
        username = UserName
        firstname = FirstName
        surname = Surname
        email = eMail
    }
}
