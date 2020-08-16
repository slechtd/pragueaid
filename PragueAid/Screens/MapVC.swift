//
//  MapVC.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 15/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UITabBarController {
    
    let mapView = MKMapView()
    var locations: [Location] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        configureMapView()
        setInitialLocation()
        getAllLocations()

    }
    
    
    func addAnnotations(){
        mapView.addAnnotations(locations)
    }
    
    
    private func configureMapView(){
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        mapView.frame = view.bounds
        mapView.constrainToPrague()
    }
    
    
    private func setInitialLocation(){
        let initialLocation = CLLocation(latitude: 50.0834225, longitude: 14.4241778)
        mapView.centerToLocation(location: initialLocation)
    }
    
    
    private func getAllLocations(){
        NetworkManager.shared.getAllLocations { result in
            switch result {
            case .success(let result):
                self.locations = result.features
                DispatchQueue.main.async{self.addAnnotations()}
            case .failure(let error):
                print(error)
            }
        }
    }

}

//MARK: - extensions

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Location else { return nil }
        let identifier = "location"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}

