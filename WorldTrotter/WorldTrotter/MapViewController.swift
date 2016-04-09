//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Ivan Cai on 1/28/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate{
    
    var mapView: MKMapView!
    var manager: CLLocationManager!
    override func loadView() {
        mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MKUserTrackingMode.FollowWithHeading
        manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        let pinFuzhou = MKPointAnnotation()
        pinFuzhou.coordinate = CLLocationCoordinate2DMake(26.0613900	, 119.3061100)
        pinFuzhou.title = "Fuzhou"
        mapView.addAnnotation(pinFuzhou)
        view = mapView
        let standardString = NSLocalizedString("Standard", comment: "Standard type map")
        let hybirdString = NSLocalizedString("Hybrid", comment: "Hybrid type map")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite type map")
        let segmentedControl = UISegmentedControl(items: [standardString,hybirdString,satelliteString])
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: "mapTypeChanged:", forControlEvents: .ValueChanged)
        let switchPin = UIButton()
        switchPin.addTarget(self, action: "switchPin:", forControlEvents: .TouchUpInside)
        switchPin.setTitle("Show Pins", forState: .Normal)
        switchPin.setTitleColor(UIColor.blueColor(), forState: .Normal)
        switchPin.frame = CGRectMake(15, 50, 300, 500)
        view.addSubview(segmentedControl)
        //view.addSubview(switchPin)
        
        let bottomConstraint = segmentedControl.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor, constant: -24)
        //let topConstraint = segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        bottomConstraint.active = true
        leadingConstraint.active = true
        trailingConstraint.active = true
    }
    func mapTypeChanged(segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex{
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 2:
            mapView.mapType = .Satellite
        default:
            break
        }
    }
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.coordinate
    }
    func switchPin(button: UIButton){
        
    }
}
