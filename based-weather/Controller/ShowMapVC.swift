//
//  ShowMapVC.swift
//  based-weather
//
//  Created by Andrew Zah on 10/9/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import UIKit
import MapKit

class ShowMapVC: BaseVC, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    // Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // Variables
    let regionRadius: CLLocationDistance = 10000

    override func viewDidLoad() {
        super.viewDidLoad()
        let lpRec = UILongPressGestureRecognizer (target: self, action: #selector(foundLongPress))
        lpRec.minimumPressDuration = 2.0
        self.mapView.addGestureRecognizer(lpRec)
    }
    
    @objc func foundLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizerState.began { return }
        let touchLocation = sender.location(in: self.mapView)
        let locationCoordinate = self.mapView.convert(touchLocation, toCoordinateFrom: self.mapView)
       
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: "mapPin")
        
        if anView == nil {
            anView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "mapPin")
        }
        else {
            anView!.annotation = annotation
        }
        
        mapView.addSubview(anView!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else if CLLocationManager.authorizationStatus() == .denied {
            let initialLocation = CLLocation(latitude: 41.9741, longitude: -87.6514)
            centerMapOnLocation(location: initialLocation)
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
