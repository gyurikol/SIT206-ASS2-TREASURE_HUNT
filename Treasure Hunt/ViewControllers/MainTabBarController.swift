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
        
        // get currentUser from app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // TESTING - Add Custom Default User for startup
        appDelegate.currentUser.treasures.append( Treasure(Content: "testing 1 2 3", Destination: "Melbourne" ) )
        appDelegate.currentUser.friends.append( User(details: PersonDetails(UserID: "a", UserName: "testa", FirstName: "testa", Surname: "testa", eMail: "testa@test.com") ) )
        appDelegate.currentUser.friends.append( User(details: PersonDetails(UserID: "b", UserName: "testb", FirstName: "testb", Surname: "testb", eMail: "testb@test.com") ) )
        appDelegate.currentUser.friends.append( User(details: PersonDetails(UserID: "c", UserName: "testc", FirstName: "testc", Surname: "testc", eMail: "testc@test.com") ) )
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
