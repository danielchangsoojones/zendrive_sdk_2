//
//  ZendriveFeedback.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK

/// The category that best indicates the type of trip
@objc(ZDDriveCategory) public enum DriveCategory : UInt {

    /// Indicates that the trip was taken in a car
    case car = 0


    /// Indicates that the trip was taken in a car and the user was the driver
    case carDriver = 1


    /// Indicates that the trip was taken in a car and the user was a passenger
    case carPassenger = 2


    /// Indicates that the trip was taken in a train or a subway
    case train = 3


    /// Indicates that the trip was taken in a bus
    case bus = 4


    /// Indicates that the trip was taken on a bicycle
    case bicycle = 5


    /// Indicates that the trip was taken on a motorcycle
    case motorcycle = 6


    /// Indicates that the trip was taken on foot (either walking or running)
    case foot = 7


    /// Indicates that the trip was taken using some form of public transit
    /// (bus/train/subway/tram etc)
    case transit = 8

    /// Indicates that the trip was taken using some form of air travel
    case flight = 9

    /// Indicates that there wasn't enough movement and this shouldn't have been
    /// detected as a trip
    case invalid = 97


    /// Indicates that the trip was not taken in a car. This includes everything
    /// other than `DriveCategory.car`
    case notCar = 98


    /// Fallback when the above options do not cover the use case.
    ///
    /// This maybe used when the mode of transport is not covered above (eg. snow-mobile) or
    /// when enough information is not available to put it in one of the above categories
    case other = 99

    func toObjcDriveCategory() -> ZendriveSDK.ZendriveDriveCategory {
        return ZendriveSDK.ZendriveDriveCategory(rawValue: self.rawValue) ?? ZendriveDriveCategory.car
    }

    static func fromObjcDriveCategory(_ objcDriveCategory: ZendriveSDK.ZendriveDriveCategory) -> DriveCategory {
        return DriveCategory(rawValue: objcDriveCategory.rawValue) ?? DriveCategory.car
    }
}

/// Class for providing feedback back to `Zendrive`
@objc(ZDZendriveFeedback) public final class ZendriveFeedback : NSObject {

    /// Help `Zendrive` improve by providing feedback for a drive detected by the SDK.
    ///
    /// - Parameters:
    ///   - driveId: As returned at the end of drive in `DriveInfo`.
    ///   - driveCategory: The category that best indicates the type of Drive.
    @objc public static func addDriveCategory(driveId: String, driveCategory: DriveCategory) {
        ZendriveSDK.ZendriveFeedback.addDriveCategory(withDriveId: driveId, driveCategory: driveCategory.toObjcDriveCategory())
    }


    /// Help `Zendrive` improve by providing information about whether an
    /// event detected by the SDK occurred or not.
    ///
    /// - Parameters:
    ///   - driveId: As returned at the end of drive in `DriveInfo` which
    ///              this event is part of
    ///   - eventTimestamp: As returned in `Event.startTime`
    ///   - eventType: As returned in `Event.eventType`
    ///   - occurrence: Whether the event occurred or not
    @objc public static func addEventOccurrence(driveId: String, eventTimestamp: Int64, eventType: EventType, occurrence: Bool) {
        ZendriveSDK.ZendriveFeedback.addEventOccurrence(withDriveId: driveId,
                                                     eventTimestamp: eventTimestamp,
                                                          eventType: eventType.toObjcEventType(),
                                                         occurrence: occurrence)
    }
}
