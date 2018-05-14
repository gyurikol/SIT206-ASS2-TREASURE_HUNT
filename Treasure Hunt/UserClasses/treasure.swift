//
//  treasure.swift
//  Treasure Hunt
//
//  Created by George Kolecsanyi on 11/5/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import CoreData

// Treasure class that acts as the individual loaded resource of a user
class Treasure: NSObject, MKAnnotation {
    // Properties
    var title : String?
    var subTitle : String?
    var coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    //Type - for content selection
    var date: String
    var content: String     // test content as string first
    
    // Treasure initializer
    init(_ Content : String, _ Date : String )
    {
        self.content = Content
        self.date = Date
        
        super.init()
        updateTripData()
    }
    
    func updateTripData() {
        title = "Random Title"
        subTitle = date
        getLocationFromDestination()
    }
    func getLocationFromDestination() {
        CLGeocoder().geocodeAddressString("Melbourne") {
            (placemarks, error) in
            let placemark = placemarks?.first
            self.coordinate = (placemark?.location?.coordinate)!
        }
    }
}
