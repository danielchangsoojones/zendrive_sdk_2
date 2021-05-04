//
//  ZendriveMockDrive.h
//  ZendriveMockDrive
//
//  Created by Zendrive Inc on 19/11/18.
//  Copyright © 2018 Zendrive Inc. All rights reserved.
//

#import "ZendriveMockEventBuilder.h"

#import "ZendriveMockDriveBuilder.h"
#import "ZendriveMockError.h"
#import "ZendriveMockConstants.h"
#import "ZendriveMockRangeEventBuilder.h"
#import "ZendriveMockPointEventBuilder.h"
#import "ZendriveMockAggressiveAccelerationEventBuilder.h"
#import "ZendriveMockAccidentEventBuilder.h"
#import "ZendriveMockHardBrakeEventBuilder.h"
#import "ZendriveMockHardTurnEventBuilder.h"
#import "ZendriveMockOverspeedingEventBuilder.h"
#import "ZendriveMockPhoneScreenInteractionEventBuilder.h"
#import "ZendriveMockPhoneHandlingEventBuilder.h"
#import "ZendriveMockStopSignViolationEventBuilder.h"
#import "ZendriveMockAccidentInfo.h"

#import "ZendriveMockSDKHeaders.h"

/**
 * Information of the drive to be simulated. This information will be used in the [ZendriveDriveInfo](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveDriveInfo.html) and [AccidentInfo](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveAccidentInfo.html) objects returned by the ZendriveSDK callbacks via [ZendriveDelegateProtocol](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Protocols/ZendriveDelegateProtocol.html).
 *
 * Currently only processStartOfDrive, processEndOfDrive, processAnalysisOfDrive and processAccidentDetected ZendriveSDK callbacks will be received by the application.<br>
 * Use `ZendriveMockDriveBuilder` to construct `ZendriveMockDrive` instances.<br>
 * To build a predefined mock drive, use `+[ZendriveMockDriveBuilder presetMockDrive:]`.<br>
 * To build a custom mock drive, use `+[ZendriveMockDriveBuilder newAutoDriveBuilderWithStartTimestamp:endTimestamp:]`.
 */
@interface ZendriveMockDrive : NSObject

/**
 * The unique Id for this drive
 */
@property (nonatomic, nonnull, readonly) NSString *driveId;

/**
 * The type of the drive. This decides what other info parameters will be populated. See [here](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveDriveType.html).
 *
 * A drive callback will be sent even for falsely detected drives or for non-automobile
 * trips (Eg. biking, public transport).
 */
@property (nonatomic, assign, readonly) ZendriveDriveType driveType;

/**
 * Whether the user was a driver or a passenger. See [here](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveUserMode.html).
 */
@property (nonatomic, assign, readonly) ZendriveUserMode userMode;

/**
 * The [start timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveDriveInfo.html#/c:objc(cs)ZendriveDriveInfo(py)startTimestamp) of trip in milliseconds since epoch.
 */
@property (nonatomic, assign, readonly) long long startTimestamp;

/**
 * The [end timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveDriveInfo.html#/c:objc(cs)ZendriveDriveInfo(py)endTimestamp) of trip in milliseconds since epoch.
 */
@property (nonatomic, assign, readonly) long long endTimestamp;

/**
 * The [average speed](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveDriveInfo.html#/c:objc(cs)ZendriveDriveInfo(py)averageSpeed) of trip in metres/second.
 */
@property (nonatomic, assign, readonly) double averageSpeed;

/**
 *  The [tags](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveDriveInfo.html#/c:objc(cs)ZendriveDriveInfo(py)tags)
 */
@property (nonatomic, strong, nonnull, readonly) NSArray<ZendriveTagInfo *> *tags;

/**
 * The [maximum speed](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveDriveInfo.html#/c:objc(cs)ZendriveDriveInfo(py)maxSpeed) of trip in metres/second.
 */
