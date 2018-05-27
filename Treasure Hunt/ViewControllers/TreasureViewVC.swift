//
//  TreasureViewVC.swift
//  Treasure Hunt
//
//  Created by George Kolecsanyi on 27/5/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import UIKit
import MapKit

class TreasureViewVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    // outlets
    @IBOutlet weak var treasureMapView: MKMapView!
    @IBOutlet weak var treasureContentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // properties
    var treasurePreview : Treasure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "scroll-texture")!)
        treasureContentView.backgroundColor = .clear

        // Do any additional setup after loading the view.
        
        treasureMapView.delegate = self
    }
    
    // annotate treasure with icon
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationId = "viewForAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId)
        
        // if annotation is treasure
        if ((annotation as? Treasure) != nil) {
            // and not nil
            if annotationView == nil {
                // set annotation configuration
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationId)
                annotationView?.canShowCallout = false
                annotationView?.image = (annotation as? Treasure)?.img  // load treasure icon
            }
            else { annotationView?.annotation = annotation }
        }
        return annotationView   // return customized view
    }
    
    // when map finished rendering zoom to location
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        treasureMapView.showAnnotations(self.treasureMapView.annotations, animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        if treasurePreview != nil {
            treasureMapView.addAnnotation( treasurePreview! )
        
            nameLabel.text = (treasurePreview?.parent?.person.firstname)! + " " + (treasurePreview?.parent?.person.surname)!
            
            // create label and add content to content viewer
            let inputText = UITextView(frame: CGRect(x: 0.0, y: 0.0, width: treasureContentView.frame.width, height: treasureContentView.frame.height))
            inputText.backgroundColor = .clear
            inputText.text = treasurePreview?.content
            inputText.font = UIFont.systemFont(ofSize: 25)
            treasureContentView.addSubview(inputText)
        }
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
