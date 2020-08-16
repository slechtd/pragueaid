//
//  MapVC.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 15/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UITabBarController {
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    let regionMeters: Double = 500
    var permissionsGranted = false
    var trackingOn = false
    var fetchedLocations: [Target] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        configureVC()
        checkLocationServices()
        configureMapView()
        getTargets()
    }
    
    
    private func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            //checkLocationAuth()
        } else {
            //show allert
        }
    }
    
    
    private func checkLocationAuth(){
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            centerOnDefaultLocation()
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            //show allert
            centerOnDefaultLocation()
        case .denied:
            //show allert
            centerOnDefaultLocation()
        case .authorizedAlways:
            permissionsGranted = true
            mapView.showsUserLocation = true
            centerOnUserLocation()
        case .authorizedWhenInUse:
            permissionsGranted = true
            mapView.showsUserLocation = true
            centerOnUserLocation()
        @unknown default:
            centerOnUserLocation()
        }
    }
    
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    private func addAnnotations(){
        mapView.addAnnotations(fetchedLocations)
    }
    
    
    private func configureMapView(){
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        mapView.frame = view.bounds
        mapView.constrainToPrague()
    }
    
    
    private func centerOnDefaultLocation(){
        let location = CLLocationCoordinate2D(latitude: 50.0834225, longitude: 14.4241778)
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters*2)
        mapView.setRegion(region, animated: true)
    }
    
    
    private func centerOnUserLocation(){
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    private func getTargets(){
        NetworkManager.shared.getTargets() { result in
            switch result {
            case .success(let targets):
                self.fetchedLocations = targets.features.filter{$0.geometryType == "Point" && $0.country == "Česko"}
                DispatchQueue.main.async{self.addAnnotations()}
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func configureVC(){
        let centerToUserLocationButton = UIBarButtonItem(image: UIImage(systemName: SFSymbol.nav.rawValue), style: .plain, target: self, action: #selector(centerToUserLocationButtonPressed))
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: SFSymbol.setting.rawValue), style: .plain, target: self, action: #selector(SettingsButtonPressed))
        
        centerToUserLocationButton.tintColor = .systemRed
        settingsButton.tintColor = .systemRed
        
        navigationItem.rightBarButtonItem = centerToUserLocationButton
        navigationItem.leftBarButtonItem = settingsButton
    }
    
    
    @objc private func centerToUserLocationButtonPressed(){
        if permissionsGranted {
            centerOnUserLocation()
        } else {
            //show allert
            print("no persmissions")
        }
    }
    
    
    @objc private func SettingsButtonPressed(){
        
    }
    
}

//MARK: - extensions

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Target else { return nil }
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
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let location = view.annotation as? Target else { return }
        //let launchOptions = []
        print("YOOOO. \(String(describing: location.title))")
    }
}


extension MapVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuth()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        //show allert
    }
}

