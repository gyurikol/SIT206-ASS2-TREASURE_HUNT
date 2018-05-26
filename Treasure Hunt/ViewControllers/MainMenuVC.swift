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
            appDelegate.currentUser.treasures.append( Treasure( identifier: 0, Content: "They offered her a ride home.", Destination: "Southbank Melbourne" ) )
            appDelegate.currentUser.treasures.append( Treasure( identifier: 1, Content: "Peter showed them a photograph.", Destination: "Richmond Melbourne" ) )
            appDelegate.currentUser.treasures.append( Treasure( identifier: 2, Content: "I save him a piece of pie.", Destination: "North Melbourne" ) )
            appDelegate.currentUser.treasures.append( Treasure( identifier: 3, Content: "That taxi driver teaches them mathematics.", Destination: "Collingwood" ) )
            
            // add friends
            appDelegate.currentUser.friends.append( User(details: PersonDetails(UserID: "a", UserName: "zOren", FirstName: "Zachery", Surname: "Orenstein", eMail: "zoren@test.com") ) )
            appDelegate.currentUser.friends.append( User(details: PersonDetails(UserID: "b", UserName: "poopmaster", FirstName: "Sherill", Surname: "Elia", eMail: "selia@test.com") ) )
            appDelegate.currentUser.friends.append( User(details: PersonDetails(UserID: "c", UserName: "leLOL", FirstName: "Hilario", Surname: "Legrand", eMail: "hlegrand@test.com") ) )
            
            // add friends treasures
            appDelegate.currentUser.friends[0].treasures.append( Treasure(identifier: 4, Content: "Those cashiers lend him the bicycle.", Destination: "Brunswick East" ) )
            appDelegate.currentUser.friends[0].treasures.append( Treasure(identifier: 5, Content: "Robert told them a joke.", Destination: "South Yarra" ) )
            appDelegate.currentUser.friends[0].treasures.append( Treasure(identifier: 6, Content: "They paid him this salary.", Destination: "St Kilda East" ) )
            appDelegate.currentUser.friends[0].treasures.append( Treasure(identifier: 7, Content: "Those janitors offered her a ride home.", Destination: "Elwood" ) )
            
            appDelegate.currentUser.friends[1].treasures.append( Treasure(identifier: 8, Content: "Those carpenters saved her a seat.", Destination: "Toorak" ) )
            appDelegate.currentUser.friends[1].treasures.append( Treasure(identifier: 9, Content: "They read the children a story.", Destination: "Camberwell" ) )
            appDelegate.currentUser.friends[1].treasures.append( Treasure(identifier: 10, Content: "That barber lent her a lot of money.", Destination: "Footscray" ) )
            appDelegate.currentUser.friends[1].treasures.append( Treasure(identifier: 11, Content: "I sent him a package.", Destination: "Brunswick" ) )
            
            appDelegate.currentUser.friends[2].treasures.append( Treasure(identifier: 12, Content: "I save him a piece of pie.", Destination: "Geelong" ) )
            appDelegate.currentUser.friends[2].treasures.append( Treasure(identifier: 13, Content: "That manager orders her a new hat.", Destination: "Essendon" ) )
            appDelegate.currentUser.friends[2].treasures.append( Treasure(identifier: 14, Content: "I leave her some flowers.", Destination: "Burwood" ) )
            appDelegate.currentUser.friends[2].treasures.append( Treasure(identifier: 15, Content: "I struck him a heavy blow.", Destination: "Ivanhoe" ) )
            
            // set found treasure for user
            appDelegate.currentUser.foundTreasure = [5,10,15]
            
            // add current users treasures to found list
            for treas in appDelegate.currentUser.treasures {
                appDelegate.currentUser.foundTreasure.append(treas.getIdentity())
            }
        }
    }

}

