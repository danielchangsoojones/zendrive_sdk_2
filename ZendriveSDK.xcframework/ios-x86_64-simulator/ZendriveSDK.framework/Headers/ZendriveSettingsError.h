//
//  ZendriveSettingsError.h
//  ZendriveSDK
//
//  Created by Abhishek Aggarwal on 03/08/20.
//  Copyright © 2020 Zendrive Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Error type for ZendriveSettingError
 */
typedef NS_ENUM(int, ZendriveSettingsErrorType) {
    /**
     * The location authorization status is determined but the user hasn't
     * granted the **Always** location authorization to the application.
     */
    kZendriveSettingsErrorTypeLocationPermissionNotAuthorized = 0,

    /**
     * The activity authorization status is determined but the user has **not authorized** application to
     * access the motion and fitness data. This error will only be thrown if activity based trip detection
     * is enabled for the application.
     *
     * @note if the current drive detection is **not** `ZendriveDriveDetectionMode.ZendriveDriveDetectionModeAutoON`, this
     * error will not be thrown.
     */
    kZendriveSettingsErrorTypeActivityPermissionNotAuthorized = 1
};

/**
 * This class represent an error in device or application settings that is affecting
 * the ability of the SDK to detect trips.
 */
@interface ZendriveSettingsError : NSObject

/**
 * Error type for ZendriveSettingError
 */
@property (nonatomic) ZendriveSettingsErrorType errorType;

/**
 * Initializer for ZendriveSettingsError
 */
- (instancetype)initWithErrorType:(ZendriveSettingsErrorType)errorType;

@end

NS_ASSUME_NONNULL_END
