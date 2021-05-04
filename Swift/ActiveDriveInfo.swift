//
//  ActiveDriveInfo.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK

///  Information about the active drive if any.
@objc(ZDActiveDriveInfo) public class ActiveDriveInfo : NSObject {


    /// The unique Id for this drive
    @objc public fileprivate(set) var driveId: String


    /// The start timestamp of trip in milliseconds since epoch.
    @objc public var startTimestamp: Int64


    /// The insurance period for this drive
    public var insurancePeriod: InsurancePeriod


    /// The current speed of vehicle in metres/second.
    @objc public var currentSpeed: Double


    /// The distance covered so far in this trip in meters.
    @objc public var distance: Double


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
        self.init(with: ZendriveSDK.ZendriveActiveDriveInfo())!
    }

    convenience init?(with objcActiveDriveInfo: ZendriveSDK.ZendriveActiveDriveInfo?) {
        if let objcActiveDriveInfo = objcActiveDriveInfo {
            self.init(with: objcActiveDriveInfo)
        } else {
            return nil
        }
    }

    init(with objcActiveDriveInfo: ZendriveSDK.ZendriveActiveDriveInfo) {
        self.sessionId = objcActiveDriveInfo.sessionId
        self.trackingId = objcActiveDriveInfo.trackingId
        self.distance = objcActiveDriveInfo.distance
        self.currentSpeed = objcActiveDriveInfo.currentSpeed
        self.insurancePeriod = InsurancePeriod.fromObjcInsurancePeriod(objcActiveDriveInfo.insurancePeriod)
        self.startTimestamp = objcActiveDriveInfo.startTimestamp
        self.driveId = objcActiveDriveInfo.driveId
    }
}
