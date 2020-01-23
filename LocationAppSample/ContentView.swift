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
    @ObservedObject var mm = MotionManager()

    var latitude: String  { return("\(lm.location?.latitude ?? 0)") }
    var longitude: String { return("\(lm.location?.longitude ?? 0)") }
    var placemark: String { return("\(lm.placemark?.description ?? "XXX")") }
    var status: String    { return("\(String(describing: lm.status))") }

    var magneticFieldX: String { return("\(mm.magnetometerData?.magneticField.x ?? 0)") }
    var magneticFieldY: String { return("\(mm.magnetometerData?.magneticField.y ?? 0)") }
    var magneticFieldZ: String { return("\(mm.magnetometerData?.magneticField.z ?? 0)") }

    var accelerationX: String { return("\(mm.accelerometerData?.acceleration.x ?? 0)") }
    var accelerationY: String { return("\(mm.accelerometerData?.acceleration.y ?? 0)") }
    var accelerationZ: String { return("\(mm.accelerometerData?.acceleration.z ?? 0)") }

    var body: some View {
        VStack {
            Group {
                Text("Latitude: \(self.latitude)")
                Text("Longitude: \(self.longitude)")
                Text("Placemark: \(self.placemark)")
                Text("Status: \(self.status)")
            }
            Group {
                Text("Magnetic x: \(self.magneticFieldX)")
                Text("Magnetic y: \(self.magneticFieldY)")
                Text("Magnetic z: \(self.magneticFieldZ)")
            }
            Group {
                Text("Acceleration x: \(self.accelerationX)")
                Text("Acceleration y: \(self.accelerationY)")
                Text("Acceleration z: \(self.accelerationZ)")
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
