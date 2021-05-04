//
//  ZendriveMockEventBuilder.h
//  ZendriveMockDrive
//
//  Created by Zendrive Inc on 19/11/18.
//  Copyright © 2018 Zendrive Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZendriveMockSDKHeaders.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Base event builder. This will seldom be initialized directly. Instead use some of the specific event builders
 * like `ZendriveMockAccidentEventBuilder`, `ZendriveMockHardBrakeEventBuilder`, `ZendriveMockOverspeedingEventBuilder` etc.
 **/
@interface ZendriveMockEventBuilder : NSObject

/**
 * Set [event severity](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventSeverity.html)
 */
- (ZendriveMockEventBuilder *)setSeverity:(ZendriveEventSeverity)severity;

/**
 * Build the mock event builder and return a [ZendriveEvent](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html).
 */
- (ZendriveEvent *)buildEvent;

@end

NS_ASSUME_NONNULL_END
