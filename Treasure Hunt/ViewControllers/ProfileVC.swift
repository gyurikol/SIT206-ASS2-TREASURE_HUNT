//
//  TreasureResourceVC.swift
//  Treasure Hunt
//
//  Created by George Kolecsanyi on 11/5/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import UIKit

// Class where the table view will unpack the list of user sent and display appropriate sections and cells for the user and treasures
class ProfileVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // IBoutlets
    @IBOutlet weak var treasureView: UITableView!
    @IBOutlet weak var displayPicture: UIImageView!
    @IBOutlet weak var userFirstname: UILabel!
    @IBOutlet weak var userSurname: UILabel!
    @IBOutlet weak var userUsername: UILabel!
    
    var user: User?
    var treasureSelection: Int = -1     // treasure index in user treasure list
    
    // prepare array for table population
    var userUnfoundFound : [[Treasure]] = [[],[]]
    
    override func viewWillAppear(_ animated: Bool) {
        // deselect selected cell
        if let index = treasureView.indexPathForSelectedRow{
            treasureView.deselectRow(at: index, animated: false)
        }
        
        // reset the userUnfounFound array to view changes
        userUnfoundFound = [[],[]]
        
        // reference app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // for the assurance of reappearance post found treasure after segue
        // get found unfound treasures
        for tres in user!.treasures {
            if appDelegate.currentUser.foundTreasure.contains(tres.getIdentity()) && (user!.person != appDelegate.currentUser.person){
                userUnfoundFound[1].append(tres)
                continue
            }
            userUnfoundFound[0].append(tres)
        }
        
        // reload data
        self.treasureView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        treasureView.dataSource = self
        treasureView.delegate = self
        
        // set user details
        userFirstname.text = user!.person.firstname
        userSurname.text = user!.person.surname
        userUsername.text = user!.person.username
        
        // set user image
        if user!.person.userImage == nil {
            displayPicture.image = UIImage(named: "no-img-S")
        } else {
            displayPicture.image = user!.person.userImage
        }
        
        // reference app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // construct treasure map annotation based on user in focus
        appDelegate.userAnnotationsFocus = []
        appDelegate.userAnnotationsFocus.append( user! )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    // set sections in table view dependant on user count
    func numberOfSections(in tableView: UITableView) -> Int {
        // get currentUser from app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if(user!.person == appDelegate.currentUser.person) {
            return 1
        }
        return userUnfoundFound.count
    }
    
    // set table row count dependant on number of treasures in user
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // get currentUser from app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // if person is not current user
        if(user!.person != appDelegate.currentUser.person) {
            return userUnfoundFound[section].count
        }
        // if person is current user
        return user!.treasures.count
    }
    
    // set header for section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if(user!.person == appDelegate.currentUser.person)
        { return "Your Treasures" }
        else
        {
            if section == 1 {
                return "Found Treasures"
            }
            return "\(user!.person.username) Treasures"
        }
    }
    
    // set cell definition and table population properties
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get next usable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "treasureCell", for: indexPath)
        
        // get currentUser from app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // if user is me then treasure is known
        if(user!.person == appDelegate.currentUser.person) {
            user!.treasures[indexPath.row].img = UIImage(named: "tc-open-S")!
        }
        
        // get treasure from index path of section and row
        var treasure = userUnfoundFound[0][indexPath.row]
        if(user!.person != appDelegate.currentUser.person) {
            treasure = userUnfoundFound[indexPath.section][indexPath.row]
        }
        
        // set display image to treasure assigned image
        if indexPath.section == 1 {
            treasure.img = UIImage(named: "tc-open-S")!
        }
        
        if(user!.person != appDelegate.currentUser.person) {
            if appDelegate.currentUser.foundTreasure.contains(treasure.getIdentity()) {
                // set text label to treasure ????????
                cell.textLabel?.text = treasure.content
                
                // set cell detail label to treasure ????????
                cell.detailTextLabel?.text = treasure.content
            } else {
                // set text label to treasure content
                cell.textLabel?.text = "? ? ?"
                
                // set cell detail label to treasure content
                cell.detailTextLabel?.text = "? ? ?"
            }
        } else {
            // set text label to treasure ????????
            cell.textLabel?.text = treasure.content
            
            // set cell detail label to treasure ????????
            cell.detailTextLabel?.text = treasure.content
        }
        
        // set cell image
        cell.imageView?.image = treasure.img
        
        // show disclosure indicator in row cell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    // show friends treasures
    @IBAction func openFriendTreasureMap(_ sender: UIButton) {
        // segue to treasure map
        self.performSegue(withIdentifier: "treasureRouteSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // reference app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // set index of treasure to be focues
        appDelegate.treasureFocus = []
        appDelegate.treasureFocus.append(userUnfoundFound[indexPath.section][indexPath.row])
        
        // segue to treasure map
        self.performSegue(withIdentifier: "treasureRouteSegue", sender: self)
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
