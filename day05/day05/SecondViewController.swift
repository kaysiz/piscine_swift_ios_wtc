//
//  SecondViewController.swift
//  day05
//
//  Created by kudakwashe on 2019/10/16.
//  Copyright © 2019 WeThinkCode. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager();
    var pinAnnotationView: MKAnnotationView?;
    
    private func mapInit() {
        snapToListLocation(Locations[0], locationName: Locations[0].name)
    }
    
    private func locationManagerInit() {
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization();
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager.distanceFilter = 10;
        locationManager.startUpdatingLocation();
    }
    
    private func addAnnotaions() {
        for pinData in Locations {
            let pin = MKPointAnnotation();
            pin.coordinate = CLLocationCoordinate2D(latitude: pinData.latitude, longitude: pinData.longitude);
            pin.title = pinData.name;
            pin.subtitle = pinData.information;
            mapView.addAnnotation(pin);
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManagerInit();
        self.mapInit();
        self.addAnnotaions();
    }

    
    var actualLocationName: String? {
        didSet {
            for locationData in Locations {
                if (locationData.name == actualLocationName) {
                    let center = CLLocationCoordinate2D(latitude: locationData.latitude, longitude: locationData.longitude);
                    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01));
                    mapView.setRegion(region, animated: false);
                }
            }
        }
    }
    
    func locateMe(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        manager.stopUpdatingLocation()
        
        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.2,longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: coordinations, span: span)
        
        mapView.setRegion(region, animated: true)
        
    }
    
    @IBAction func mapType(_ sender: UISegmentedControl) {
        switch sender.titleForSegment(at: sender.selectedSegmentIndex)! {
        case "Standard":
            mapView.mapType = MKMapType.standard;
        case "Satellite":
            mapView.mapType = MKMapType.satellite;
        case "Hybrid":
            mapView.mapType = MKMapType.hybrid;
        default:
            break;
        }
    }
    @IBAction func currentLocation(_ sender: UIButton) {
        snapToListLocation(Locations[1], locationName: Locations[1].name)
    }
    
    func snapToListLocation(_ location: Location, locationName: String) {
        print(locationName);
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude);
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01));
        mapView.setRegion(region, animated: false);
        mapView.showsCompass = true;
        mapView.showsScale = true;
        mapView.showsUserLocation = true;
    }
    
}

