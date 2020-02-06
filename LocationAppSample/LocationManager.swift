//
//  LocationManager.swift
//  LocationAppSample
//
//  Created by Fumiya Nakamura on 2020/01/23.
//  Copyright © 2020 Fumiya Nakamura. All rights reserved.
//

import Foundation
import Combine
import CoreLocation
import FirebaseDatabase

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    let objectWillChange = PassthroughSubject<Void, Never>()

    var databaseRef: DatabaseReference!
    var lastLocation: CLLocation?

    @Published var status: CLAuthorizationStatus? {
        willSet { objectWillChange.send() }
    }

    @Published var location: CLLocation? {
        willSet { objectWillChange.send() }
    }

    @Published var heading: CLHeading? {
        willSet { objectWillChange.send() }
    }

    @Published var placemark: CLPlacemark? {
        willSet { objectWillChange.send() }
    }

    override init() {
        super.init()

        databaseRef = Database.database().reference()

        self.locationManager.delegate = self

        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.activityType = .automotiveNavigation

        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()

        self.locationManager.startUpdatingHeading()
    }

    private func geocode() {
        guard let location = self.location else { return }
        geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
            if error == nil {
                self.placemark = places?[0]
            } else {
                self.placemark = nil
            }
        })
    }

    private func sendLocation(_ newLocation: CLLocation) {
        let locationData = ["latitude": newLocation.latitude, "longitude": newLocation.longitude, "speed": newLocation.speed, "course": newLocation.course, "timestamp": newLocation.timestamp.timeIntervalSince1970.description, "timestamp_ms": (newLocation.timestamp.timeIntervalSince1970 * 1000).description, "date": newLocation.timestamp.description] as [String: Any]
        databaseRef.child("Sample").childByAutoId().setValue(locationData)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if let lastLocation = self.lastLocation {
            guard lastLocation.timestamp != self.location?.timestamp else { return }
            self.sendLocation(location)
        }
        self.lastLocation = self.location
        self.location = location
        self.geocode()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.heading = newHeading
    }

    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
}

extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }

    var longitude: Double {
        return self.coordinate.longitude
    }
}
