//
//  ZendriveVehicleTaggingError.swift
//  ZendriveSDKSwift
//
//  Created by Abhishek Aggarwal on 22/04/20.
//  Copyright © 2020 Zendrive Inc. All rights reserved.
//

import Foundation

/// The domain for `ZendriveVehicleTagging` errors. This value is used in the NSError class.
public let zendriveVehicleTaggingErrorDomain: String = "ZendriveVehicleTaggingError"

/// Error returned as code to NSError from `ZendriveVehicleTagging` public APIs
/// in case of failures.
@objc(ZDZendriveVehicleTaggingError) public enum ZendriveVehicleTaggingError: Int {

    /// Zendrive SDK is not setup. This error is also returned in case SDK setup
    /// has started but completion handler for setup is not called yet.
    case notSetup = 0

    /// `VehicleInfo` object passed to `ZendriveVehicleTagging.associateVehicle(_:)`
    /// is invalid because of one of the following reasons:-
    ///
    /// 1.  It is nil.
    /// 2.  `VehicleInfo.vehicleId` is nil or has more than 64 characters.
    /// 3.  `VehicleInfo.vehicleId` doesn't satisfy `Zendrive.isValidInputParameter(_:)`.
    /// 4.  `VehicleInfo.bluetoothId` is not a valid mac address.
    case invalidVehicleInfo = 1

    /// `ZendriveVehicleTagging.associateVehicle(_:)` called for vehicle whose vehicleId
    /// or bluetoothId or both conflicts with an already associated vehicle.
    case associatedVehicleConflict = 2

    /// `ZendriveVehicleTagging.associateVehicle(_:)` called for more than two vehicles.
    case associatedVehiclesLimitExceeded = 3

    /// vehicleId passed to `ZendriveVehicleTagging.dissociateVehicle(_:)`
    /// is invalid because of one of the following reasons:-
    ///
    /// 1. It is nil.
    /// 2. It has more than 64 characters.
    /// 3. It doesn't satisfy `+[Zendrive isValidInputParameter:]`.
    case invalidVehicleId = 4

    /// `ZendriveVehicleTagging.dissociateVehicle(_:)` called for an unassociated vehicle.
    case vehicleNotAssociated = 5

    static func fromError(_ error: Error?) -> ZendriveVehicleTaggingError? {
        if let error = error {
            let objcError = error as NSError
            return ZendriveVehicleTaggingError(rawValue: objcError.code)
        }
        return nil
    }
}

extension ZendriveVehicleTaggingError: LocalizedError {
    public var errorDescription: String? {
        switch(self) {
        case .notSetup:
            return "api called before Zendrive setup"
        case .invalidVehicleInfo:
            return "vehicleInfo is invalid because of one of the following reasons:-\n" +
                   "1. It is nil.\n" +
                   "2. vehicleInfo.vehicleId is nil or has more than 64 characters.\n" +
                   "3. vehicleInfo.vehicleId doesn't satisfy Zendrive.isValidInputParameter(_:)\n" +
                   "4. vehicleInfo.bluetoothId is not a valid mac address"
        case .associatedVehicleConflict:
            return "either vehicleId or bluetoothId or both conflicts " +
                   "with an already associated vehicle."
        case .associatedVehiclesLimitExceeded:
            return "can't associate more than two vehicles."
        case .invalidVehicleId:
            return "vehicleId is invalid because of one of the following reasons:-\n" +
                   "1. It is nil.\n" +
                   "2. It has more than 64 characters.\n" +
                   "3. It doesn't satisfy [Zendrive isValidInputParameter:].\n";
        case .vehicleNotAssociated:
            return "can't dissociate a vehicle which is not associated."
        @unknown default:
            return self.localizedDescription
        }
    }
}
