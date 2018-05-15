//
//  FriendVC.swift
//  Treasure Hunt
//
//  Created by George Kolecsanyi on 11/5/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import UIKit

class FriendVC: UITableViewController {

    var friendList: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // set currentUser friendlist from app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        friendList = appDelegate.currentUser.friends
    }
    
    // set sections in table view to singular
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    // set table row count dependant on number of friends
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    
    // set cell definition and table population properties
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get next usable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)
        
        // get friend from cell row index value
        let friend = friendList[indexPath.row]
        
        // set text label to friend username
        cell.textLabel?.text = friend.person.username
        
        // set cell detail label to full name of friend
        cell.detailTextLabel?.text = "\(friend.person.firstname) \(friend.person.surname)"
        
        // set no display image for friend user
        cell.imageView?.image = UIImage(named: "no-img-S")
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
