//
//  ContentView.swift
//  LocationAppSample
//
//  Created by Fumiya Nakamura on 2020/01/22.
//  Copyright © 2020 Fumiya Nakamura. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var lm = LocationManager()

    var latitude: String  { return("\(lm.location?.latitude ?? 0)") }
    var longitude: String { return("\(lm.location?.longitude ?? 0)") }
    var placemark: String { return("\(lm.placemark?.description ?? "XXX")") }
    var status: String    { return("\(String(describing: lm.status))") }

    var body: some View {
        VStack {
            Text("Latitude: \(self.latitude)")
            Text("Longitude: \(self.longitude)")
            Text("Placemark: \(self.placemark)")
            Text("Status: \(self.status)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
