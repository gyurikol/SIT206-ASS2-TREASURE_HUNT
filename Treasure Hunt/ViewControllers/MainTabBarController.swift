//
//  MainTabBarController.swift
//  Treasure Hunt
//
//  Created by George Kolecsanyi on 14/5/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // reference app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // TESTING - Add Custom Default User for startup
        appDelegate.currentUser.treasures.append( Treasure( identifier: "0", Content: "testing 1 2 3", Destination: "Melbourne" ) )
        appDelegate.currentUser.friends.append( User(details: PersonDetails(UserID: "a", UserName: "zOren", FirstName: "Zachery", Surname: "Orenstein", eMail: "testa@test.com") ) )
        appDelegate.currentUser.friends.append( User(details: PersonDetails(UserID: "b", UserName: "poopmaster", FirstName: "Sherill", Surname: "Elia", eMail: "testb@test.com") ) )
        appDelegate.currentUser.friends.append( User(details: PersonDetails(UserID: "c", UserName: "leLOL", FirstName: "Hilario", Surname: "Legrand", eMail: "testc@test.com") ) )
        
        appDelegate.currentUser.friends[0].treasures.append( Treasure(identifier: "1", Content: "Perth", Destination: "Perth" ) )
        appDelegate.currentUser.friends[1].treasures.append( Treasure(identifier: "2", Content: "Darwin", Destination: "Darwin" ) )
        appDelegate.currentUser.friends[2].treasures.append( Treasure(identifier: "3", Content: "Brisbane", Destination: "Brisbane" ) )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
