//
//  TreasureMapVC.swift
//  Treasure Hunt
//
//  Created by George Kolecsanyi on 11/5/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import UIKit
import MapKit           // map ui module
import CoreLocation     // user location module

class TreasureMapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // Outlets
    @IBOutlet weak var treasureMap: MKMapView!      // UI for map
    
    // Variables
    var currentUser: User!
    var locationManager = CLLocationManager.init()      // initialize location manager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ViewController and Map Load Config
        treasureMap.delegate = self
        
        // get currentUser from app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        currentUser = appDelegate.currentUser
        
        // annotate treasures from currentUser
        for res in currentUser.treasures {
            treasureMap.addAnnotation( res ) // test map annotation
        }
        
        // perform view load tasks for user location
        userLocationLoadTasks()
    }
    
    func userLocationLoadTasks() {
        // if location services enabled then reset location manager
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
        }
        
        // location manager configuration
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        // zoom to user location
        let noLocation = CLLocationCoordinate2D()
        let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 10000000, 10000000)
        treasureMap.setRegion(viewRegion, animated: false)
        
        // dispatch the update of location tasks to main thread
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    // location manager location change handler
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first  // get first location
        
        // prepare coording and view region for Map UI
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        // set region to the treasure map
        treasureMap.setRegion(region, animated: true)
        
        // print pointless test information
        print(location?.altitude as Any)
        print(location?.speed as Any)
        
        // re set show user location property
        self.treasureMap.showsUserLocation = true
    }
    
    // annotate treasure list handed to view controller
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationId = "viewForAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId)
        if ((annotation as? Treasure) != nil) {
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationId)
                annotationView?.image = (annotation as? Treasure)?.img
                annotationView?.canShowCallout = true
                
                // three functions for treasure selection
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                annotationView?.detailCalloutAccessoryView = UIButton(type: .detailDisclosure)
                annotationView?.leftCalloutAccessoryView = UIButton(type: .detailDisclosure)
                
            }
            else { annotationView?.annotation = annotation }
        }
        return annotationView
    }
    
    // handle treasure/annotation click
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("mapview something happened")
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
    
    // location manager error handling
    private func locationManager(_ manager: CLLocationManager, didFailWithError error: NSError) {
        var errorMessage : String = "Unhandled Error"
        
        if error.code == CLError.locationUnknown.rawValue {     // cant get location
            errorMessage = "CLLocation Manager unable to retrieve location"
        }
        else if error.code == CLError.network.rawValue {        // cant connect to network
            errorMessage = "Network unavailable to retrive location"
        }
        else if error.code == CLError.denied.rawValue {         // location service denied
            errorMessage = "CLLocation Manager does not have permission to retrive location"
            locationManager.stopUpdatingLocation()
        }
        
        print(errorMessage)
    }
}






