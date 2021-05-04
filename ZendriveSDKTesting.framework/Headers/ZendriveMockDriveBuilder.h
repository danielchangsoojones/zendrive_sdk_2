//
//  ZendriveMockDriveBuilder.h
//  ZendriveMockDrive
//
//  Created by Zendrive Inc on 19/11/18.
//  Copyright © 2018 Zendrive Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZendriveMockSDKHeaders.h"

/**
 * Few predefined trips are presented here. Use `+[ZendriveMockDriveBuilder presetMockDrive:]` to
 * get the corresponding predefined `ZendriveMockDriveBuilder`. It can be build to get a `ZendriveMockDrive` object and then simulated
 * using `-[ZendriveMockDrive simulateDrive:error:]`.
 */
typedef NS_ENUM(int, ZendrivePresetTripType) {
    /**
     * A `ZendrivePresetTripType` for an urban trip.<br>
     * <b>Distance</b>: 4445 meters<br>
     * <b>Duration</b>: 10 minutes<br>
     * <b>Events</b>: [Hard brake](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventHardBrake) and [Aggressive Acceleration](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventAggressiveAcceleration)
     */
    Urban10MinTrip = 0,

    /**
     * A `ZendrivePresetTripType` for a highway trip.<br>
     * <b>Distance</b>: 59112 meters<br>
     * <b>Duration</b>: 58 minutes<br>
     * <b>Events</b>: [Hard brake](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventHardBrake), [overspeeding](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventOverSpeeding) and [phone handling](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventPhoneHandling)
     */
    Highway60MinTrip = 1,
    /**
     * A `ZendrivePresetTripType` for an urban trip with collision.<br>
     * <b>Distance</b>: 50130 meters<br>
     * <b>Duration</b>: 31 minutes<br>
     * <b>Events</b>: [Hard brake](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventHardBrake), [accident/collision](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventAccident) and [hard turn](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventHardTurn)
     */
    Urban30MinWithCollisionTrip = 2,
    /**
    * A `ZendrivePresetTripType` for an urban trip with multiple callbacks for the same collision.<br>
    * <b>Distance</b>: 50130 meters<br>
    * <b>Duration</b>: 31 minutes<br>
    * <b>Events</b>: [Hard brake](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventHardBrake), [accident/collision](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventAccident) and [hard turn](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventHardTurn)
    */
    Urban30MinWithMultipleCollisionCallbackTrip = 3,
    /**
     * A `ZendrivePresetTripType` for [non-driving trip](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveDriveType.html#/c:@E@ZendriveDriveType@ZendriveDriveTypeNonDriving)<br>
     * <b>Distance</b>: 74990 meters<br>
     * <b>Duration</b>: 66 minutes<br>
     */
    NonDriving60MinTrip = 4,
    /**
     * A `ZendrivePresetTripType` for an [invalid trip](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveDriveType.html#/c:@E@ZendriveDriveType@ZendriveDriveTypeInvalid)<br>
     * <b>Distance</b>: 1624 meters<br>
     * <b>Duration</b>: 14.7 seconds<br>
     */
    InvalidTrip = 5,

    /**
     * A `ZendrivePresetTripType` for an urban motorcycle trip.<br>
     * <b>Distance</b>: 4445 meters<br>
     * <b>Duration</b>: 10 minutes<br>
     * <b>Events</b>: [Hard brake](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventHardBrake) and [Aggressive Acceleration](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventAggressiveAcceleration)
     */
    Urban10MinMotorcycleTrip = 6
};

NS_ASSUME_NONNULL_BEGIN


