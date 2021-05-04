//
//  ZendriveInsurance.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 17/07/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//
import Foundation
import ZendriveSDK.Insurance

/// Applications which want to record Fairmatic insurance periods for a driver may use these APIs.
///
/// All drives (automatically detected or manually started) when a period is in progress
/// will be tagged with the period id. This period id will be made available in the reports and API
/// that Fairmatic provides via `Zendrive`.
///
/// Only one period can be active at a time.
/// Switching periods or calling `ZendriveInsurance.stopPeriod(_:)` stops any active drives (automatic or manual).
/// A drive with multiple insurance periods will be split into multiple trips for different
/// insurance periods.
@objc(ZDZendriveInsurance) public final class ZendriveInsurance: NSObject {

    /// Start Fairmatic insurance period 1 in the SDK.
    ///
    /// A manual trip of id trackingId will be started immediately on this call.
    /// The entire duration in this period will be recorded as a single trip.
    /// If period 1 is already in progress with the same trackingId, this call will be a no-op.
    ///
    /// - Parameter completionHandler: A block object to be executed when the task finishes.
    /// This block has no return value and two arguments:
    /// isSuccess, A boolean that suggests successful completion of the call
    /// the error, A valid error of `zendriveErrorDomain` is
    /// returned in case of a failure.
    /// Possible error codes returned: `ZendriveError.notSetup`, `ZendriveError.insurancePeriodSame`,
    /// Refer to `ZendriveError` for more details on the errors.
   @objc public static func startDrive(withPeriod1 completionHandler: ((Bool, Error?) -> Void)?) {
        ZendriveSDK.ZendriveInsurance.startDrive { (success, error) in
            if let completionHandler = completionHandler {
                let swiftError = ZendriveError.fromError(error)
                completionHandler(success, swiftError)
            }
        }
    }

    /// Start Fairmatic insurance period 2 in the SDK.
    ///
    /// A manual trip of id trackingId will be started immediately on this call.
    /// The entire duration in this period will be recorded as a single trip.
    /// If period 2 is already in progress with the same trackingId, this call will be a no-op.
    ///
    /// - Parameters:
    ///   - trackingId: An identifier which allows identifying this drive uniquely.
    ///                 This drive identifier must be unique for the user.
    ///   - completionHandler: A block object to be executed when the task finishes.
    /// This block has no return value and two arguments:
    /// isSuccess, A boolean that suggests successful completion of the call
    /// the error, A valid error of `zendriveErrorDomain` is
    /// returned in case of a failure.
    /// Possible error codes returned: `ZendriveError.notSetup`, `ZendriveError.insurancePeriodSame`,
    /// `ZendriveError.invalidTrackingId`. Refer to `ZendriveError` for more details on the errors.
   @objc public static func startDrive(withPeriod2 trackingId: String, completionHandler: ((Bool, Error?) -> Void)?) {
        ZendriveSDK.ZendriveInsurance.startDrive(withPeriod2: trackingId) { (success, error) in
            if let completionHandler = completionHandler {
                let swiftError = ZendriveError.fromError(error)
                completionHandler(success, swiftError)
            }
        }
    }

    /// Start Fairmatic insurance period 3 in the SDK.
    ///
    /// A manual trip of id trackingId will be started immediately on this call.
    /// The entire duration in this period will be recorded as a single trip.
    /// If period 3 is already in progress with the same trackingId, this call will be a no-op.
    ///
    /// - Parameters:
    ///   - trackingId: An identifier which allows identifying this drive uniquely.
    ///                 This drive identifier must be unique for the user.
    ///   - completionHandler: A block object to be executed when the task finishes.
    /// This block has no return value and two arguments:
    /// isSuccess, A boolean that suggests successful completion of the call
    /// the error, A valid error of `zendriveErrorDomain` is
    /// returned in case of a failure.
    /// Possible error codes returned: `ZendriveError.notSetup`, `ZendriveError.insurancePeriodSame`,
    /// `ZendriveError.invalidTrackingId`. Refer to `ZendriveError` for more details on the errors.
   @objc public static func startDrive(
    withPeriod3 trackingId: String,
    completionHandler: ((Bool, Error?) -> Void)?) {
        ZendriveSDK.ZendriveInsurance.startDrive(withPeriod3: trackingId) { (success, error) in
            if let completionHandler = completionHandler {
                let swiftError = ZendriveError.fromError(error)
                completionHandler(success, swiftError)
            }
        }
    }

    /// Stop currently ongoing Fairmatic insurance period if any.
    ///
    /// Ongoing trips at the time of this call will be stopped.
    /// Auto trip detection is turned off on this call.
    ///
    /// - Parameter completionHandler: A block object to be executed when the task finishes.
    /// This block has no return value and two arguments:
    /// isSuccess, A boolean that suggests successful completion of the call
    /// the error, A valid error of `zendriveErrorDomain` is
    /// returned in case of a failure.
    /// Possible error codes returned: `ZendriveError.notSetup`.
    /// Refer to ZendriveError for more details on the errors.
   @objc public static func stopPeriod(_ completionHandler: ((Bool, Error?) -> Void)?) {
        ZendriveSDK.ZendriveInsurance.stopPeriod { (success, error) in
            if let completionHandler = completionHandler {
                let swiftError = ZendriveError.fromError(error)
                completionHandler(success, swiftError)
            }
        }
    }
}
