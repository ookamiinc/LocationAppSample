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
    var speed: String     { return("\(lm.location?.speed ?? 0)") }
    var course: String    { return("\(lm.location?.course ?? 0)") }

    var heading: String { return("\(lm.heading?.magneticHeading ?? -1)") }
    var trueHeading: String { return("\(lm.heading?.trueHeading ?? -1)") }

    var magneticFieldX: String { return("\(mm.magnetometerData?.magneticField.x ?? 0)") }
    var magneticFieldY: String { return("\(mm.magnetometerData?.magneticField.y ?? 0)") }
    var magneticFieldZ: String { return("\(mm.magnetometerData?.magneticField.z ?? 0)") }

    var accelerationX: String { return("\(mm.accelerometerData?.acceleration.x ?? 0)") }
    var accelerationY: String { return("\(mm.accelerometerData?.acceleration.y ?? 0)") }
    var accelerationZ: String { return("\(mm.accelerometerData?.acceleration.z ?? 0)") }

    var attitudeRoll: String { return("\(mm.motion?.attitude.roll ?? 0)") }
    var attitudePitch: String { return("\(mm.motion?.attitude.pitch ?? 0)") }
    var attitudeYaw: String { return("\(mm.motion?.attitude.yaw ?? 0)") }
    var attitudeRotationMatrix: String { return("\(String(describing: mm.motion?.attitude.rotationMatrix))") }

    var rotationRateX: String { return("\(mm.motion?.rotationRate.x ?? 0)") }
    var rotationRateY: String { return("\(mm.motion?.rotationRate.y ?? 0)") }
    var rotationRateZ: String { return("\(mm.motion?.rotationRate.z ?? 0)") }

    var gravityX: String { return("\(mm.motion?.gravity.x ?? 0)") }
    var gravityY: String { return("\(mm.motion?.gravity.y ?? 0)") }
    var gravityZ: String { return("\(mm.motion?.gravity.z ?? 0)") }

    var body: some View {
        VStack {
            Group {
                Text("Latitude: \(self.latitude)")
                Text("Longitude: \(self.longitude)")
                Text("Placemark: \(self.placemark)")
                Text("Status: \(self.status)")
                Text("Speed: \(self.speed)")
                Text("Course: \(self.course)")
            }
            Group {
                Text("Heading: \(self.heading)")
                Text("TrueHeading: \(self.trueHeading)")
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
            Group {
                Text("Attitude Roll: \(self.attitudeRoll)")
                Text("Attitude Pitch: \(self.attitudePitch)")
                Text("Attitude Yaw: \(self.attitudeYaw)")
                Text("Attitude RotationMatrix: \(self.attitudeRotationMatrix)")
            }
            Group {
                Text("RotationRate x: \(self.rotationRateX)")
                Text("RotationRate y: \(self.rotationRateY)")
                Text("RotationRate z: \(self.rotationRateZ)")
            }
            Group {
                Text("Gravity x: \(self.gravityX)")
                Text("Gravity y: \(self.gravityY)")
                Text("Gravity z: \(self.gravityZ)")
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