@class ZendriveMockDrive, ZendriveMockEventBuilder;
/**
 * Builder class for `ZendriveMockDrive`. Only auto trips supported for now.
 *
 * Sample Usage (Preset Drives):
 * ```
 * #import <ZendriveSDKTesting/ZendriveMockDrive.h>
 * ZendriveMockDriveBuilder *mockDriveBuilder = [ZendriveMockDriveBuilder presetMockDrive:Urban10MinTrip];
 * ZendriveMockDrive *drive = [mockDriveBuilder build];
 * ```
 *
 * Sample Usage (Custom Drives):
 * ```
 * ZendriveMockDriveBuilder *builder = [ZendriveMockDriveBuilder newAutoDriveBuilderWithStartTimestamp:tripStartTs endTimestamp:tripEndTs];
 * [builder setAverageSpeed:5];
 * [builder setDriveType:ZendriveDriveTypeDrive];

 * // set waypoints
 * NSMutableArray<ZendriveLocationPoint *> *points = [[NSMutableArray alloc] init];
 * ZendriveLocationPoint point1 = [[ZendriveLocationPoint alloc] initWithTimestamp:locTimestamp latitude:locLatitude longitude:locLongitude];
 * [points addObject:point1];
 * //create and add more points
 * [builder setWaypoints:points];

 * // set events
 * ZendriveMockAccidentEventBuilder *accidentBuilder = [[ZendriveMockAccidentEventBuilder alloc] initWithTimestamp:accidentTimestamp tripTimestamp:tripStartTs accidentId:@”mockAccident” confidence:ZendriveAccidentConfidenceHigh];
 * [builder addEventBuilder:accidentBuilder];
 *
 * // set vehicleId tag for the drive
 * [builder setVehicleIdTag:@"vehicleId"];
 *
 * // set vehicleType for the drive
 * [builder setVehicleType:ZendriveVehicleTypeCar];
 *
 * // set delays
 * [builder setTripStartDelayMillis:1000];
 * [builder setTripEndDelayMillis:2000];
 * ```
 */
@interface ZendriveMockDriveBuilder : NSObject

/**
 * Create and return a new auto drive builder with given start and end timestamp.
 */
+ (ZendriveMockDriveBuilder *)newAutoDriveBuilderWithStartTimestamp:(long long)startTimestamp
                                                       endTimestamp:(long long)endTimestamp;

/**
 * Return a new `ZendriveMockDriveBuilder` represented by `ZendrivePresetTripType`.
 * The builder can be modified and then build to get a `ZendriveMockDrive`.
 * This can then be simulated using `-[ZendriveMockDrive simulateDrive:error:]`.
 */
+ (ZendriveMockDriveBuilder *)presetMockDrive:(ZendrivePresetTripType)presetTripType;

/**
 * Set the `ZendriveMockDrive.averageSpeed` of trip in metres/second.
 */
- (ZendriveMockDriveBuilder *)setAverageSpeed:(double)averageSpeed;

/**
 *  Set the vehicleId to be returned as tag for the drive.
 *
 *  @see (https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveDriveInfo.html#/c:objc(cs)ZendriveDriveInfo(py)tags)
 */
- (ZendriveMockDriveBuilder *)setVehicleIdTag:(NSString  * _Nonnull)vehicleId;

/**
 * Set the `ZendriveMockDrive.distance`.
 */
- (ZendriveMockDriveBuilder *)setDistance:(double)distanceMeters;

/**
 * Set the [drive type](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveDriveType.html).
 * Default value is [ZendriveDriveTypeInvalid](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveDriveType.html#/c:@E@ZendriveDriveType@ZendriveDriveTypeInvalid).
 */
- (ZendriveMockDriveBuilder *)setDriveType:(ZendriveDriveType)driveType;

/**
 * Set the [vehicleType](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveVehicleType.html).
 *
 * For trip with drive type as [ZendriveDriveTypeDrive](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveDriveType.html#/c:@E@ZendriveDriveType@ZendriveDriveTypeDrive), the default value is [ZendriveVehicleTypeCar](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveVehicleType.html#/c:@E@ZendriveVehicleType@ZendriveVehicleTypeCar).
 * For trip with drive type as [ZendriveDriveTypeNonDriving](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveDriveType.html#/c:@E@ZendriveDriveType@ZendriveDriveTypeNonDriving) or [ZendriveDriveTypeInvalid](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveDriveType.html#/c:@E@ZendriveDriveType@ZendriveDriveTypeInvalid), vehicleType will be defaulted to [ZendriveVehicleTypeUnknown](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveVehicleType.html#/c:@E@ZendriveVehicleType@ZendriveVehicleTypeUnknown).
 *
 * @note if [ZendriveVehicleTypeUnknown](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveVehicleType.html#/c:@E@ZendriveVehicleType@ZendriveVehicleTypeUnknown) is passed, the default vehicleType will be used.
 *
 */
