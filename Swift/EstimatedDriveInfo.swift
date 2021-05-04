//
//  EstimatedDriveInfo.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK

/// This contains the best estimated results for a drive, this is returned from
/// `ZendriveDelegate.processEnd(ofDrive estimatedDriveInfo:)` callback.
///
/// The data of this type will always be of same or little bad quality than
/// `AnalyzedDriveInfo` returned from `ZendriveDelegate.processAnalysis(ofDrive analyzedDriveInfo:)`
///
/// All drives with driveType not set to `DriveType.invalid` will get a
/// corresponding `ZendriveDelegate.processAnalysis(ofDrive analyzedDriveInfo:)` callback.
///
/// Typically `ZendriveDelegate.processAnalysis(ofDrive analyzedDriveInfo:)` will be fired within
/// a few seconds after `ZendriveDelegate.processEnd(ofDrive estimatedDriveInfo:)` callback but in some rare cases
/// this delay can be really large depending on phone network conditions.
@objc(ZDEstimatedDriveInfo) public class EstimatedDriveInfo : DriveInfo {

    @objc convenience init() {
        self.init(with: ZendriveSDK.ZendriveEstimatedDriveInfo())
    }

    init(with objcEstimatedDriveInfo: ZendriveSDK.ZendriveEstimatedDriveInfo) {
        super.init(with: objcEstimatedDriveInfo)
    }
}
