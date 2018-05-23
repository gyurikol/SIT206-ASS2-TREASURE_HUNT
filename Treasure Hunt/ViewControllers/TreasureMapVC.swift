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
    @IBOutlet weak var treasureMap: MKMapView!          // UI for map
    @IBOutlet weak var buryTreasureButton: UIButton!    // Button to bury treasure
    
    // Variables
    var locationManager = CLLocationManager.init()      // initialize location manager
    var userCurrentLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ViewController is the delegate of the MKMapViewDelegate protocol
        treasureMap.delegate = self
        
    }
    
    // prior map processing before load
    override func viewWillAppear(_ animated: Bool) {
        
        // get currentUser from app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // annotate treasures from currentUser
        for user in appDelegate.userAnnotationsFocus {
            for i in 0...(user.treasures.count-1) {
                // if treasure focus index is set
                if appDelegate.treasureFocus != -1{
                    // if i is not equal to treasure focus
                    if i != appDelegate.treasureFocus {
                        continue    // continue iteration
                    }
                }
                treasureMap.addAnnotation( user.treasures[i] )  // add annotation to map
            }
        }
        
        // perform view load tasks for user location
        userLocationLoadTasks()
    }
    
    // when view disappears clear annotations and overlay
    override func viewDidDisappear(_ animated: Bool) {
        // clear map annotations
        let allAnnotations = self.treasureMap.annotations
        self.treasureMap.removeAnnotations(allAnnotations)
        
        // clear map overlays
        let allOverlays = self.treasureMap.overlays
        self.treasureMap.removeOverlays(allOverlays)
        
        // get currentUser from app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // clear treasure focus
        appDelegate.treasureFocus = -1
    }
    
    func userLocationLoadTasks() {
        // if location services enabled then reset location manager
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
        }
        
        // location manager configuration
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        // dispatch the update of location tasks to main thread
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    // location manager location change handler
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first  // get first location
        
        // set class level user current location
        userCurrentLocation = (location?.coordinate)!
        
        // print pointless test information
        print(location?.altitude as Any)
        print(location?.speed as Any)
        
        // re set show user location property
        self.treasureMap.showsUserLocation = true
        
        // handle span size dependant on all annotations
        self.treasureMap.showAnnotations(self.treasureMap.annotations, animated: false)
    }
    
    // when map is fully rendered add route path for treasure
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        // get currentUser from app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // if a treasure focus exists
        if appDelegate.treasureFocus != -1 {
            loadRoute(
                source:(treasureMap.annotations.first?.coordinate)!,
                destination:(treasureMap.annotations.last?.coordinate)!
            )
        }
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        // handle span size dependant on all annotations
        self.treasureMap.showAnnotations(self.treasureMap.annotations, animated: false)
    }
    
    func loadRoute( source:CLLocationCoordinate2D, destination:CLLocationCoordinate2D ) {
        // Create placemark objects containing the location's coordinates
        let sourcePlacemark = MKPlacemark(coordinate: source, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destination, addressDictionary: nil)
        
        // MKMapitems are used for routing. This class encapsulates information about a specific point on the map
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // The MKDirectionsRequest class is used to compute the route.
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // The route will be drawn using a polyline as a overlay view on top of the map. The region is set so both locations will be visible
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.treasureMap.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            // handle span size dependant on all annotations
            self.treasureMap.showAnnotations(self.treasureMap.annotations, animated: false)
        }
    }
    
    // render line for route
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 6.0
        renderer.lineDashPattern = [10,20]
        
        return renderer
    }
    
    // annotate treasure list handed to view controller
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationId = "viewForAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId)
        
        // if annotation is user location
        if annotation is MKUserLocation { return nil }  // leave untouched
        
        // if annotation is a user treasure
        if ((annotation as? Treasure) != nil) {
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationId)
                annotationView?.image = (annotation as? Treasure)?.img
                annotationView?.canShowCallout = true
                
                // three functions for treasure selection
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                annotationView?.detailCalloutAccessoryView = UIButton(type: .detailDisclosure)
                
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
        
        // just print error message
        print(errorMessage)
    }
}




