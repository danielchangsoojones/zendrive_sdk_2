//
//  ZendriveMockHardBrakeEventBuilder.h
//  ZendriveMockDriveTests
//
//  Created by Sudeep Kumar on 08/12/18.
//  Copyright © 2018 Zendrive Inc. All rights reserved.
//

#import "ZendriveMockRangeEventBuilder.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * An event builder for [hard brake](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventHardBrake) event.
 */
@interface ZendriveMockHardBrakeEventBuilder : ZendriveMockRangeEventBuilder

/**
 * Constructs and return a new hard brake event builder.
 * @param startTimestamp [start timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startTime) for the event
 * @param endTimestamp [end timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)endTime) for the event.
 */
- (id)initWithStartTimestamp:(long long)startTimestamp
                endTimestamp:(long long)endTimestamp;


@end

NS_ASSUME_NONNULL_END
