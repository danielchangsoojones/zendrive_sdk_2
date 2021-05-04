//
//  ZendriveDriveInfo.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK

/// The type of the drive returned from `DriveInfo.driveType`.
///
/// This decides what other `DriveInfo` parameters will be populated.
/// A drive callback can be sent as a false alarm or when we detect that the user was not
/// actually driving but moved using other means of transport.
@objc(ZDDriveType) public enum DriveType : Int32 {

    /// Sometimes, the SDK detects that a trip is invalid after it has been started.
    /// In these cases, the values for `DriveInfo.waypoints`, `DriveInfo.events`,
    /// `DriveInfo.score`, `DriveInfo.maxSpeed` and `DriveInfo.averageSpeed`
    /// will have invalid values.
    case invalid


    /// This was not a driving trip. For e.g bike and train rides will fall under this trip type.
    /// The `DriveInfo` will have `DriveInfo.waypoints`, `DriveInfo.maxSpeed`,
    /// `DriveInfo.averageSpeed`, `DriveInfo.events` and `DriveInfo.score`.
    case nonDriving


    /// This trip was taken in a valid `ZendriveVehicleType`.
    ///
    /// If the SDK determined the user to be a driver or a passenger, the value
    /// will be available in `DriveInfo.userMode`
    ///
    /// The `DriveInfo` will have `DriveInfo.waypoints`, `DriveInfo.maxSpeed`,
    /// `DriveInfo.averageSpeed`, `DriveInfo.events` and `DriveInfo.score`.
    case drive

    func toObjcDriveType() -> ZendriveSDK.ZendriveDriveType {
        return ZendriveSDK.ZendriveDriveType(rawValue: self.rawValue) ?? ZendriveSDK.ZendriveDriveType.drive
    }

    static func fromObjcDriveType(_ objcDriveType: ZendriveSDK.ZendriveDriveType) -> DriveType {
        return DriveType(rawValue: objcDriveType.rawValue) ?? DriveType.drive
    }
}

/// The value return from `DriveInfo.userMode`. Indicates whether user
/// was a driver or passenger.
@objc(ZDUserMode) public enum UserMode : Int32 {

    /// Indicates that the user was in the driver seat.
    /// All values in `DriveInfo` will be set.
    case driver


    /// Indicates that the user was in the passenger seat.
    /// `DriveInfo.score` will have default value. All other values will be set.
    case passenger


    /// Indicates that either `DriveInfo.driveType` is not
    /// `DriveType.drive` or `Zendrive` was not able to determine user mode.
    /// All values in `DriveInfo` will be set.
    case unavailable

    func toObjcUserMode() -> ZendriveSDK.ZendriveUserMode {
        return ZendriveSDK.ZendriveUserMode(rawValue: self.rawValue) ?? ZendriveSDK.ZendriveUserMode.driver
    }

    static func fromObjcUserMode(_ objcUserMode: ZendriveSDK.ZendriveUserMode) -> UserMode {
        return UserMode(rawValue: objcUserMode.rawValue) ?? UserMode.driver
    }
}

/// The types of insurance period in `Zendrive`
///
/// Each drive belongs to exactly one of these insurance periods.
@objc(ZDInsurancePeriod) public enum InsurancePeriod : Int32 {

    /// Applications that do not use insurance APIs will have drives with
    /// this value for insurance period
    case noPeriod

    /// Drives detected in insurance period 1 will have this value.
    /// Refer: `ZendriveInsurance.startDrive(withPeriod1:)`
    case period1

    /// Drives undertaken with insurance period 2 will have this value.
    /// Refer: `ZendriveInsurance.startDrive(withPeriod2:completionHandler:)`
    case period2

    /// Drives undertaken with insurance period 3 will have this value.
    /// Refer: `ZendriveInsurance.startDrive(withPeriod3:completionHandler:)`
    case period3

     func toObjcInsurancePeriod() -> ZendriveSDK.ZendriveInsurancePeriod {
        return ZendriveSDK.ZendriveInsurancePeriod(rawValue: self.rawValue) ?? ZendriveSDK.ZendriveInsurancePeriod.noPeriod
    }

     static func fromObjcInsurancePeriod(_ objInsurancePeriod: ZendriveSDK.ZendriveInsurancePeriod) -> InsurancePeriod {
        return InsurancePeriod(rawValue: objInsurancePeriod.rawValue) ?? InsurancePeriod.noPeriod
    }
}

/// The types of phone positions during a trip.
@objc(ZDPhonePosition) public enum PhonePosition : Int32 {

    /// The case when `Zendrive` was unable to determine the position of the phone during a trip.
    case unknown

    /// The case when `Zendrive` was able to determine confidently that the phone was on mount during a trip.
    case mount

     func toObjcPhonePosition() -> ZendriveSDK.ZendrivePhonePosition {
        return ZendriveSDK.ZendrivePhonePosition(rawValue: self.rawValue) ?? ZendriveSDK.ZendrivePhonePosition.unknown
    }

     static func fromObjcPhonePosition(_ objcPhonePosition: ZendriveSDK.ZendrivePhonePosition) -> PhonePosition {
        return PhonePosition(rawValue: objcPhonePosition.rawValue) ?? PhonePosition.unknown
    }
}

/// Wrapper for meta-information related to a drive.
@objc(ZDDriveInfo) public class DriveInfo : NSObject {

    /// The unique Id for this drive
    @objc public var driveId: String!

    /// The type of the drive. This decides what other info parameters will be populated.
    ///
    /// A drive callback will be sent even for falsely detected drives or for non
    /// automobile trips (Eg. biking, public transport).
    @objc public var driveType: DriveType


