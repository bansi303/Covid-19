//
//  MapViewController.swift
//  Weather
//
//  Created by Student on 2020-04-08.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var covidData:CovidData?
    var closetCoutryData: CovidCountryWiseData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomToUserLocation()
    }
    
    @IBAction func onBackBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func zoomToUserLocation() {
        let closestCoutryCordinate = CLLocationCoordinate2D(latitude: closetCoutryData.lat, longitude: closetCoutryData.long)
        let region = MKCoordinateRegion(center: closestCoutryCordinate, latitudinalMeters: 2600000, longitudinalMeters: 2600000)
        mapView.isZoomEnabled = false
        mapView.delegate = self
        mapView.setRegion(region, animated: true)
        
        for i in 0..<(covidData?.areas.count)!{
            let coutryCordinate = CLLocationCoordinate2D(latitude: (covidData?.areas[i].lat)!, longitude: (covidData?.areas[i].long)!)
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: coutryCordinate.latitude, longitude: coutryCordinate.longitude)
            annotation.title = covidData?.areas[i].displayName
            annotation.subtitle = "Confirmed: \(covidData!.areas[i].totalConfirmed ?? 0)"
            mapView.addAnnotation(annotation)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage.init(named: "MapPin")
        return annotationView
    }
}
