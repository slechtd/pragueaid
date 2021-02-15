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
            mapView.centerOnDefaultLocation()
            self.presentAlert(message: .noPermissionsExplanation, title: .noPermissions) //mozná zbytečné?
        }
    }
    
    
    func resolveAuthStatus(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                mapView.centerOnDefaultLocation()
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                self.presentAlert(message: .noPermissionsExplanation, title: .restrictedPermissions)
                mapView.centerOnDefaultLocation()
            case .denied:
                self.presentAlert(message: .noPermissionsExplanation, title: .noPermissions)
                mapView.centerOnDefaultLocation()
            case .authorizedAlways:
                permissionsGranted = true
                inPrague = mapView.checkIfInPrague()
            case .authorizedWhenInUse:
                permissionsGranted = true
                inPrague = mapView.checkIfInPrague()
            @unknown default:
                mapView.centerOnDefaultLocation()
                
            }
        }
    }
    
    
    private func getTargets(){
        if NetworkMonitor.shared.isCoonnected == true {
            downloadTargets()
            filterAndAddlocations()
        } else {
            loadTargetsFromPersistance()
            if !fetchedLocations.isEmpty {
                filterAndAddlocations()
            } else {
                self.presentAlert(message: AlertMessages.noInternet, title: AlertMessages.connection)
            }
        }
    }
    
    
    private func downloadTargets(){
        showLoadingView()
        NetworkManager.shared.getTargets() { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let targets):
                self.fetchedLocations = targets.features.filter{$0.geometryType == "Point" && $0.country == "Česko"}
                self.saveTargetsToPersistance()
                self.reloadAnnotations()
                self.dismissLoadingView()
            case .failure(let error):
                self.presentErrorAlert(for: error)
            }
        }
    }
    
    
    private func saveTargetsToPersistance(){
        let result = PersistanceManager.shared.saveTargetsToPersistance(targets: fetchedLocations)
        if result != nil { self.presentErrorAlert(for: result!) }
    }
    
    
    private func loadTargetsFromPersistance(){
        PersistanceManager.shared.loadTargetsFromPersistance(completed: {result in
            switch result {
            case .success(let loadedTargets):
                self.fetchedLocations = loadedTargets
                self.reloadAnnotations()
            case .failure(let error):
                self.presentErrorAlert(for: error)
            }
        })
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
            if inPrague { mapView.centerOnUserLocation() } else {self.presentAlert(message: .notInPrague)}
        } else {
            self.presentAlert(message: .thisFeature, title: .noPermissions)
        }
    }
    
    
    private func presentTargetVC(target: Target){
        let destVC = TargetVC(target: target)
        let navControler = UINavigationController(rootViewController: destVC)
        present(navControler, animated: true)
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
        guard let target = view.annotation as? Target else { return }
        presentTargetVC(target: target)
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


