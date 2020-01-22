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

class LocationManager: NSObject, ObservableObject {
  private let locationManager = CLLocationManager()
  private let geocoder = CLGeocoder()
  let objectWillChange = PassthroughSubject<Void, Never>()

  @Published var status: CLAuthorizationStatus? {
    willSet { objectWillChange.send() }
  }

  @Published var location: CLLocation? {
    willSet { objectWillChange.send() }
  }

  @Published var placemark: CLPlacemark? {
    willSet { objectWillChange.send() }
  }

  override init() {
    super.init()

    self.locationManager.delegate = self

    self.locationManager.distanceFilter = kCLDistanceFilterNone
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.activityType = .otherNavigation

    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
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
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        self.geocode()
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
