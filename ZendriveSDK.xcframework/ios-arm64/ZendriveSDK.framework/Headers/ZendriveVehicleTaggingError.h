//
//  ZendriveVehicleTaggingError.h
//  ZendriveSDK
//
//  Created by Abhishek Aggarwal on 15/04/20.
//  Copyright © 2020 Zendrive Inc. All rights reserved.
//

#ifndef ZendriveVehicleTaggingError_h
#define ZendriveVehicleTaggingError_h

/**
 * ZendriveVehicleTaggingError
 */
typedef NS_ENUM(int, ZendriveVehicleTaggingError) {

    /**
     * ZendriveSDK is not setup. This error is also returned in case SDK setup
     * has started but completion handler for setup is not called yet.
     */
    kZendriveVehicleTaggingErrorNotSetup = 0,

    /**
     * `ZendriveVehicleInfo` object passed to `+[ZendriveVehicleTagging associateVehicle:error:]`
     * is invalid because of one of the following reasons:-
     *
     *  1. It is nil.
     *  2. `ZendriveVehicleInfo.vehicleId` is nil or has more than 64 characters.
     *  3. `ZendriveVehicleInfo.vehicleId` doesn't satisfy `+[Zendrive isValidInputParameter:]`.
     *  4. `ZendriveVehicleInfo.bluetoothId` is not a valid mac address.
     */
    kZendriveVehicleTaggingErrorInvalidVehicleInfo = 1,

    /**
     * `+[ZendriveVehicleTagging associateVehicle:error:]` called for vehicle whose vehicleId
     * or bluetoothId or both conflicts with an already associated vehicle.
     */
    kZendriveVehicleTaggingErrorAssociatedVehicleConflict = 2,

    /**
     * `+[ZendriveVehicleTagging associateVehicle:error:]` called for more than two vehicles.
     */
    kZendriveVehicleTaggingErrorAssociatedVehiclesLimitExceeded = 3,

    /**
     * vehicleId passed to `+[ZendriveVehicleTagging dissociateVehicle:error:]`
     * is invalid because of one of the following reasons:-
     *
     *  1. It is nil.
     *  2. It has more than 64 characters.
     *  3. It doesn't satisfy `+[Zendrive isValidInputParameter:]`.
     */
    kZendriveVehicleTaggingErrorInvalidVehicleId = 4,

    /**
     * `+[ZendriveVehicleTagging dissociateVehicle:error:]` called for an unassociated vehicle.
     */
    kZendriveVehicleTaggingErrorVehicleNotAssociated = 5
};

#endif /* ZendriveVehicleTaggingError_h */
