//
//  ZendriveConfiguration.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK

///  Dictates the functioning of Zendrive's drive detection.
@objc(ZDDriveDetectionMode) public enum DriveDetectionMode : Int32 {


    /// `Zendrive` SDK will automatically track drives in background in
    /// this mode once the SDK is setup. At the same time, the application can invoke
    /// `Zendrive.startManualDrive(_:completionHandler:)` to explicitly start recording a drive.
    /// This is the Default mode.
    case autoON


    /// In this mode auto drive-detection is disabled. All other APIs on `Zendrive`
    /// can be invoked independent of this mode. For recording trips in this mode, the
    /// application has to explicitly invoke the `Zendrive.startManualDrive(_:completionHandler:)` method.
    case autoOFF


    /// In this mode drive detection is controlled by period APIs present in
    /// `ZendriveInsurance` class. Only `ZendriveInsurance` APIs should be used in
    /// this mode to control Zendrive SDK behavior.
    case insurance

    func toObjcDriveDetection() -> ZendriveSDK.ZendriveDriveDetectionMode {
        return ZendriveSDK.ZendriveDriveDetectionMode(rawValue: self.rawValue) ?? ZendriveSDK.ZendriveDriveDetectionMode.autoON
    }

    static func fromObjcDriveDetection(_ objcDriveDetection: ZendriveSDK.ZendriveDriveDetectionMode) -> DriveDetectionMode {
        return DriveDetectionMode(rawValue: objcDriveDetection.rawValue) ?? DriveDetectionMode.autoON
    }
}

/// Dictates the region where user's data will reside.
@objc(ZDRegion) public enum Region: Int32 {

    /// Indicates that the user's data will reside in US region.
    /// This is the default region.
    case us

    /// Indicates that the user's data will reside in EU region.
    case eu

    func toObjcRegion() -> ZendriveSDK.ZendriveRegion {
        return ZendriveSDK.ZendriveRegion(rawValue: self.rawValue) ?? ZendriveSDK.ZendriveRegion.US
    }

    static func fromObjcRegion(_ objcRegion: ZendriveSDK.ZendriveRegion) -> Region {
        return Region(rawValue: objcRegion.rawValue) ?? Region.us
    }
}

///  This class contains parameters required by `Zendrive` during setup.
@objc(ZDConfiguration) public class Configuration : NSObject, NSCopying {

    /// Your application key.
    ///
    /// Pass in the application key for your app. If you don't
    /// have one, please create one at https://developers.zendrive.com/signup
    ///
    /// This field is REQUIRED and should be a valid string.
    /// Check `Zendrive.isValidInputParameter(_:)` to validate this field. Nil strings are not
    /// allowed.
    /// Passing invalid string would cause SDK setup to fail.
    @objc public var applicationKey: String!


    /// Unique ID for the current user. This can be any ID used by your app to
    /// identify its users. This is the ID which will be used in Zendrive reports.
    /// Use `Zendrive.isValidInputParameter(_:)` to verify that userId is valid.
    ///
    /// This field is REQUIRED and should be a valid string.
    /// Check `Zendrive.isValidInputParameter(_:)` to validate this field. Nil strings are not
    /// allowed.
    /// Passing invalid string would cause SDK setup to fail.
    @objc public var driverId: String!

    /// Attributes for the current user. These attributes are stored on the server
    /// and are provided in Zendrive's APIs. Any existing attributes would be overwritten
    /// on the server when a non-nil value for this param is passed. Passing nil is a no-op.
    ///
    /// Use this param to provide meta-information about the user like name,
    /// email, groupId or any custom attributes you wish to provide.
    /// Default value is nil.
    @objc public var driverAttributes: DriverAttributes?

    /// Use this mode to control the SDK's behaviour for detecting drives
    /// automatically. This mode can be changed at a later point using
    /// `Zendrive.setDriveDetectionMode(_:completionHandler:)` method.
    ///
    /// Applications which do not want the SDK to continuously track drives in
    /// background should set this value to `DriveDetectionMode.autoOFF`. With this, the
    /// application needs to call `Zendrive.startManualDrive(_:completionHandler:)` method to record drives. In case the application
    /// wants to enable auto drive detection only for a fixed duration (like when the driver is
    /// on-duty), use method `Zendrive.setDriveDetectionMode(_:completionHandler:)`
    /// to change the mode to `DriveDetectionMode.autoON` for that period and set it
    /// back to `DriveDetectionMode.autoOFF` (once the driver goes off-duty).
    ///
    @objc public var driveDetectionMode: DriveDetectionMode

    /// This field specifies the region where user's data will reside.

