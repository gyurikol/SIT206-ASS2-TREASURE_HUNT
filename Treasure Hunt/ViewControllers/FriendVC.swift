//
//  FriendVC.swift
//  Treasure Hunt
//
//  Created by George Kolecsanyi on 11/5/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import UIKit

class FriendVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // outlets
    @IBOutlet weak var friendTable: UITableView!
    
    var friendList: [User] = []
    
    var selectedFriend: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set friend table
        friendTable.delegate = self
        friendTable.dataSource = self
        
        // set currentUser friendlist from app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        friendList = appDelegate.currentUser.friends
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
    
    // set sections in table view to singular
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    // set table row count dependant on number of friends
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    
    // set cell definition and table population properties
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get next usable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)
        
        // get friend from cell row index value
        let friend = friendList[indexPath.row]
        
        // set text label to friend username
        cell.textLabel?.text = friend.person.username
        
        // set cell detail label to full name of friend
        cell.detailTextLabel?.text = "\(friend.person.firstname) \(friend.person.surname)"
        
        // set user image
        if friend.person.userImage == nil {
            cell.imageView?.image = UIImage(named: "no-img-S")
        } else {
            cell.imageView?.image = friend.person.userImage
        }
        
        // show disclosure indicator in row cell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // set selected friend to specified friend in list
        selectedFriend = friendList[indexPath.row]
        self.performSegue(withIdentifier: "showFriendProfile", sender: self)
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
        
        if segue.destination is ProfileVC
        {
            // send selected friend to profile view controller
            let vc = segue.destination as? ProfileVC
            vc?.user = selectedFriend
        }
    }

}
