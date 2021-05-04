//
//  AnalyzedDriveInfo.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//
import Foundation
import ZendriveSDK


/// This contains the fully analyzed results for a drive, this is returned from
/// `ZendriveDelegate.processAnalysis(ofDrive:)` callback for all the trips with the value of
/// `DriveInfo.driveType` not set to `DriveType.invalid`.
///
/// The data of this type will always be of equal or better quality than
/// `EstimatedDriveInfo` returned from `ZendriveDelegate.processEnd(ofDrive:)`
///
/// Typically `ZendriveDelegate.processAnalysis(ofDrive:)` will be fired within
/// a few seconds after `ZendriveDelegate.processEnd(ofDrive:)` callback but in some rare cases
/// this delay can be really large depending on phone network conditions.
///
/// The callback for this `ZendriveDelegate.processAnalysis(ofDrive:)` will be fired in trip
/// occurrence sequence, i.e. from oldest trip to the latest trip.
@objc(ZDAnalyzedDriveInfo) public class AnalyzedDriveInfo : DriveInfo {

    @objc convenience init() {
        self.init(with: ZendriveSDK.ZendriveAnalyzedDriveInfo())
    }

    init(with objcAnalyzedDriveInfo: ZendriveSDK.ZendriveAnalyzedDriveInfo) {
        super.init(with: objcAnalyzedDriveInfo)
    }
}
