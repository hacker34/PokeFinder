//
//  ViewController.swift
//  PokeFinder
//
//  Created by Johnny Hacking on 3/4/17.
//  Copyright © 2017 HackingInnovations. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    //********Boiler Plate for Maps ****************
    let locationManager = CLLocationManager()
    var mapHasCenteredOnce = false
    //**********************************************
    //********Geofire Install variable *************
    var geoFire: GeoFire!
    //**********************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //***Boiler Plate for Maps ***************
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        //****************************************
    }
    //*******Boiler Plate for Maps ****************
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        // Important to note that is only using location when app is in use not always!
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            mapView.showsUserLocation = true
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            mapView.showsUserLocation = true
        }
    }
    
    //This funciton would be used like with a button to recenter the map to basic location and zoom
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        // Map will only update the first time app is open, that way it allows user to pan map to look for other things
        if let loc = userLocation.location{
            if !mapHasCenteredOnce{
                centerMapOnLocation(location: loc)
                mapHasCenteredOnce = true
            }
        }
    }
    
    //This function creates a custom annotation for the user on the map vrs just the blue dot!
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView: MKAnnotationView?
        
        if annotation.isKind(of: MKUserLocation.self) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView?.image = UIImage(named:"ash")
        }
        
        return annotationView
    }
    
    //********************************************

    @IBAction func spotRandomPokemon(_ sender: UIButton) {
        
    }


}

