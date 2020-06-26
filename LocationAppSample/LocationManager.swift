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
    let objectWillChange = PassthroughSubject<Void, Never>()

    private var databaseRef: DatabaseReference!
    private var lastLocation: CLLocation?

    let competition_id = 52283
    let car_id = 36

    @Published var status: CLAuthorizationStatus? {
        willSet { objectWillChange.send() }
    }

    @Published var location: CLLocation? {
        willSet { objectWillChange.send() }
    }

    override init() {
        super.init()

        databaseRef = Database.database().reference()

        self.locationManager.delegate = self
        self.locationManager.allowsBackgroundLocationUpdates = true

        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.activityType = .automotiveNavigation

        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    private func sendLocation(_ newLocation: CLLocation) {
        let locationData: [String: Any] = [
            "latitude": newLocation.latitude,
            "longitude": newLocation.longitude,
            "speed": newLocation.speed,
            "course": newLocation.course,
            "timestamp": newLocation.timestamp.timeIntervalSince1970
        ]
        databaseRef.child("v0/locations/\(competition_id)/\(car_id)").childByAutoId().setValue(locationData)
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
