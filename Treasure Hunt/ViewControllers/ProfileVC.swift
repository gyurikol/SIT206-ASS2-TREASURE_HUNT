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
    
    override func viewWillAppear(_ animated: Bool) {
        // deselect selected cell
        if let index = treasureView.indexPathForSelectedRow{
            treasureView.deselectRow(at: index, animated: false)
        }
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
    
    // set sections in table view dependant on user count
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    // set table row count dependant on number of treasures in user
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user!.treasures.count
    }
    
    // set header for section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if(user!.person == appDelegate.currentUser.person) { return "Your Treasures" }
        else
        { return "\(user!.person.username) Treasures" }
    }
    
    // set cell definition and table population properties
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get next usable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "treasureCell", for: indexPath)
        
        // get treasure from index path of section and row
        let treasure = user!.treasures[indexPath.row]
        
        // set text label to treasure ????????
        cell.textLabel?.text = treasure.content
        
        // set cell detail label to treasure ????????
        cell.detailTextLabel?.text = treasure.content
        
        // set display image to treasure assigned image
        cell.imageView?.image = treasure.img
        
        // show disclosure indicator in row cell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // reference app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // set index of treasure to be focues
        appDelegate.treasureFocus = indexPath.row
        
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
