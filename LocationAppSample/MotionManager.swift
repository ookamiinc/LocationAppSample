//
//  MotionManager.swift
//  LocationAppSample
//
//  Created by Fumiya Nakamura on 2020/01/23.
//  Copyright © 2020 Fumiya Nakamura. All rights reserved.
//

import Foundation
import Combine
import CoreMotion

class MotionManager: NSObject, ObservableObject {
    private let motionManager = CMMotionManager()

    let objectWillChange = PassthroughSubject<Void, Never>()

    @Published var magnetometerData: CMMagnetometerData? {
        willSet { objectWillChange.send()}
    }

    @Published var accelerometerData: CMAccelerometerData? {
        willSet { objectWillChange.send() }
    }

    @Published var motion: CMDeviceMotion? {
        willSet { objectWillChange.send() }
    }

    override init() {
        super.init()

        if self.motionManager.isMagnetometerAvailable {
            self.motionManager.startMagnetometerUpdates(to: .main) { (magnetometerData, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
                if let magnetData = magnetometerData {
                    self.magnetometerData = magnetData
                }
            }
        }

        if self.motionManager.isAccelerometerAvailable {
            self.motionManager.startAccelerometerUpdates(to: .main) { (accelerometerData, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
                if let accelData = accelerometerData {
                    self.accelerometerData = accelData
                }
            }
        }

        if self.motionManager.isDeviceMotionAvailable {
            self.motionManager.startDeviceMotionUpdates(to: .main) { (deviceMotionData, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
                if let motionData = deviceMotionData {
                    self.motion = motionData
                }
            }
        }
    }
}
