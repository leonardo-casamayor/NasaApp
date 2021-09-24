//
//  RotationHelper.swift
//  Nasa App
//
//  Created by Leonardo Casamayor on 24/09/2021.
//

import UIKit

struct RotationHelper {
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
}
