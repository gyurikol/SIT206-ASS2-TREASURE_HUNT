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
    var locationManager = LocationService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ViewController and Map Load Config
        treasureMap.delegate = self
        treasureMap.showsUserLocation = true
        
        // get currentUser from app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        currentUser = appDelegate.currentUser
        
        // annotate treasures from currentUser
        for res in currentUser.treasures {
            treasureMap.addAnnotation( res ) // test map annotation
        }
        
        // Location manager configuration
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = LocationService.shared
            //locationManager = CLLocationManager()
            //locationManager.delegate = self
            //locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //locationManager.requestAlwaysAuthorization()
            //locationManager.requestWhenInUseAuthorization()
        }
        //locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.startUpdatingLocation()
        }
        //Zoom to user location
        let noLocation = CLLocationCoordinate2D()
        let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 10000000, 10000000)
        treasureMap.setRegion(viewRegion, animated: false)
        
        DispatchQueue.main.async {
            //self.locationManager.startUpdatingLocation()
        }
    }
    
    // location change handler
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        treasureMap.setRegion(region, animated: true)
        
        print(location?.altitude as Any)
        print(location?.speed as Any)
        
        self.treasureMap.showsUserLocation = true
    }
    
    // annotate
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

}

class LocationService : NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager.init()
    static let shared: LocationService = LocationService()
    
    override private init() {
        super.init()
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.desiredAccuracy = 100 // meters
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // location manager location change handler
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        treasureMap.setRegion(region, animated: true)
        
        print(location?.altitude as Any)
        print(location?.speed as Any)
        
        self.treasureMap.showsUserLocation = true
    }
    
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






