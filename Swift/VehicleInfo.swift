//
//  VehicleInfo.swift
//  ZendriveSDKSwift
//
//  Created by Abhishek Aggarwal on 22/04/20.
//  Copyright © 2020 Zendrive Inc. All rights reserved.
//

import UIKit
import ZendriveSDK

/// Wrapper for meta-information related to a vehicle.
@objc(ZDVehicleInfo) public final class VehicleInfo: NSObject {

    ///
    /// The unique identifier for the vehicle.
    ///
    /// This should not be nil, should not have more than 64 characters
    /// and should satisfy `Zendrive.isValidInputParameter(_:)`.
    ///
    @objc public var vehicleId: String

    /// The mac address of vehicles's bluetooth device.
    @objc public var bluetoothId: String

    /// Initializer for `VehicleInfo`.
    @objc public override convenience init() {
        self.init(with: ZendriveVehicleInfo())
    }

    ///
    /// Initializer for `VehicleInfo`.
    ///
    /// - Parameters:
    ///     - vehicleId: The identifier for the vehicle.
    ///     - bluetoothId: The mac address of vehicle's bluetooth device.
    ///
    @objc public convenience init(vehicleId: String,
                                  bluetoothId: String) {
        let objcVehicleInfo =
            ZendriveSDK.ZendriveVehicleInfo(vehicleId: vehicleId,
                                            bluetoothId: bluetoothId)
        self.init(with: objcVehicleInfo)
    }

    init(with objcVehicleInfo: ZendriveVehicleInfo) {
        vehicleId = objcVehicleInfo.vehicleId
        bluetoothId = objcVehicleInfo.bluetoothId
    }

    func toObjcVehicleInfo() -> ZendriveVehicleInfo {
        return ZendriveVehicleInfo(vehicleId: vehicleId,
                                   bluetoothId: bluetoothId)
    }
}
