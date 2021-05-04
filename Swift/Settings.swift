//
//  Settings.swift
//  ZendriveSDKSwift
//
//  Created by Abhishek Aggarwal on 18/08/20.
//  Copyright © 2020 Zendrive Inc. All rights reserved.
//

import UIKit
import ZendriveSDK

/// This class surfaces errors in device or application settings that affects trip detection in the SDK.
@objc(ZDSettings) public class Settings: NSObject {

    /// List of errors that must be resolved for trip detection to work correctly.
    @objc public var errors: [SettingsError]

    /// Initializer for Settings
    @objc public init(errors: [SettingsError]) {
        self.errors = errors
        super.init()
    }

    func toObjcSettings() -> ZendriveSettings {
        let objcSettingsErrors = self.errors.map { (swiftSettingsError) in
            return swiftSettingsError.toObjcSettingsError()
        }
        return ZendriveSettings(errors: objcSettingsErrors)
    }

    static func fromObjcSettings(_ objcSettings: ZendriveSettings) -> Settings {
        let swiftSettingsErrors = objcSettings.errors.map { (objcSettingsError) in
            return SettingsError.fromObjcSettingsError(objcSettingsError)
        }
        return Settings(errors: swiftSettingsErrors)
    }
}
