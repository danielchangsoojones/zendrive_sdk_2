//
//  ZendriveDriveStartInfo.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK

///  Information about start of a drive.
@objc(ZDDriveStartInfo) public class DriveStartInfo : NSObject {


    /// The unique Id for this drive
    @objc public fileprivate(set) var driveId: String


    /// The start timestamp of trip in milliseconds since epoch
    @objc public var startTimestamp: Int64


    /// The insurance period for this drive
    @objc public var insurancePeriod: InsurancePeriod



    /// The distance of the trip in metres
    @objc public var distance: Double


    /// A list of `LocationPoint` objects corresponding to this trip in
    /// increasing order of timestamp. The first point corresponds to trip start location.
    ///
    /// This array contains a series of `LocationPoint` which
    /// approximate the path taken by the driver. This is not the detailed location
    /// data but rather a sample representing route geometry.
    ///
    /// - Note: The array might be empty if no accurate gps location is determined till
    /// `ZendriveDelegate.processStart(ofDrive:)` call.
    @objc public var waypoints: [LocationPoint]?


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

    @objc override convenience init() {
        self.init(with: ZendriveSDK.ZendriveDriveStartInfo())
    }

    init(with objcDriveStartInfo: ZendriveSDK.ZendriveDriveStartInfo) {
        self.driveId = objcDriveStartInfo.driveId
        self.startTimestamp = objcDriveStartInfo.startTimestamp
        self.insurancePeriod = InsurancePeriod.fromObjcInsurancePeriod(objcDriveStartInfo.insurancePeriod)
        self.distance = objcDriveStartInfo.distance
        self.waypoints = LocationPoint.convertArray(objcLocationPoints: objcDriveStartInfo.waypoints as? [ZendriveLocationPoint])
        self.trackingId = objcDriveStartInfo.trackingId
        self.sessionId = objcDriveStartInfo.sessionId
    }

}
