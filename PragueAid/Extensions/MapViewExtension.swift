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
        self.setCameraBoundary(CameraBoundary(coordinateRegion: MKCoordinateRegion(center: pragueCenter.coordinate, latitudinalMeters: 25000, longitudinalMeters: 50000)), animated: true)
        let zoomRange = CameraZoomRange(maxCenterCoordinateDistance: 75000)
        self.setCameraZoomRange(zoomRange, animated: true)
    }
    
    
}

