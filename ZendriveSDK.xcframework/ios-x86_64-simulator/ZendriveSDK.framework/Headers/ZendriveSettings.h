//
//  ZendriveSettings.h
//  ZendriveSDK
//
//  Created by Abhishek Aggarwal on 06/07/20.
//  Copyright © 2020 Zendrive Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZendriveSettingsError.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * This class surfaces errors in device or application settings that affects trip detection in the SDK.
 */
@interface ZendriveSettings : NSObject

/**
 * List of errors that must be resolved for trip detection to work correctly.
 */
@property (nonatomic, nonnull) NSArray<ZendriveSettingsError *> *errors;

/**
 * Initializer for ZendriveSettings
 */
- (instancetype)initWithErrors:(NSArray<ZendriveSettingsError *> * _Nonnull)errors;

@end

NS_ASSUME_NONNULL_END
