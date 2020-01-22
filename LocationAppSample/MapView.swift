//
//  MapView.swift
//  LocationAppSample
//
//  Created by Fumiya Nakamura on 2020/01/23.
//  Copyright © 2020 Fumiya Nakamura. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView

    @ObservedObject var lm = LocationManager()

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let uiView = MKMapView(frame: .zero)
        uiView.showsUserLocation = true
        let coordinate = CLLocationCoordinate2D(latitude: 35.66366485323353, longitude: 139.65794269939852)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
        return uiView
    }

    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lm.location?.latitude ?? 35.66366485323353, longitude: lm.location?.longitude ?? 139.65794269939852)
        uiView.addAnnotation(annotation)
    }
}
