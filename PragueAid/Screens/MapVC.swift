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
    var inPrague = true
    var fetchedLocations: [Target] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        checkLocationServices()
        configureMapView()
        getTargets()
    }
    
    
    private func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            centerOnDefaultLocation()
            self.presentAlert(message: .noPermissionsExplanation, title: .noPermissions)
        }
    }
    
    
    private func setupAccordingToDistanceFromPrague(){
        let prague = CLLocation(latitude: 50.0834225, longitude: 14.4241778)
        guard let distance = locationManager.location?.distance(from: prague) else {
            centerOnDefaultLocation()
            self.presentAlert(message: .noUserlocation)
            return
        }
        if distance < 30000 {
            centerOnUserLocation()
            mapView.showsUserLocation = true
            inPrague = true
        } else {
            centerOnDefaultLocation()
            mapView.showsUserLocation = false
            inPrague = false
        }
    }
    
    
    private func getTargets(){
        NetworkManager.shared.getTargets() { result in
            switch result {
            case .success(let targets):
                self.fetchedLocations = targets.features.filter{$0.geometryType == "Point" && $0.country == "Česko"}
                DispatchQueue.main.async{self.mapView.addAnnotations(self.fetchedLocations)}
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func configureMapView(){
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        mapView.frame = view.bounds
        mapView.constrainToPrague()
    }
    
    private func configureVC(){
        let centerToUserLocationButton = UIBarButtonItem(image: UIImage(systemName: SFSymbol.nav.rawValue), style: .plain, target: self, action: #selector(centerToUserLocationButtonPressed))
        let filterButtom = UIBarButtonItem(image: UIImage(systemName: SFSymbol.setting.rawValue), style: .plain, target: self, action: #selector(filterButtonPressed))
        
        centerToUserLocationButton.tintColor = .systemRed
        filterButtom.tintColor = .systemRed
        
        navigationItem.rightBarButtonItem = centerToUserLocationButton
        navigationItem.leftBarButtonItem = filterButtom
    }
    
    
    @objc private func centerToUserLocationButtonPressed(){
        if permissionsGranted {
            if inPrague { centerOnUserLocation() } else {self.presentAlert(message: .notInPrague)}
        } else {
            self.presentAlert(message: .thisFeature, title: .noPermissions)
        }
    }
    
    
    @objc private func filterButtonPressed(){
    }
    
    
    private func presentTargetVC(target: Target){
        let destVC = TargetVC(target: target)
        let navControler = UINavigationController(rootViewController: destVC)
        present(navControler, animated: true)
    }
    
    
    private func centerOnDefaultLocation(){
        let location = CLLocationCoordinate2D(latitude: 50.0834225, longitude: 14.4241778)
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters*2)
        mapView.setRegion(region, animated: true)
    }
    
    
    private func centerOnUserLocation(){
        if let userLocation = locationManager.location?.coordinate {
            let userRegion = MKCoordinateRegion.init(center: userLocation, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
            mapView.setRegion(userRegion, animated: true)
        }
    }
    
}

//MARK: - extensions

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Target else { return nil }
        let identifier = "target"
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
        guard let target = view.annotation as? Target else { return }
        presentTargetVC(target: target)
    }
    
    
}


extension MapVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                centerOnDefaultLocation()
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                self.presentAlert(message: .noPermissionsExplanation, title: .restrictedPermissions)
                centerOnDefaultLocation()
            case .denied:
                self.presentAlert(message: .noPermissionsExplanation, title: .noPermissions)
                centerOnDefaultLocation()
            case .authorizedAlways:
                permissionsGranted = true
                setupAccordingToDistanceFromPrague()
            case .authorizedWhenInUse:
                permissionsGranted = true
                setupAccordingToDistanceFromPrague()
            @unknown default:
                centerOnDefaultLocation()
                
            }
        }
        
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error.localizedDescription)
        }
    }
}
