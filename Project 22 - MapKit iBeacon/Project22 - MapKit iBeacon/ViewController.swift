//
//  ViewController.swift
//  Project22 - MapKit iBeacon
//
//  Created by Roberts Kursitis on 15/06/2022.
//
import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var distanceReading: UILabel!
    @IBOutlet var beaconName: UILabel!
    
    var locationManager: CLLocationManager?
    var vibeCheck: Bool =  true
    var currentBeaconUuid: UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
        beaconName.text = "Beacon Not Found"
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    func startScanning() {
        addBeaconRegion(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5", major: 123, minor: 456, identifier: "Macbook")
        addBeaconRegion(uuidString: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", major: 123, minor: 456, identifier: "🤠")
    }
    func addBeaconRegion(uuidString: String, major: CLBeaconMajorValue, minor: CLBeaconMinorValue, identifier: String) {
        let uuid = UUID(uuidString: uuidString)!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: identifier)
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
    }
    
    
    func update(distance: CLProximity, name: String) {
        UIView.animate(withDuration: 1) { [weak self] in
            self?.beaconName.text = "\(name)"
            switch distance {
            case .far:
                self?.view.backgroundColor = .blue
                self?.distanceReading.text = "FAR😩"
            case .near:
                self?.view.backgroundColor = .orange
                self?.distanceReading.text = "NEAR👀"
            case .immediate:
                self?.view.backgroundColor = .red
                self?.distanceReading.text = "ON THE MONEY💰"
            default:
                self?.view.backgroundColor = .gray
                self?.distanceReading.text = "UNKNOWN💀"
            }
        }
    }
    func detected() {
        if vibeCheck {
            vibeCheck = false
        let ac = UIAlertController(title: "Beacon Detected!", message: "You have located a beacon", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            // , handler:{(alert: UIAlertAction!) in self.vibeCheck.toggle()}
        present(ac, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            if currentBeaconUuid == nil { currentBeaconUuid = region.proximityUUID }
            guard currentBeaconUuid == region.proximityUUID else { return }
            update(distance: beacon.proximity, name: region.identifier)
            detected()
        } else {
            guard currentBeaconUuid == region.proximityUUID else { return }
            currentBeaconUuid = nil
            update(distance: .unknown, name: "Beacon Not Found")
        }
    }
}

