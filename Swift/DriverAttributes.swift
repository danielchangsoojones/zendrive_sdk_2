//
//  ZendriveDriverAttributes.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK


/// Keys for various properties returned by toJson method.
@objc(ZDDriverAttributesKeys) public class DriverAttributesKeys : NSObject {
    ///  Key for groupId returned by toJson method.
    let driverAttributesKeyGroup: String = "Group"

    /// Key for ServiceLevel returned by toJson method.
    let driverAttributesKeyPriority: String = "Priority"

    ///  Key for driver alias returned by toJson method.
    let driverAttributesKeyAlias: String = "Alias"
}


///
/// Enumeration for different service levels supported by `Zendrive` for a driver.
/// By default, drivers will be assigned to the default service level - ServiceLevel.default.
///
/// This is useful for applications which need special modes in the Zendrive SDK for different
/// drivers - e.g default mode for free users and a advanced mode for paid users.
///
/// By default, multiple service levels are not enabled for an application.
/// To be able to use different modes for your application, you should contact
/// <a href="mailto:support@zendrive.com">support@zendrive.com</a>
/// with your requirements and get that enabled for your application.
/// Otherwise, if this is not enabled for your application, all drivers get mapped to
/// ServiceLevel.default irrespective of the service level specified.
@objc(ZDServiceLevel) public enum ServiceLevel : Int32 {

    /// Default service level. This is most common level required by most of the applications
    /// that use `Zendrive` SDK.
    case levelDefault

    /// Special service level 1 that is enabled for a particular application.
    /// Contact <a href="mailto:support@zendrive.com">support@zendrive.com</a> with your
    /// requirements to get this enabled for your application.
    case level1

    func toObjcServiceLevel() -> ZendriveSDK.ZendriveServiceLevel {
        return ZendriveSDK.ZendriveServiceLevel(rawValue: self.rawValue) ?? ZendriveSDK.ZendriveServiceLevel.levelDefault
    }

    static func fromObjcServiceLevel(_ objcServiceLevel: ZendriveSDK.ZendriveServiceLevel) -> ServiceLevel {
        return ServiceLevel(rawValue: objcServiceLevel.rawValue) ?? ServiceLevel.levelDefault
    }
}

/// Type of vehicle used in the drive recorded by the Zendrive SDK.
/// A default vehicle type can be set using `DriverAttributes.setVehicleType(_:)`
/// in `DriverAttributes`.
/// The detected type is returned to the application in the `AnalyzedDriveInfo.vehicleType`
/// field of the `ZendriveDelegate.processAnalysis(ofDrive:)` callback.
@objc(ZDVehicleType) public enum VehicleType: Int32 {

    /// Indicates a car vehicle type.
    case car = 0

    /// Indicates a motorcycle vehicle type.
    case motorcycle = 1

    /// Indicates that the user was not driving.
    case unknown = -1

    func toObjcVehicleType() -> ZendriveSDK.ZendriveVehicleType {
        return ZendriveSDK.ZendriveVehicleType(rawValue: self.rawValue) ?? ZendriveSDK.ZendriveVehicleType.unknown
    }

    static func fromObjcVehicleType(_ objcVehicleType: ZendriveSDK.ZendriveVehicleType) -> VehicleType {
        return VehicleType(rawValue: objcVehicleType.rawValue) ?? VehicleType.unknown
    }
}

/// Additional attributes of a `Zendrive` driver.
///
/// The application can specify both predefined and custom attributes for a driver.
/// These attributes are associated with a SDK driverId at SDK initialization time.
/// In addition to predefined special attributes, up to 4 custom key value attributes
/// can be associated with a driver using the Zendrive SDK.
///
/// - Warning: All attribute keys can be atmost 64 characters in length.
/// - Warning: All attribute values can be atmost 1024 characters in length.
@objc(ZDDriverAttributes) public class DriverAttributes : NSObject, NSCopying {

