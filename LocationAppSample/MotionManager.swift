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
    }
}
