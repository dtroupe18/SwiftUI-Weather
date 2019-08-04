//
//  LocationService.swift
//  SwiftUI-Weather
//
//  Created by Dave Troupe on 8/4/19.
//  Copyright © 2019 HighTreeDevelopment. All rights reserved.
//

import CoreLocation
import UIKit

final class LocationService {

    private let locationManager = CLLocationManager()
    private let geoCoder = CLGeocoder()
    private(set) var currentLocation: CLLocation?
    private(set) var authStatus = CLLocationManager.authorizationStatus()

    var canAccessLocation: Bool {
        switch authStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .denied, .restricted, .notDetermined:
            return false
        @unknown default:
            return false
        }
    }

    func requestLocationAccess() {
        if authStatus == .denied {
            // FIXME:
            // We cannot ask the user again so we just want to alert them
            if let topVC = UIApplication.topViewController() {
                topVC.showAlert(title: "Location Access Denied", message: "Without access to your location outside now can only provide weather if your search for a location. You can update location access in settings.")
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func getPlaceMark(completion: @escaping(_ placemark: CLPlacemark?, _ error: Error?) ->()) {
        if self.authStatus == .authorizedWhenInUse || self.authStatus == .authorizedAlways {
            if let location = locationManager.location {
                self.currentLocation = location
                geoCoder.reverseGeocodeLocation(location) { placemarks, error in
                    if let err = error {
                        completion(nil, err)
                    }
                    if let places = placemarks {
                        let placemarkArray = places as [CLPlacemark]
                        if !placemarkArray.isEmpty {
                            completion(placemarkArray[0], nil)
                        }
                    }
                }
            }
            else if let location = self.currentLocation {
                geoCoder.reverseGeocodeLocation(location) { placemarks, error in
                    if let err = error {
                        completion(nil, err)
                    }
                    if let places = placemarks {
                        let placemarkArray = places as [CLPlacemark]
                        if !placemarkArray.isEmpty {
                            completion(placemarkArray[0], nil)
                        }
                    }
                }
            }
            else if let location = CLLocationManager().location {
                geoCoder.reverseGeocodeLocation(location) { placemarks, error in
                    if let err = error {
                        completion(nil, err)
                    }
                    if let places = placemarks {
                        let placemarkArray = places as [CLPlacemark]
                        if !placemarkArray.isEmpty {
                            completion(placemarkArray[0], nil)
                        }
                    }
                }
            }
        } else {
            print("Auth status failed... in locationWrapper")
        }
    }

    func searchForPlacemark(text: String, completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        geoCoder.geocodeAddressString(text, completionHandler: { (placemarks, error) in
            if let err = error {
                completion(nil, err)
            }
            if let places = placemarks {
                let placemarkArray = places as [CLPlacemark]
                if !placemarkArray.isEmpty {
                    completion(placemarkArray[0], nil)
                }
            }
        })
    }
}