    /// Whether the user was a driver or a passenger.
    ///
    /// Driver/Passenger detection is disabled by default. Talk to your
    /// contact in `Zendrive` to enable this feature. Only present when `driveType` is
    /// `DriveType.drive` and the SDK was able to determine with confidence
    /// whether the user was a driver or a passenger.
    ///
    /// If the SDK was not able to determine the user mode, this field is
    /// `UserMode.unavailable`.
    @objc public var userMode: UserMode


    /// The insurance period for this drive
    @objc public var insurancePeriod: InsurancePeriod


    /// The start timestamp of trip in milliseconds since epoch.
    @objc public var startTimestamp: Int64


    /// The end timestamp of trip in milliseconds since epoch
    @objc public var endTimestamp: Int64

    /// The average speed of trip in metres/second
    @objc public var averageSpeed: Double


    /// The maximum speed of trip in metres/second
    ///
    /// If we do not receive any accurate location data during the drive, this
    /// property would be set to -1
    @objc public var maxSpeed: Double


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

    /// A list of `Event` objects for this trip in increasing order of timestamp.
    ///
    /// In case of no events in the trip an empty list is returned.
    @objc public var events: [Event]

    /// The driving behaviour score for this trip.
    @objc public var score: DriveScore


    /// The ratings of individual events for this trip
    @objc public var eventRatings: EventRatings

    /// The position of the phone during this trip.
    @objc public var phonePosition: PhonePosition

    /// A list of `TripWarning` objects for this trip.
    ///
    /// In case of no warnings in the trip an empty list is returned.
    @objc public var tripWarnings: [TripWarning]

    ///
    /// A list of `TagInfo` for this trip.
    /// This list will only be populated in `ZendriveDelegate.processAnalysis(ofDrive:)` callback.
    ///
    /// In case of no tags in the trip, an empty list is returned.
    ///
    /// - SeeAlso: `ZendriveVehicleTagging.getAssociatedVehicleForDrive(_:)`
    ///
    @objc public var tags: [TagInfo]

    /// The type of vehicle.
    /// If `driveType` is not `DriveType.drive` then it will be set to `VehicleType.unknown`.
    /// NOTE: This value will only be populated in `ZendriveDelegate.processAnalysis(ofDrive:)` callback.
    @objc public var vehicleType: VehicleType

    @objc override convenience init() {
        self.init(with: ZendriveDriveInfo())
    }

     init(with objcDriveInfo: ZendriveSDK.ZendriveDriveInfo) {
        self.waypoints = LocationPoint.convertArray(objcLocationPoints: objcDriveInfo.waypoints as? [ZendriveLocationPoint])
        self.events = Event.convertArray(objcEvents: objcDriveInfo.events as? [ZendriveEvent])
        self.averageSpeed = objcDriveInfo.averageSpeed
        self.maxSpeed = objcDriveInfo.maxSpeed
        self.distance = objcDriveInfo.distance
        self.score = DriveScore(zendriveScore: objcDriveInfo.score.zendriveScore)
        self.startTimestamp = objcDriveInfo.startTimestamp
        self.endTimestamp = objcDriveInfo.endTimestamp
        self.trackingId = objcDriveInfo.trackingId
        self.sessionId = objcDriveInfo.sessionId
        self.driveType = DriveType.fromObjcDriveType(objcDriveInfo.driveType)
        self.userMode = UserMode.fromObjcUserMode(objcDriveInfo.userMode)
        self.insurancePeriod = InsurancePeriod.fromObjcInsurancePeriod(objcDriveInfo.insurancePeriod)
        self.phonePosition = PhonePosition.fromObjcPhonePosition(objcDriveInfo.phonePosition)
        self.eventRatings = EventRatings(with: objcDriveInfo.eventRatings)
        self.tripWarnings = TripWarning.convertArray(objcTripWarnings:
            objcDriveInfo.tripWarnings)
        self.driveId = objcDriveInfo.driveId
        self.tags = TagInfo.convertArray(objcTagInfos: objcDriveInfo.tags)
        self.vehicleType = VehicleType.fromObjcVehicleType(objcDriveInfo.vehicleType)
    }

    func toObjcDriveInfo() -> ZendriveDriveInfo {
        let objcDriveInfo = ZendriveDriveInfo()
        objcDriveInfo.waypoints = LocationPoint.convertArray(swiftLocationPoints: waypoints)
        objcDriveInfo.events = Event.convertArray(swiftEvents: events)
        objcDriveInfo.averageSpeed = averageSpeed
        objcDriveInfo.maxSpeed = maxSpeed
        objcDriveInfo.distance = distance
        objcDriveInfo.score = ZendriveDriveScore(zendriveScore: score.zendriveScore)
        objcDriveInfo.startTimestamp = startTimestamp
        objcDriveInfo.endTimestamp = endTimestamp
        objcDriveInfo.trackingId = trackingId
        objcDriveInfo.sessionId = sessionId
        objcDriveInfo.driveType = driveType.toObjcDriveType()
        objcDriveInfo.userMode = userMode.toObjcUserMode()
        objcDriveInfo.insurancePeriod = insurancePeriod.toObjcInsurancePeriod()
        objcDriveInfo.phonePosition = phonePosition.toObjcPhonePosition()
        objcDriveInfo.eventRatings = eventRatings.toObjcEventRatings()
        objcDriveInfo.tripWarnings = TripWarning.convertArray(swiftTripWarnings:
            tripWarnings)
        objcDriveInfo.driveId = driveId
        objcDriveInfo.tags = TagInfo.convertArray(swiftTagInfos: tags)
        objcDriveInfo.vehicleType = vehicleType.toObjcVehicleType()
        return objcDriveInfo
    }
}
