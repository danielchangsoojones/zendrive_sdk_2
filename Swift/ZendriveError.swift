//
//  ZendriveError.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation

///  The domain for `Zendrive` errors. This value is used in the NSError class.
public let zendriveErrorDomain: String = "ZendriveError"

/// Error returned as code to NSError from `Zendrive` public APIs in case of
/// failures.
@objc(ZDZendriveError) public enum ZendriveError : Int {

    /// SDK Key used in setup is invalid
    case invalidSDKKeyString = 0


    /// Network not reachable, Zendrive.setup sometimes needs network call
    /// for authentication and to update SDK configuration to work. This error
    /// is returned whenever network is not available in these scenarios.
    case networkUnreachable = 1


    /// Zendrive SDK does not support the OS version of the device.
    case unsupportedOSVersion = 2


    /// Zendrive SDK does not support the device type.
    case deviceUnsupported = 3


    /// Invalid parameter was passed to the API.
    case invalidParams = 101


    /// Internal error.
    case internalFailure = 102


    /// Zendrive SDK is not setup. This error is also returned in case SDK setup
    /// has started but completion handler for setup is not called yet.
    case notSetup = 103


    /// Insurance Period hasn't changed from the previously active period, action ignored.
    /// This error may be returned from `ZendriveInsurance.startDrive(withPeriod1:)`, `ZendriveInsurance.startDrive(withPeriod2:completionHandler:)`,
    /// `ZendriveInsurance.startDrive(withPeriod3:completionHandler:)`.
    case insurancePeriodSame = 104


    /// Invalid `trackingId` passed for new drive. This error may be returned from
    /// `ZendriveInsurance.startDrive(withPeriod2:completionHandler:)`,
    /// `ZendriveInsurance.startDrive(withPeriod3:completionHandler:)`.
    case invalidTrackingId = 105


    /// Zendrive SDK is not torn down. This error is returned if the requested operation cannot
    /// be completed while the SDK is running like the wipeout API.
    case notTornDown = 106


    /// Some IO error occured while doing the operation. Refer to error description for more info.
    case ioError = 107

    /// Operation failed because `Region` provided was invalid.
    case invalidRegion = 108

    /// Operation Failed because provided `Region` is not supported for this application.
    case regionUnsupported = 109

    /// Changing region post setup is NOT allowed, until `Zendrive.wipeOut()` is called.
    case unauthorizedRegionSwitch = 110


    /// User is not authorized to use this application.
    case userDeprovisioned = 111

    /// Operation failed because the set vehicle type feature is disabled in the config.
    case unsupportedVehicleType = 112

    static func fromError(_ error: Error?) -> ZendriveError? {
        if let error = error {
            let objcError = error as NSError
            return ZendriveError(rawValue: objcError.code)
        }
        return nil
    }
}

extension ZendriveError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidSDKKeyString:
            return "Not a valid SDK key"
        case .networkUnreachable:
            return "Network not reachable"
        case .unsupportedOSVersion:
            return "Device OS version lower than iOS 11"
        case .deviceUnsupported:
            return "Device is not supported"
        case .invalidParams:
            return "Invalid character set found in input parameters"
        case .internalFailure:
            return "Internal error. Please setup Zendrive again."
        case .notSetup:
            return "API called before Zendrive Setup"
        case .insurancePeriodSame:
            return "Period hasn't changed, Action ignored."
        case .invalidTrackingId:
            return """
            trackingId is invalid. Refer
            to documentation for method isValidInputParameter: to
            view the list of disallowed characters. Action ignored.
            """
        case .notTornDown:
            return "SDK not torn down. Teardown SDK to continue"
        case .ioError:
            return "Some unknown I/O error has occured"
        case .invalidRegion:
            return "Not a valid region. Look at ZendriveRegion for allowed regions."
        case .regionUnsupported:
            return "Application is not allowed to use this region"
        case .unauthorizedRegionSwitch:
            return "Region change not allowed. Please wipeout SDK before changing region."
        case .userDeprovisioned:
            return "User is not allowed to use this region"
        case .unsupportedVehicleType:
            return "Motorcycle feature is currently not supported."
        @unknown default:
            return self.localizedDescription
        }
    }
}


