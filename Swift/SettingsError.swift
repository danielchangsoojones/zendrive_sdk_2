//
//  SettingsError.swift
//  ZendriveSDKSwift
//
//  Created by Abhishek Aggarwal on 18/08/20.
//  Copyright © 2020 Zendrive Inc. All rights reserved.
//

import UIKit
import ZendriveSDK

/// Error type for SettingError
@objc(ZDSettingsErrorType) public enum SettingsErrorType: Int32 {

    /// The location authorization status is determined but the user hasn't granted
    /// the **Always** location authorization to the application.
    case locationPermissionNotAuthorized = 0

    /// The activity authorization status is determined but the user has **not authorized** application to
    /// access the motion and fitness data. This error will only be thrown if activity based trip detection
    /// is enabled for the application.
    ///
    /// - Note: if the current drive detection is **not** `DriveDetectionMode.autoON`, this
    /// error will not be thrown.
    case activityPermissionNotAuthorized = 1
}


/// This class represent an error in device or application settings that is affecting
/// the ability of the SDK to detect trips.
@objc(ZDSettingsError) public class SettingsError: NSObject {

    /// Error type for SettingsError
    @objc public var errorType: SettingsErrorType

    /// Initializer for SettingsError
    @objc public init(errorType: SettingsErrorType) {
        self.errorType = errorType
        super.init()
    }

    func toObjcSettingsError() -> ZendriveSettingsError {
        return
            ZendriveSettingsError(errorType:
                ZendriveSettingsErrorType(rawValue:
                    self.errorType.rawValue) ?? ZendriveSettingsErrorType.locationPermissionNotAuthorized)
    }

    static func fromObjcSettingsError(_ objcSettingsError: ZendriveSettingsError) -> SettingsError {
        return
            SettingsError(errorType:
                SettingsErrorType(rawValue:
                    objcSettingsError.errorType.rawValue) ?? SettingsErrorType.locationPermissionNotAuthorized)
    }
}
