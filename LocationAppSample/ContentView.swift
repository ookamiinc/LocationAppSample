//
//  ContentView.swift
//  LocationAppSample
//
//  Created by Fumiya Nakamura on 2020/01/22.
//  Copyright © 2020 Fumiya Nakamura. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var lm = LocationManager()

    private var competition_id: String { return ("\(lm.competition_id)") }
    private var car_id: String { return ("\(lm.car_id)") }

    private var latitude: String  { return("\(lm.location?.latitude ?? 0)") }
    private var longitude: String { return("\(lm.location?.longitude ?? 0)") }
    private var status: String    { return("\(String(describing: lm.status))") }
    private var speed: String     { return("\(lm.location?.speed ?? 0)") }
    private var course: String    { return("\(lm.location?.course ?? 0)") }

    var body: some View {
        VStack {
            Group {
                Text("Competition ID: \(self.competition_id)").font(Font.system(size: 30))
                Text("Car No. \(self.car_id)").font(Font.system(size: 30))
            }
            Group {
                Text("Latitude: \(self.latitude)")
                Text("Longitude: \(self.longitude)")
                Text("Status: \(self.status)")
                Text("Speed: \(self.speed)")
                Text("Course: \(self.course)")
            }
            MapView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
