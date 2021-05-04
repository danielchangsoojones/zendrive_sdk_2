//
//  ZendriveVehicleTagging.swift
//  ZendriveSDKSwift
//
//  Created by Abhishek Aggarwal on 22/04/20.
//  Copyright © 2020 Zendrive Inc. All rights reserved.
//

import UIKit
import ZendriveSDK

/// This class manages association and dissociation of vehicles to Zendrive SDK.
@objc(ZDZendriveVehicleTagging) public class ZendriveVehicleTagging: NSObject {

    /// Associates the vehicle to Zendrive SDK.
    ///
    /// After successful association of vehicle information, whenever Zendrive SDK will detect
    /// a connection to this bluetooth device while the user is driving, it will include this vehicleId
    /// in the tags array of `AnalyzedDriveInfo`.
    ///
    /// If the user connect to bluetooth of multiple associated vehicles during the drive
    /// the latest vehicleId will be used as tag.  Maximum of two vehicles can be associated.
    ///
    /// - Note: The bluetooth device of the associated vehicle needs to be the audio route for some
    /// duration of the drive for tagging to happen.
    ///
    /// - Parameter vehicleInfo: The `VehicleInfo` object to associate.
    ///
    /// Refer to `ZendriveVehicleTaggingError` to get details on the errors thrown by this method.
    ///
    /// Example:
    ///
    /// ```
    /// let vehicleInfo = VehicleInfo(vehicleId: "vehicleId",
    ///                               bluetoothId: "14:0F:C7:62:F8:9E")
    /// try ZendriveVehicleTagging.associateVehicle(vehicleInfo)
    ///  ```
    ///
    /// Bluetooth stereos in automobiles are primarily classic Bluetooth devices, which might not be discoverable from your app.
    /// When you associate the user's vehicle, ask the user to connect their stereo and play audio.
    /// Then, use APIs from AVFoundation framework to determine the current audio route and get the identifier of the device.
    /// Start with this code:
    ///
    /// ```
    ///  if let portDescription = AVAudioSession.sharedInstance().currentRoute.outputs.first {
    ///     // portDescription.uid will contain a string like "14:0F:C7:62:F8:9E-tacl" or "14:0F:C7:62:F8:9E-tsco".
    ///     // Trim the suffix to get the MAC address of the device
    ///     if let bluetoothId = portDescription.uid.components(separatedBy: "-").first {
    ///         // Send this MAC address as bluetoothId in associateVehicle:error: API.
    ///         let vehicleInfo = VehicleInfo(vehicleId: "vehicleId",
    ///                                       bluetoothId: bluetoothId)
    ///         try ZendriveVehicleTagging.associateVehicle(vehicleInfo)
    ///     }
    ///  }
    /// ```
    @objc public static func associateVehicle(_ vehicleInfo: VehicleInfo) throws {
        let objcVehicleInfo = vehicleInfo.toObjcVehicleInfo()
        do {
            try ZendriveSDK.ZendriveVehicleTagging.associateVehicle(objcVehicleInfo)
        } catch {
            throw ZendriveVehicleTaggingError.fromError(error) ?? error
        }
    }

    /// Dissociates the vehicle from Zendrive SDK.
    ///
    /// After successful dissociation of the vehicle, Zendrive SDK will stop tagging the trips for this vehicle.
    ///
    /// - Parameter vehicleId: The vehicleId of the vehicle which is to be dissociated.
    ///
    /// Refer to `ZendriveVehicleTaggingError` to get details on the errors thrown by this method.
    ///
    /// Example:
    ///
    /// ```
    /// let vehicleInfo = VehicleInfo(vehicleId: "vehicleId",
    ///                               bluetoothId: "14:0F:C7:62:F8:9E")
    /// try ZendriveVehicleTagging.dissociateVehicle(vehicleInfo.vehicleId)
    /// ```
    @objc public static func dissociateVehicle(_ vehicleId: String) throws {
        do {
            try ZendriveSDK.ZendriveVehicleTagging.dissociateVehicle(vehicleId)
        } catch {
            throw ZendriveVehicleTaggingError.fromError(error) ?? error
        }
    }

    /// - Returns:- The list of associated vehicles if sdk is setup, else nil.
    @objc public static func getAssociatedVehicles() -> [VehicleInfo]? {
        if let objcVehicleInfoArray =
            ZendriveSDK.ZendriveVehicleTagging.getAssociatedVehicles() {
            return objcVehicleInfoArray.map({ (objcVehicleInfo) -> VehicleInfo in
                return VehicleInfo(with: objcVehicleInfo)
            })
        } else {
            return nil
        }
    }

    /// - Returns:- The vehicleId if `DriveInfo.tags` array contains the vehicle  tag, else nil.
    @objc public static func getAssociatedVehicleForDrive(_ driveInfo: DriveInfo) -> String? {
        let objcDriveInfo = driveInfo.toObjcDriveInfo()
        return ZendriveSDK.ZendriveVehicleTagging.getAssociatedVehicle(forDrive: objcDriveInfo)
    }
}
