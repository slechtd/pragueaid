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
    var fetchedLocations: [Location] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        configureVC()
        checkLocationServices()
        configureMapView()
        getAllLocations()
    }
    
    
    private func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuth()
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
            break
        case .authorizedWhenInUse:
            permissionsGranted = true
            mapView.showsUserLocation = true
            centerOnUserLocation()
            //locationManager.startUpdatingLocation()
        @unknown default:
            centerOnDefaultLocation()
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
        //mapView.constrainToPrague()
    }
    
    
    private func centerOnDefaultLocation(){
        let location = CLLocationCoordinate2D(latitude: 50.0834225, longitude: 14.4241778)
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
        mapView.setRegion(region, animated: true)
    }
    
    
    private func centerOnUserLocation(){
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    private func getAllLocations(){
        NetworkManager.shared.getAllLocations { result in
            switch result {
            case .success(let result):
                self.fetchedLocations = result.features.filter{$0.geometryType == "Point" && $0.country == "Česko"}
                DispatchQueue.main.async{self.addAnnotations()}
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func configureVC(){
        let centerToUserLocationButton = UIBarButtonItem(image: UIImage(systemName: SFSymbol.nav.rawValue), style: .plain, target: self, action: #selector(trackUserLocationButtonPressed))
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: SFSymbol.setting.rawValue), style: .plain, target: self, action: #selector(SettingsButtonPressed))
        centerToUserLocationButton.tintColor = .systemRed
        settingsButton.tintColor = .systemRed
        navigationItem.rightBarButtonItem = centerToUserLocationButton
        navigationItem.leftBarButtonItem = settingsButton
    }
    
    
    @objc private func trackUserLocationButtonPressed(){
        if permissionsGranted {
            locationManager.startUpdatingLocation()
        } else {
            //show allert
        }
    }
    
    
    @objc private func SettingsButtonPressed(){
        
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
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let location = view.annotation as? Location else { return }
        //let launchOptions = []
        print("YOOOO. \(String(describing: location.title))")
    }
}


extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
        mapView.setRegion(region, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