@property (nonatomic, assign, readonly) double maxSpeed;

/**
 * The [distance](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveDriveInfo.html#/c:objc(cs)ZendriveDriveInfo(py)distance) of the trip in metres.
 */
@property (nonatomic, assign, readonly) double distance;

/**
 * The [vehicleType](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveDriveInfo.html#/c:objc(cs)ZendriveDriveInfo(py)vehicleType) of the trip.
 */
@property (nonatomic, readonly) ZendriveVehicleType vehicleType;

/**
 * A list of [ZendriveLocationPoint](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveLocationPoint.html) objects corresponding to this trip in
 * increasing order of timestamp. The first point corresponds to trip start location
 * and last to trip end location.
 *
 * This is a sampled approximation of the drive which gives an indication of
 * the path taken by the driver. It is not the full detailed location data of the drive.
 * If no waypoints are recorded during the drive, this is an empty array.
 */
@property (nonatomic, strong, nonnull, readonly) NSArray<ZendriveLocationPoint *> *waypoints;

/**
 * List of [ZendriveEvent](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.h) objects.
 * This array is populated using `ZendriveMockEventBuilder`. See `-[ZendriveMockDriveBuilder addEventBuilder:]`
 */
@property (nonatomic, strong, nonnull, readonly) NSArray<ZendriveEvent *> *events;

/**
 * The event ratings for this trip. See [here](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEventRatings.html)
 */
@property (nonatomic, strong, nonnull, readonly) ZendriveEventRatings *eventRatings;

/**
 * List of `ZendriveMockAccidentInfo` objects.
 * This array is populated using `ZendriveMockEventBuilder` (only for `ZendriveMockAccidentEventBuilder` events). See `-[ZendriveMockDriveBuilder addEventBuilder:]`
 */
@property (nonatomic, strong, nonnull, readonly) NSArray<ZendriveMockAccidentInfo *> *accidentInfos;

/**
 * The driving behaviour score for this trip. See [here](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveDriveScore.html)
 */
@property (nonatomic, strong, nonnull, readonly) ZendriveDriveScore *score;

/**
 * The position of the phone during this trip. See [this](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendrivePhonePosition.html).
 */
@property (nonatomic, readonly) ZendrivePhonePosition phonePosition;

/**
 * Delay (from trip start), in milliseconds, with which trip analysis callback should arrive.
 */
@property (nonatomic, readonly) int tripStartDelayMillis;

/**
 * Delay (from trip end), in milliseconds, with which trip end callback should arrive.
 */
@property (nonatomic, readonly) int tripEndDelayMillis;

/**
 * Delay (from trip end callback), in milliseconds, with which trip analysis callback should arrive.
 */
@property (nonatomic, readonly) int tripAnalysisDelayMillis;

/**
 * Start simulation of this mock drive. SDK callbacks will be received at configured times.
 * Some conditions are required to be met before a drive can be simulated. For example:
 * - Must be a mock drive build. See `ZendriveMockError`
 * - SDK must be setup. See [[Zendrive setupWithConfiguration:delegate:completionHandler:]](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/Zendrive.html#/c:objc(cs)Zendrive(cm)setupWithConfiguration:delegate:completionHandler:)
 * - [AutoDetection mode](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/Zendrive.html#/c:objc(cs)Zendrive(cm)setDriveDetectionMode:) must be ON.
 * - Only one drive can be simulated at any time. Calling this when another simulation is going on will result in error.
 *
 * @param runTimeInMillis Duration of this simulation. The configured trip might be very long. But the simulation (trip start to trip analysis) will happen in timeframe of duration runTimeInMillis.
 *
 * @param error A valid error of `kZendriveMockErrorDomain` is returned in case of a failure.
 * Refer to `ZendriveMockError` for more details on the errors.
 */
- (void)simulateDrive:(long long)runTimeInMillis
                error:(NSError *_Nullable*_Nullable)error;

@end
