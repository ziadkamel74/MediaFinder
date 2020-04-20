//
//  MapVC.swift
//  RegistrationApp
//
//  Created by Ziad on 2/21/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol sendingMessageDelegate {
    func messageData(Data: String)
}

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    var previousLocation: CLLocation?
    let locationManager = CLLocationManager()
    var delegate: sendingMessageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        mapView.delegate = self
    }
    
    func checkLocationServices() {
        //checking if location services enabled
        if CLLocationManager.locationServicesEnabled() {
            setUpLocationManager()
            checkLocationAuthorization()
        } else {
            showAlert(title: "Location disabled", message: "Please enable location services", actionTitle: "Ok")
        }
    }
    
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization() {
        // checking authorization status for accessing location services
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTrackingUserLocation()
        case .denied: // Show alert telling users how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted: // Show an alert letting them know what’s up
            break
        case .authorizedAlways:
            break
        default:
            break
        }
    }
    
    func startTrackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
//        mapView.setUserTrackingMode(.follow, animated: true)
        previousLocation = getCenterLocation(for: mapView)
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 100000, longitudinalMeters: 100000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    @IBAction func pickLocationBtnPressed(_ sender: UIButton) {
        self.delegate?.messageData(Data: self.addressLabel.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MapVC: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        guard let previousLocation = self.previousLocation else {
            return
        }
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else {return}
            if let _ = error {
                //show alert
                return
            }
            guard let placemark = placemarks?.first else {
                //show alert
                return
            }
            
            let streetName = placemark.thoroughfare ?? ""
            let city = placemark.locality ?? ""
            let country = placemark.country ?? ""
            
            DispatchQueue.main.async {
                self.addressLabel.text = "\(streetName), \(city), \(country)"
            }
        }

        
    }
}