    /// A unique id that associates the current user to a group. This groupId will
    /// be made available as a query parameter to filter users in the reports and API that
    /// `Zendrive` provides.
    ///
    /// For example, 'EastCoast' and 'WestCoast' can be groupIds to distinguish
    /// users from these regions. Another example would be using city names as groupIds. Check
    /// `Zendrive.isValidInputParameter(_:)` method to validate group id. Setting an invalid
    /// groupId is a no-op and would log an error.
    ///
    /// - Parameter groupId: A string representing the group of a user.
    ///
    /// - Returns: `true`, if the value was set, `false` otherwise.
    ///
    @objc public func setGroup(_ groupId: String) -> Bool {
        return self.internalDriverAttibutes.setGroup(groupId)
    }


    /// The service level of a driver. This is useful for applications where `Zendrive` supports
    /// different service levels for different drivers. See ServiceLevel
    /// for more information about this attribute.
    ///
    /// - Parameter serviceLevel: service tier of the user.
    @objc public func setServiceLevel(_ serviceLevel: ServiceLevel) -> Bool {
        return self.internalDriverAttibutes.setServiceLevel(serviceLevel.toObjcServiceLevel())
    }


    /// Set the custom attribute of the user.
    ///
    /// Up to 4 custom attributes can be set for a user.
    /// A new value for an existing key would be overwritten only if the value length
    /// is within 1024 characters, otherwise the original value would be retained.
    ///
    /// - Parameters:
    ///   - key: A key for the custom attribute. The maximum key length is 64 characters.
    ///   - value: Value of the custom attribute. The maximum value length is 1024 characters.
    ///
    /// - Returns: `true`, if the value was set, `false` otherwise.
    ///
    @objc public func setCustomAttribute(_ value: String, forKey key: String) -> Bool {
        return self.internalDriverAttibutes.setCustomAttribute(value, forKey: key)
    }


    /// Alias is a string placeholder offered as a convenience
    /// for developers to create a reference for a driver
    /// - Parameter alias: alias for the user.
    ///
    /// - Returns: `true`, if the value was set, `false` otherwise.
    @objc public func setAlias(_ alias: String) -> Bool {
        return self.internalDriverAttibutes.setAlias(alias)
    }

    /// Set the vehicle type for the driver.
    /// To enable the feature for any vehicle type other than `VehicleType.car`,
    /// please contact us at support@zendrive.com.
    /// - Parameter vehicleType: The `VehicleType` for the driver.
    ///   Passing `VehicleType.unknown` is a no-op.
    /// - Returns: `true`, if the value was set, `false` otherwise.
    @objc public func setVehicleType(_ vehicleType: VehicleType) -> Bool {
        return self.internalDriverAttibutes.setVehicleType(vehicleType.toObjcVehicleType())
    }

    /// Returns driver attributes as a json string. Empty string if json serialization
    /// fails.
    @objc public func asJson() -> String {
        return self.internalDriverAttibutes.asJson()
    }


    /// Returns the driver attributes as a dictionary.
    @objc public func asDictionary() -> [AnyHashable : Any] {
        return self.internalDriverAttibutes.asDictionary()
    }

    /// NSCopying protocol confirmance
    @objc public func copy(with zone: NSZone? = nil) -> Any {
        let copiedObjcDriverAttrs: ZendriveSDK.ZendriveDriverAttributes = self.internalDriverAttibutes?.copy(with: zone) as! ZendriveDriverAttributes
        return DriverAttributes(with: copiedObjcDriverAttrs)
    }

    func asObjcDriverAttributes() -> ZendriveSDK.ZendriveDriverAttributes? {
        return internalDriverAttibutes
    }

    var internalDriverAttibutes: ZendriveSDK.ZendriveDriverAttributes!

    /// Creates a `DriverAttributes` object.
    @objc public override convenience init() {
        self.init(with: ZendriveSDK.ZendriveDriverAttributes())
    }

    init(with internalDriverAttibutes: ZendriveSDK.ZendriveDriverAttributes) {
        self.internalDriverAttibutes = internalDriverAttibutes

    }
}
