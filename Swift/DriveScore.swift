//
//  ZendriveDriveScore.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK

/// Driving Behaviour scores for a drive.
///
/// The scores are expressed as a number between 0 to 100 and will be -1 if not available.
///
/// High scores indicate safe driving and low scores reflect hazardous or risky driving patterns.
/// Preventive or corrective actions should be prescribed in extreme cases.
///
/// More information is available
/// <a href="http://docs.zendrive.com/en/latest/api/scores.html" target="_blank">here</a>
@objc(ZDDriveScore) public class DriveScore : NSObject {

    /// The `Zendrive` score for this drive. The zendrive score measures the focus, control and
    /// cautiousness of a driver. It reflects the accident risk associated with this drive.
    /// The scores is expressed as a number between 0 to 100 and will be -1 if not available.
    @objc public var zendriveScore: Int32 {
        get {
            return self.internalDriveScore.zendriveScore
        }

        set {
            self.internalDriveScore = ZendriveSDK.ZendriveDriveScore(zendriveScore: newValue)
        }
    }

    var internalDriveScore: ZendriveSDK.ZendriveDriveScore!

    /// Default initializer for creating a `DriveScore` object.
    @objc override public init() {
        super.init()
        self.internalDriveScore = ZendriveSDK.ZendriveDriveScore()
        self.zendriveScore = self.internalDriveScore.zendriveScore
    }

    /// Initializer for creating a `DriveScore` object.
    /// - Parameter zendriveScore: The `Zendrive` score for this drive.
    @objc public init(zendriveScore: Int32) {
        super.init()
        self.zendriveScore = zendriveScore
        self.internalDriveScore = ZendriveSDK.ZendriveDriveScore(zendriveScore: zendriveScore)
    }
}
