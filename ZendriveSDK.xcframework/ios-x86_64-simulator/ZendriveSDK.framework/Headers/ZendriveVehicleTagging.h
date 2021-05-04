//
//  ZendriveVehicleTagging.h
//  ZendriveSDK
//
//  Created by Abhishek Aggarwal on 15/04/20.
//  Copyright © 2020 Zendrive Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZendriveVehicleInfo.h"
#import "ZendriveDriveInfo.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * This class manages association and dissociation of vehicles to ZendriveSDK.
 */
@interface ZendriveVehicleTagging : NSObject

/**
 * Associates the vehicle to ZendriveSDK.
 *
 * After successful association of vehicle information, whenever ZendriveSDK will detect
 * a connection to this bluetooth device while the user is driving, it will include this vehicleId
 * in the tags array of `ZendriveAnalyzedDriveInfo`.
 *
 * If the user connect to bluetooth of multiple associated vehicles during the drive the latest vehicleId
 * will be used as tag. Maximum of two vehicles can be associated.
 *
 * @note The bluetooth device of the associated vehicle needs to be the audio route for some
 * duration of the drive for tagging to happen.
 *
 * Refer to `ZendriveVehicleTaggingError` to get details on the errors thrown by this method.
 *
 * @param vehicleInfo The `ZendriveVehicleInfo` object to associate.
 * @param error The error pointer where ZendriveSDK will populate the error thrown by the method.
 *
 * Example:
 *
 * @code
 *NSError *error;
 *ZendriveVehicleInfo *vehicleInfo = [[ZendriveVehicleInfo alloc] initWithVehicleId:@"vehicleId" bluetoothId:@"14:0F:C7:62:F8:9E"];
 *BOOL success = [ZendriveVehicleTagging associateVehicle:vehicleInfo error:&error];
 * @endcode
 *
 * Bluetooth stereos in automobiles are primarily classic Bluetooth devices, which might not be discoverable from your app.
 * When you associate the user's vehicle, ask the user to connect their stereo and play audio.
 * Then, use APIs from AVFoundation framework to determine the current audio route and get the identifier of the device.
 * Start with this code:
 *
 * @code
 *AVAudioSessionPortDescription *portDescription = [[[[AVAudioSession sharedInstance] currentRoute] outputs] firstObject];
 * // portDescription.UID will contain a string like "14:0F:C7:62:F8:9E-tacl" or "14:0F:C7:62:F8:9E-tsco"
 *if (portDescription) {
 *    // Trim the suffix to get the MAC address of the device.
 *    NSString *bluetoothId = [[portDescription.UID componentsSeparatedByString:@"-"] firstObject];
 *    // Send this MAC address as bluetoothId in associateVehicle:error: API
 *    NSError *error;
 *    ZendriveVehicleInfo *vehicleInfo = [[ZendriveVehicleInfo alloc] initWithVehicleId:@"vehicleId" bluetoothId:bluetoothId];
 *    BOOL success = [ZendriveVehicleTagging associateVehicle:vehicleInfo error:&error];
 *}
 * @endcode
 *
 * @return YES if association is successful, else NO.
 */
+ (BOOL)associateVehicle:(ZendriveVehicleInfo * _Nonnull)vehicleInfo
                   error:(NSError * _Nullable __autoreleasing * _Nullable)error;

/**
 * Dissociates the vehicle from ZendriveSDK.
 *
 * After successful dissociation of the vehicle, ZendriveSDK will stop tagging the trips for this vehicle.
 *
 * @param vehicleId The vehicleId of the vehicle which is to be dissociated.
 * @param error The error pointer where ZendriveSDK will populate the error thrown by the method.
 *
 * Refer to `ZendriveVehicleTaggingError` to get details on the errors thrown by this method.
 *
 * Example:
 *
 * @code
 *NSError *error;
 *ZendriveVehicleInfo *vehicleInfo = [[ZendriveVehicleInfo alloc] initWithVehicleId:@"vehicleId" bluetoothId:@"14:0F:C7:62:F8:9E"];
 *BOOL success = [ZendriveVehicleTagging dissociateVehicle:vehicleInfo.vehicleId error:&error];
 * @endcode
 *
 * @return YES if dissociation is successful, else NO.
 */
+ (BOOL)dissociateVehicle:(NSString * _Nonnull)vehicleId
                    error:(NSError * _Nullable __autoreleasing * _Nullable)error;

/**
 *  @return The list of associated vehicles if sdk is setup, else nil.
 */
+ (NSArray<ZendriveVehicleInfo *> * _Nullable)getAssociatedVehicles;

/**
 * @return The vehicleId if `ZendriveDriveInfo.tags` array contains the vehicle  tag, else nil.
 */
+ (NSString * _Nullable)getAssociatedVehicleForDrive:(ZendriveDriveInfo * _Nonnull)driveInfo;

@end

NS_ASSUME_NONNULL_END
