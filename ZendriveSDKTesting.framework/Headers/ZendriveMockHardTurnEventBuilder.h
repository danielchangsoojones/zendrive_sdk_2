//
//  ZendriveMockHardTurnEventBuilder.h
//  ZendriveMockDriveTests
//
//  Created by Sudeep Kumar on 08/12/18.
//  Copyright © 2018 Zendrive Inc. All rights reserved.
//

#import "ZendriveMockRangeEventBuilder.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * An event builder for [hard turn](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventHardTurn) event.
 */
@interface ZendriveMockHardTurnEventBuilder : ZendriveMockRangeEventBuilder

/**
 * Constructs and return a new hard turn event builder.
 * @param startTimestamp [start timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startTime) of the event
 * @param endTimestamp [end timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)endTime) of the event.
 * @param turnDirection [turn direction](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)turnDirection) of the event.
 */
- (id)initWithStartTimestamp:(long long)startTimestamp
                endTimestamp:(long long)endTimestamp
               turnDirection:(ZendriveTurnDirection)turnDirection;

@end

NS_ASSUME_NONNULL_END
