//
//  MapViewController.swift
//  AppLabs
//
//  Created by test on 08/01/2018.
//  Copyright © 2018 Grey. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    let userAnnotation = "userLocation"
    
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .standard
        view.isZoomEnabled = true
        view.isScrollEnabled = true
        view.showsUserLocation = true
        return view
    }()
    
    lazy var homePinView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var locationManager: CLLocationManager?
    
    let distanceSpan = 2000.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView.delegate = self
        mapView.frame = self.view.bounds
        mapView.center = view.center
        
        view.addSubview(homePinView)
        NSLayoutConstraint.activate([
            homePinView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homePinView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            homePinView.widthAnchor.constraint(equalToConstant: 30),
            homePinView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        homePinView.layer.cornerRadius = 15
        homePinView.layer.borderWidth = 1
        homePinView.layer.borderColor = UIColor.black.cgColor
        
        setupLocationManager()
    }
    // AIzaSyDYlmSbgbayRP_nWIfcf31gAnjwoLfDokM
    private func setupLocationManager() {
        self.locationManager = CLLocationManager()
        if let locationManager = self.locationManager {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let coordinate = mapView.convert(homePinView.frame.origin, toCoordinateFrom: view)
        print("\(coordinate.latitude) \(coordinate.longitude)")
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, distanceSpan, distanceSpan)
        mapView.setRegion(region, animated: true)
    }
}
