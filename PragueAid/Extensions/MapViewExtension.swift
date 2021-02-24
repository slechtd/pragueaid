//
//  MapViewExtension.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 15/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {    
    
    
    func constrainToPrague(){
        let pragueCenter = CLLocation(latitude: 50.0834225, longitude: 14.4241778)
        self.setCameraBoundary(CameraBoundary(coordinateRegion: MKCoordinateRegion(center: pragueCenter.coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)), animated: true)
        let zoomRange = CameraZoomRange(maxCenterCoordinateDistance: 70000)
        self.setCameraZoomRange(zoomRange, animated: true)
    }
    
    
    func centerOnDefaultLocation(){
        let regionMeters: Double = 500
        let location = CLLocationCoordinate2D(latitude: 50.0834225, longitude: 14.4241778)
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters*2)
        self.setRegion(region, animated: true)
    }
    
    
    func centerOnUserLocation(){
        let regionMeters: Double = 500
        let locationManager = CLLocationManager()
        if let userLocation = locationManager.location?.coordinate {
            let userRegion = MKCoordinateRegion.init(center: userLocation, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
            self.setRegion(userRegion, animated: true)
        }
    }
    
    
    //Checks whether user is in Prague and centers to their location. Alternativelly when user is not in Prague, the MapView is centered to a default location.
    func checkIfInPrague() -> Bool {
        let locationManager = CLLocationManager()
        let prague = CLLocation(latitude: 50.0834225, longitude: 14.4241778)
        guard let distance = locationManager.location?.distance(from: prague) else {
            self.centerOnDefaultLocation()
            print("Error: No user location!")
            return false
        }
        if distance < 30000 {
            self.centerOnUserLocation()
            self.showsUserLocation = true
            return true
        } else {
            self.centerOnDefaultLocation()
            self.showsUserLocation = false
            return false
        }
    }
}

