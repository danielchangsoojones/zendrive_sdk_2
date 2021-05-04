//
//  ZendriveMockAggressiveAccelerationEventBuilder.h
//  ZendriveMockDriveTests
//
//  Created by Sudeep Kumar on 07/12/18.
//  Copyright © 2018 Zendrive Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZendriveMockPointEventBuilder.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * An event builder for [aggressive acceleration](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventAggressiveAcceleration) event.
 */
@interface ZendriveMockAggressiveAccelerationEventBuilder : ZendriveMockPointEventBuilder

/**
 * Constructs a new aggressive acceleration event
 * @param timestamp [start timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startTime) of the event.
 */
- (id)initWithTimestamp:(long long)timestamp;

@end

NS_ASSUME_NONNULL_END
