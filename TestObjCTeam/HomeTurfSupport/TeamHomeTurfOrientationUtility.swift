//
//  TeamHomeTurfOrientationUtility.swift
//
//

import UIKit
import Foundation
import HomeTurf

@objc class TeamHomeTurfOrientationUtility: NSObject, HomeTurfBaseOrientationUtility {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    @objc func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        delegate.orientationLock = orientation
    }

    @objc func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIInterfaceOrientation) {
        self.lockOrientation(orientation)
    
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }

}
