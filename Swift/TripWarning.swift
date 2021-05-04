//
//  ZendriveTripWarning.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK

/// The value return from `TripWarning.warning`.
/// Enum representing warnings detected for the current drive.
@objc(ZDTripWarningType) public enum TripWarningType : Int32 {

    /// The trip duration is unexpectedly large and signifies a possible integration issue.
    case unexpectedTripDuration

    internal func toObjcTripWarningType() -> ZendriveSDK.ZendriveTripWarningType {
        return ZendriveSDK.ZendriveTripWarningType(rawValue: self.rawValue) ?? ZendriveSDK.ZendriveTripWarningType.unexpectedTripDuration
    }

    internal static func fromObjcTripWarningType(_ objcTripWarningType: ZendriveSDK.ZendriveTripWarningType) -> TripWarningType {
        return TripWarningType(rawValue: objcTripWarningType.rawValue) ?? TripWarningType.unexpectedTripDuration
    }
}

/// Represents a single warning that might have occurred during your trip.
/// A collection of these warnings are provided using the
/// `ZendriveDelegate.processAnalysis(ofDrive:)` callback.
@objc(ZDTripWarning) public class TripWarning : NSObject {

    /// The type of the trip warning.
    @objc public private(set) var tripWarningType: TripWarningType

    /// Initializer for creating a `TripWarning`.
    /// - Parameter tripWarningType: type of warning detected for the current drive.
    @objc public init(warning tripWarningType: TripWarningType) {
        self.tripWarningType = tripWarningType
    }

    func toObjcTripWarning() -> ZendriveSDK.ZendriveTripWarning {
        let objcTripWarning = ZendriveTripWarning()
        objcTripWarning.tripWarningType = tripWarningType.toObjcTripWarningType()
        return objcTripWarning
    }

    static func convertArray(objcTripWarnings:
        [ZendriveSDK.ZendriveTripWarning]?) -> [TripWarning] {
        var warnings: [TripWarning] = []
        if let objcTripWarnings = objcTripWarnings {
            for tripWarning in objcTripWarnings {
                warnings.append(TripWarning(warning:
                    TripWarningType.fromObjcTripWarningType(tripWarning
                        .tripWarningType)))
            }
        }
        return warnings
    }

    static func convertArray(swiftTripWarnings: [TripWarning]?) ->
        [ZendriveTripWarning] {
        var warnings: [ZendriveTripWarning] = []
        if let swiftTripWarnings = swiftTripWarnings {
            for tripWarning in swiftTripWarnings {
                warnings.append(tripWarning.toObjcTripWarning())
            }
        }
        return warnings
    }
}
