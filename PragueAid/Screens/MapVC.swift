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

class MapVC: UIViewController {
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    let regionMeters: Double = 500
    
    
    var permissionsGranted = false
    var inPrague = true
    var filterSettings: FilterSettings?
    var fetchedLocations: [Target] = []
    var filteredLocations: [Target] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        checkLocationServices()
        configureMapView()
        loadFilterSettingsFromPersistance()
        getTargets()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadAnnotations()
    }

    
    private func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            resolveAuthStatus()
        } else {
            centerOnDefaultLocation()
            self.presentAlert(message: .noPermissionsExplanation, title: .noPermissions) //mozná zbytečné?
        }
    }
    
    
    func resolveAuthStatus(){
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
        NetworkManager.shared.getTargets() { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let targets):
                self.fetchedLocations = targets.features.filter{$0.geometryType == "Point" && $0.country == "Česko"}
                self.filterAndAddlocations()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func filterAndAddlocations(){
        if let filterSettings = filterSettings {
            filteredLocations = fetchedLocations
            if filterSettings.pharmacies == false { filteredLocations.removeAll(where: {$0.targetTypeGroup == .pharmacies}) }
            if filterSettings.medicalInstitutions == false { filteredLocations.removeAll(where: {$0.targetTypeGroup == .healthCare}) }
            DispatchQueue.main.async{self.mapView.addAnnotations(self.filteredLocations)}
        } else {
            DispatchQueue.main.async{self.mapView.addAnnotations(self.fetchedLocations)}
        }
    }
    
    
    private func loadFilterSettingsFromPersistance(){
        PersistanceManager.shared.loadFilterSettingsFromPersistance(completed: {result in
            switch result {
            case .success(let loadedFilterSettings):
                self.filterSettings = loadedFilterSettings
            case .failure(let error):
                self.presentErrorAlert(for: error)
            }
        })
    }
    
    
    private func reloadAnnotations(){
        loadFilterSettingsFromPersistance()
        DispatchQueue.main.async{self.mapView.removeAnnotations(self.fetchedLocations)}
        filterAndAddlocations()
    }
    
    
    private func configureMapView(){
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        mapView.constrainToPrague()
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureVC(){
        view.backgroundColor = .systemBackground
        let centerToUserLocationButton = UIBarButtonItem(image: UIImage(systemName: SFSymbol.nav.rawValue), style: .plain, target: self, action: #selector(centerToUserLocationButtonPressed))
        centerToUserLocationButton.tintColor = .systemRed
        navigationItem.rightBarButtonItem = centerToUserLocationButton
    }
    
    
    @objc private func centerToUserLocationButtonPressed(){
        if permissionsGranted {
            if inPrague { centerOnUserLocation() } else {self.presentAlert(message: .notInPrague)}
        } else {
            self.presentAlert(message: .thisFeature, title: .noPermissions)
        }
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
            view.tintColor = .systemRed
        }
        return view
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let target = view.annotation as? Target else { return }
        presentTargetVC(target: target)
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //guard let target = view.annotation as? Target else { return }
        //presentTargetVC(target: target)
    }
}


extension MapVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        resolveAuthStatus()

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error.localizedDescription)
        }
    }
}


