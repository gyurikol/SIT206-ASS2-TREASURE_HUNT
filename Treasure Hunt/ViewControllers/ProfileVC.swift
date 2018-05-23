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
    
    var userList: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        treasureView.dataSource = self
        treasureView.delegate = self
    }
    
    // set sections in table view dependant on user count
    func numberOfSections(in tableView: UITableView) -> Int { return userList.count }
    
    // set table row count dependant on number of treasures in user
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList[section].treasures.count
    }
    
    // set header for section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if(userList[section].person == appDelegate.currentUser.person) { return "Your Treasures" }
        else
        { return "\(userList[section].person.username) Treasures" }
    }
    
    // set cell definition and table population properties
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get next usable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "treasureCell", for: indexPath)
        
        // get treasure from index path of section and row
        let treasure = userList[indexPath.section].treasures[indexPath.row]
        
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
