//
//  DriveResumeInfo.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK

/// Information about a drive that was resumed in the `Zendrive` SDK.
///
/// This is called after the drive recording resumes after a gap. The gap may occur due to
/// an application restart by the OS, application kill and restart by a user, an application crash
/// etc.
@objc(ZDDriveResumeInfo) public class DriveResumeInfo : NSObject {


    /// The unique Id for this drive
    @objc public fileprivate(set) var driveId: String


    /// The insurance period for this drive
    @objc public var insurancePeriod: InsurancePeriod


    /// The start timestamp of trip in milliseconds since epoch.
    @objc public var startTimestamp: Int64


    /// The distance of the trip in metres
    @objc public var distance: Double


    /// A list of `LocationPoint` objects corresponding to this trip in
    /// increasing order of timestamp. The first point corresponds to trip start location
    /// and last to trip end location.
    ///
    /// This is a sampled approximation of the drive which gives an indication of
    /// the path taken by the driver. It is not the full detailed location data of the drive.
    /// If no waypoints are recorded during the drive, this is an empty array.
    @objc public var waypoints: [LocationPoint]


    /// Tracking id is specified by the enclosing application when it
    /// wants to start a drive manually by calling `Zendrive.startManualDrive(_:completionHandler:)`
    ///
    /// This may be the case for example in a taxi cab application that would
    /// know when to start a drive based on when a meter gets flagged. trackingId will be
    /// nil in case of auto detected drives.
    @objc public var trackingId: String?


    /// Session id is specified by the enclosing application when it wants to
    /// record a session using `Zendrive.startSession(_:)`
    ///
    /// sessionId will be nil if there is no session associated with that drive.
    @objc public var sessionId: String?


    /// The start timestamp of the gap in drive recording in milliseconds.
    ///
    /// The drive was resumed after this gap.
    @objc public var driveGapStartTimestampMillis: Int64


    /// The end timestamp of the gap in drive recording in milliseconds.
    ///
    /// The drive was resumed after this gap.
    @objc public var driveGapEndTimestampMillis: Int64

    @objc override convenience init() {
        self.init(with: ZendriveSDK.ZendriveDriveResumeInfo())
    }

    init(with objcDriveResumeInfo: ZendriveSDK.ZendriveDriveResumeInfo) {
        self.driveId = objcDriveResumeInfo.driveId
        self.insurancePeriod = InsurancePeriod.fromObjcInsurancePeriod(objcDriveResumeInfo.insurancePeriod)
        self.startTimestamp = objcDriveResumeInfo.startTimestamp
        self.distance = objcDriveResumeInfo.distance
        self.waypoints = LocationPoint.convertArray(objcLocationPoints:
            objcDriveResumeInfo.waypoints as? [ZendriveLocationPoint])
        self.trackingId = objcDriveResumeInfo.trackingId
        self.sessionId = objcDriveResumeInfo.sessionId
        self.driveGapStartTimestampMillis = objcDriveResumeInfo.driveGapStartTimestampMillis
        self.driveGapEndTimestampMillis = objcDriveResumeInfo.driveGapEndTimestampMillis
    }
}
