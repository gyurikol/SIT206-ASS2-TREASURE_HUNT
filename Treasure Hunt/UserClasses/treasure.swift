//
//  treasure.swift
//  Treasure Hunt
//
//  Created by George Kolecsanyi on 11/5/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import CoreData

// Treasure class that acts as the individual loaded resource of a user
class Treasure: NSObject, MKAnnotation {
    // Properties
    var title : String?
    var subTitle : String?
    var date: String?
    var img: UIImage = UIImage(named: "tc-S")!
    var coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    //Type - for content selection
    var content: String     // test content as string first
    
    // Treasure initializer
    init( Content : String )
    {
        content = Content
        
        super.init()
        
        date = getDate()   // set treasure date
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
    
    // get date as string
    func getDate() -> String {
        let date = Date()                   // set date
        let formatter = DateFormatter()     // set formatter
        
        formatter.dateFormat = "dd.MM.yyyy" // set date format
        
        return formatter.string(from: date) // return date string
    }
}
