//
//  ViewController.swift
//  Treasure Hunt
//
//  Created by George Kolecsanyi on 11/5/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // start background music
        SKTAudio.sharedInstance().playBackgroundMusic()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // reference app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // construct default treasure map annotation focus
        appDelegate.userAnnotationsFocus = []
        for friend in appDelegate.currentUser.friends {
            appDelegate.userAnnotationsFocus.append( friend )
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // load test data into application
        loadTestData()
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
        
        // reference app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // handle segue destinations
        if segue.destination is FriendVC
        {
            // to friend view controller
        } else if segue.destination is ProfileVC
        {
            // to treasure resource view controller
            let vc = segue.destination as? ProfileVC
            vc?.user = appDelegate.currentUser
        }
    }
    
    func loadTestData() {
        // reference app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if !(appDelegate.currentUser.friends.count > 0) {
            // TESTING - Add Custom Default User for startup
            
            // add current user treasure
            appDelegate.currentUser.treasures.append( Treasure( identifier: 0, Content: "", Destination: "Southbank Melbourne" ) )
            appDelegate.currentUser.treasures.append( Treasure( identifier: 1, Content: "", Destination: "Richmond Melbourne" ) )
            appDelegate.currentUser.treasures.append( Treasure( identifier: 2, Content: "", Destination: "North Melbourne" ) )
            appDelegate.currentUser.treasures.append( Treasure( identifier: 3, Content: "", Destination: "Collingwood" ) )
            
            // add friends
            appDelegate.currentUser.friends.append( User(details: PersonDetails(UserID: "a", UserName: "zOren", FirstName: "Zachery", Surname: "Orenstein", eMail: "zoren@test.com") ) )
            appDelegate.currentUser.friends.append( User(details: PersonDetails(UserID: "b", UserName: "poopmaster", FirstName: "Sherill", Surname: "Elia", eMail: "selia@test.com") ) )
            appDelegate.currentUser.friends.append( User(details: PersonDetails(UserID: "c", UserName: "leLOL", FirstName: "Hilario", Surname: "Legrand", eMail: "hlegrand@test.com") ) )
            
            // add friends treasures
            appDelegate.currentUser.friends[0].treasures.append( Treasure(identifier: 4, Content: "", Destination: "Brunswick East" ) )
            appDelegate.currentUser.friends[0].treasures.append( Treasure(identifier: 5, Content: "", Destination: "South Yarra" ) )
            appDelegate.currentUser.friends[0].treasures.append( Treasure(identifier: 6, Content: "", Destination: "St Kilda East" ) )
            appDelegate.currentUser.friends[0].treasures.append( Treasure(identifier: 7, Content: "", Destination: "Elwood" ) )
            
            appDelegate.currentUser.friends[1].treasures.append( Treasure(identifier: 8, Content: "", Destination: "Toorak" ) )
            appDelegate.currentUser.friends[1].treasures.append( Treasure(identifier: 9, Content: "", Destination: "Camberwell" ) )
            appDelegate.currentUser.friends[1].treasures.append( Treasure(identifier: 10, Content: "", Destination: "Footscray" ) )
            appDelegate.currentUser.friends[1].treasures.append( Treasure(identifier: 11, Content: "", Destination: "Brunswick" ) )
            
            appDelegate.currentUser.friends[2].treasures.append( Treasure(identifier: 12, Content: "", Destination: "Geelong" ) )
            appDelegate.currentUser.friends[2].treasures.append( Treasure(identifier: 13, Content: "", Destination: "Essendon" ) )
            appDelegate.currentUser.friends[2].treasures.append( Treasure(identifier: 14, Content: "", Destination: "Burwood" ) )
            appDelegate.currentUser.friends[2].treasures.append( Treasure(identifier: 15, Content: "", Destination: "Ivanhoe" ) )
            
            // set found treasure for user
            appDelegate.currentUser.foundTreasure = [5,10,15]
        }
    }

}

