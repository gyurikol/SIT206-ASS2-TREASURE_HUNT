//
//  SettingsVC.swift
//  Treasure Hunt
//
//  Created by George Kolecsanyi on 11/5/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    // outlets
    @IBOutlet weak var bgMusicSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "scroll-texture")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // reference app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appDelegate.bgMusicPlaying == true {
            bgMusicSwitch.isOn = true
        } else {
            bgMusicSwitch.isOn = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // change background music state
    @IBAction func bgMusicState(_ sender: UISwitch) {
        // reference app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if sender.isOn {
            // turn background music on
            SKTAudio.sharedInstance().playBackgroundMusic()
            appDelegate.bgMusicPlaying = true
        } else {
            // turn background music off
            SKTAudio.sharedInstance().pauseBackgroundMusic()
            appDelegate.bgMusicPlaying = false
        }
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
