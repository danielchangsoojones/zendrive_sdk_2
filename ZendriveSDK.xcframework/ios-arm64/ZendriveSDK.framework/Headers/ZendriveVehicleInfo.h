//
//  ZendriveVehicleInfo.h
//  ZendriveSDK
//
//  Created by Abhishek Aggarwal on 07/04/20.
//  Copyright © 2020 Zendrive Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Wrapper for meta information related to a vehicle.
 */
@interface ZendriveVehicleInfo : NSObject

/**
 * The unique identifier for the vehicle.
 *
 * This should not be nil, should not have more than 64 characters
 * and should satisfy `+[Zendrive isValidInputParameter:]`.
 */
@property (nonatomic, nonnull) NSString *vehicleId;

/**
 * The mac address of vehicles's bluetooth device.
 */
@property (nonatomic, nonnull) NSString *bluetoothId;

/**
 * Initializer for `ZendriveVehicleInfo`.
 */
- (id)initWithVehicleId:(NSString * _Nonnull)vehicleId
            bluetoothId:(NSString * _Nonnull)bluetoothId;

@end

NS_ASSUME_NONNULL_END
