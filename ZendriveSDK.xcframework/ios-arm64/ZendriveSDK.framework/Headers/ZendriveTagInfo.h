//
//  ZendriveTagInfo.h
//  ZendriveSDK
//
//  Created by Abhishek Aggarwal on 12/04/20.
//  Copyright © 2020 Zendrive Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * This class is used to represent any additional information related to a drive.
 */
@interface ZendriveTagInfo : NSObject

/**
 * The key for the tag.
 */
@property (nonatomic, nonnull) NSString *key;

/**
 * The value for the tag.
 */
@property (nonatomic, nonnull) NSString *value;

@end

NS_ASSUME_NONNULL_END