    /// This field is OPTIONAL.
    /// Default value is `Region.us`.
    ///
    /// Application will not be allowed to change the region post Zendrive SDK setup.
    /// To change region application should call `Zendrive.wipeOut()` api first.
    @objc public var region: Region

    /// - Warning: This property is deprecated and need to be set to `false`. The application should
    /// completely control the user experience related to asking location permission.
    ///
    /// Developers can set this property value to `false` to have complete control on the
    /// location permission User Experience.
    ///
    /// If set to `true`, Zendrive SDK would trigger location permission dialog on setup if
    /// permission is not available.
    /// `ZendriveDelegate.processLocationApproved()` and `ZendriveDelegate.processLocationDenied()`
    /// callbacks are not sent to Zendrive delegate if this property is set to `false`.
    ///
    /// The default value of this property is `true`.
    @available(*, deprecated, message: "This property needs to be set to false and the application should completely control the user experience related to asking location permission.")
    @objc public var managesLocationPermission: Bool


    /// - Warning: This property is deprecated and need to be set to `false`. The application should
    /// completely control the user experience related to asking motion and fitness permission.
    ///
    /// Developers can set this property value to `false` to have complete control on the
    /// fitness and activity permission User Experience.
    ///
    /// If set to `true`, Zendrive SDK would trigger fitness and activity permission dialog on setup if
    /// permission is not available.
    ///
    /// The default value of this property is `true`.
    @available(*, deprecated, message: "This property needs to be set to false and the application should completely control the user experience related to asking motion and fitness permission.")
    @objc public var managesActivityPermission: Bool


    /// Developers have to set this property to `true` if the app implements multiple accident callbacks -
    /// [potential callback][potentialId] and [final callback][finalId].
    ///
    /// If set to `false`, the SDK assumes that [potential accident callback][potentialId] is not implemented.
    ///
    /// The default value of this property is `false`.
    ///
    /// [potentialId]: ../Protocols/ZendriveDelegate.html#/c:@M@ZendriveSDKSwift@objc(pl)ZendriveDelegate(im)processPotentialAccidentDetected:
    /// [finalId]: ../Protocols/ZendriveDelegate.html#/c:@M@ZendriveSDKSwift@objc(pl)ZendriveDelegate(im)processAccidentDetected:
    @objc public var implementsMultipleAccidentCallbacks: Bool

    /// Creates a Zendrive `Configuration` object.
    @objc public override convenience init() {
        let config: ZendriveSDK.ZendriveConfiguration = ZendriveSDK.ZendriveConfiguration()
        self.init(with: config)
    }

    init(with config: ZendriveSDK.ZendriveConfiguration) {
        if let attrs = config.driverAttributes {
            self.driverAttributes = DriverAttributes(with: attrs)
        }

        self.driverId = String(utf8String: config.driverId)
        self.applicationKey = String(utf8String: config.applicationKey)
        self.driveDetectionMode = DriveDetectionMode.fromObjcDriveDetection(config.driveDetectionMode)
        self.region = Region.fromObjcRegion(config.region)
        self.managesLocationPermission = config.managesLocationPermission
        self.managesActivityPermission = config.managesActivityPermission
        self.implementsMultipleAccidentCallbacks = config.implementsMultipleAccidentCallbacks
    }

    convenience init?(with config: ZendriveSDK.ZendriveConfiguration?) {
        if let config = config {
            self.init(with: config)
        } else {
            return nil
        }
    }

    func asObjcZendriveConfig() -> ZendriveSDK.ZendriveConfiguration {
        let config: ZendriveSDK.ZendriveConfiguration = ZendriveSDK.ZendriveConfiguration()
        config.applicationKey = self.applicationKey
        config.driveDetectionMode = self.driveDetectionMode.toObjcDriveDetection()
        config.region = self.region.toObjcRegion()
        config.driverAttributes = self.driverAttributes?.asObjcDriverAttributes()
        config.driverId = self.driverId
        config.managesActivityPermission = self.managesActivityPermission
        config.managesLocationPermission = self.managesLocationPermission
        config.implementsMultipleAccidentCallbacks = self.implementsMultipleAccidentCallbacks
        return config
    }

    /// Creates a copy of Zendrive `Configuration` object.
    @objc public func copy(with zone: NSZone? = nil) -> Any {
        let config: ZendriveSDK.ZendriveConfiguration = self.asObjcZendriveConfig()
        let copiedConfig: ZendriveSDK.ZendriveConfiguration = config.copy(with: zone) as! ZendriveConfiguration
        return Configuration(with: copiedConfig)
    }
}
