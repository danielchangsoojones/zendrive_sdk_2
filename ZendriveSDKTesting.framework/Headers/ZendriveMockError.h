//
//  ZendriveMockError.h
//  ZendriveMockDrive
//
//  Created by Sudeep Kumar on 20/12/18.
//  Copyright © 2018 Zendrive Inc. All rights reserved.
//

#ifndef ZendriveMockError_h
#define ZendriveMockError_h

/**
 *  The domain for `ZendriveMockDrive` errors. This value is used in the NSError class.
 */
NSString * __nonnull const kZendriveMockErrorDomain = @"ZendriveMockError";

/**
 * Error returned as code to NSError from `-[ZendriveMockDrive simulateDrive:error:]` public APIs in case of failures.
 */
typedef NS_ENUM(int, ZendriveMockError) {
    /**
     * This is not a mock drive build. Please refer to `kMockDriveBuildKey` for more info.
     */
    kZendriveErrorNotMockDriveBuild = 0,

    /**
     * Simulation run time is invalid. Simulation time must be a positive integer less than 5 hours.
     */
    kZendriveErrorInvalidRunTime = 1,

    /**
     * SDK is not setup.
     */
    kZendriveErrorSDKNotSetup = 2,

    /**
     * AutoDetection Mode is not ON.
     * Currently mock mode only works for automatic trip detection.
     */
    kZendriveErrorAutoDetectionModeNotOn = 3,

    /**
     * Simulation is already in progress.
     */
    kZendriveErrorSimulationAlreadyInProgress = 4,

    /**
     * The vehicleType set in the `ZendriveMockDrive` to be
     * simulated is different from the type set in driverAttributes
     * during the SDK setup.
     */
    kSimulationWithUnsupportedVehicleType = 5
};


#endif //ZendriveMockError_h