- (ZendriveMockDriveBuilder *)setVehicleType:(ZendriveVehicleType)vehicleType;

/**
 * Add a `ZendriveMockEventBuilder`.
 */
- (ZendriveMockDriveBuilder *)addEventBuilder:(ZendriveMockEventBuilder *)eventBuilder;

/**
 * Clear all event builders.
 */
- (ZendriveMockDriveBuilder *)clearEventBuilders;

/**
 * Set `ZendriveMockDrive.maxSpeed`.
 */
- (ZendriveMockDriveBuilder *)setMaxSpeed:(double)maxSpeed;

/**
 * Set the [driving behaviour score](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveDriveScore.html) for this trip.
 * Default value of score is -1.
 */
- (ZendriveMockDriveBuilder *)setScore:(ZendriveDriveScore *)driveScore;

/**
 * Set the [event ratings](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEventRatings.html) for this trip.
 */
- (ZendriveMockDriveBuilder *)setEventRatings:(ZendriveEventRatings *)eventRatings;

/**
 * Set the [user mode](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveUserMode.html).
 * Default value is [ZendriveUserModeDriver](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveUserMode.html#/c:@E@ZendriveUserMode@ZendriveUserModeDriver).
 */
- (ZendriveMockDriveBuilder *)setUserMode:(ZendriveUserMode)userMode;

/**
 * Set `ZendriveMockDrive.waypoints`.
 */
- (ZendriveMockDriveBuilder *)setWayPoints:(NSArray<ZendriveLocationPoint *> *)waypoints;

/**
 * Set `ZendriveMockDrive.tripStartDelayMillis`.
 */
- (ZendriveMockDriveBuilder *)setTripStartDelayMillis:(int)tripStartDelayMillis;

/**
 * Set `ZendriveMockDrive.tripEndDelayMillis`.
 */
- (ZendriveMockDriveBuilder *)setTripEndDelayMillis:(int)tripEndDelayMillis;

/**
 * Set `ZendriveMockDrive.tripAnalysisDelayMillis`.
 */
- (ZendriveMockDriveBuilder *)setTripAnalysisDelayMillis:(int)tripAnalysisDelayMillis;

/**
 * Set `ZendriveMockDrive.phonePosition`.
 */
- (ZendriveMockDriveBuilder *)setPhonePosition:(ZendrivePhonePosition)phonePosition;

/**
 * Build and return a `ZendriveMockDrive` object.
 *
 * This might throw a `ZendriveInvalidMockDriveException` if :-
 *
 *  - `ZendriveMockDrive.startTimestamp` is greater than or equal to `ZendriveMockDrive.endTimestamp`.
 *  - Any of `ZendriveMockDrive.tripStartDelayMillis`, `ZendriveMockDrive.tripEndDelayMillis` or
 *   `ZendriveMockDrive.tripAnalysisDelayMillis` is less than 0.
 *  - vehicleId passed to `-setVehicleIdTag:` is invalid. Either it contains disallowed characters or it is longer than 64 characters.
 *  - `ZendriveMockDrive.vehicleType` is **not** set to [ZendriveVehicleTypeUnknown](https://zendrive-root.bitbucke.io/ios/docs/sdk-7.0.0/Enums/ZendriveVehicleType.html#/c:@E@ZendriveVehicleType@ZendriveVehicleTypeUnknown) for a trip with `ZendriveMockDrive.driveType`
 *  as [ZendriveDriveTypeNonDriving](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveDriveType.html#/c:@E@ZendriveDriveType@ZendriveDriveTypeNonDriving) or [ZendriveDriveTypeInvalid](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveDriveType.html#/c:@E@ZendriveDriveType@ZendriveDriveTypeInvalid).
 *
 */
- (ZendriveMockDrive *)build;

@end

NS_ASSUME_NONNULL_END
