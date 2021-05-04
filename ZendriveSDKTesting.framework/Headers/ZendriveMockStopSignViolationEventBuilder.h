//
//  ZendriveMockStopSignViolationEventBuilder.h
//  ZendriveMockDrive
//
//  Created by Sudeep Kumar on 30/05/19.
//  Copyright © 2019 Sudeep Kumar. All rights reserved.
//

#import "ZendriveMockPointEventBuilder.h"

/**
 * An event builder for [stop sign violation](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventStopSignViolation) event.
 */
@interface ZendriveMockStopSignViolationEventBuilder : ZendriveMockPointEventBuilder

/**
 * Constructs a new stop sign violation event
 * @param timestamp [start timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startTime) of the event.
 */
- (id)initWithTimestamp:(long long)timestamp;


@end
