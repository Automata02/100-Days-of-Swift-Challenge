//
//  ViewController.swift
//  Project16
//
//  Created by Roberts Kursitis on 16/05/2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics", wikipediaUrl: "https://en.wikipedia.org/wiki/Oslo")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.", wikipediaUrl: "https://en.wikipedia.org/wiki/London")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light", wikipediaUrl: "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", wikipediaUrl: "https://en.wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", wikipediaUrl: "https://en.wikipedia.org/wiki/Washington,_D.C.")
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        let riga = Capital(title: "Riga", coordinate: CLLocationCoordinate2D(latitude: 56.946285, longitude: 24.105078), info: "Was founded in 1201.", wikipediaUrl: "https://en.wikipedia.org/wiki/Riga")
        mapView.addAnnotations([london, oslo, paris, rome, washington, riga])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map Type", style: .plain, target: self, action: #selector(changeMap))

    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        //Day 61 ch #1, does not work :(
        if let pinView = annotationView as? MKPinAnnotationView {
            pinView.pinTintColor = UIColor.systemBlue
        }
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        // Day 61 ch #3
        ac.addAction(UIAlertAction(title: "Wikipedia", style: .default, handler: { [weak self] _ in self?.wikipedia(url: capital.wikipediaUrl)}))
        present(ac, animated: true)
    }
    func wikipedia(url: String) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            vc.website = url
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    @objc func changeMap() {
        let ac = UIAlertController(title: "Select Map Type", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: mapTypes))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: mapTypes))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: mapTypes))
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        present(ac, animated: true)
    }
    func mapTypes(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        if actionTitle == "Standard" {
            title = "Normal🗺"
            mapView.mapType = .standard
        }
        else if actionTitle == "Hybrid" {
            title = "Hybrid🤖"
            mapView.mapType = .hybrid
        }
        else if actionTitle == "Satellite" {
            title = "Satellite🛰"
            mapView.mapType = .satellite
        } else { return }
    }
}

