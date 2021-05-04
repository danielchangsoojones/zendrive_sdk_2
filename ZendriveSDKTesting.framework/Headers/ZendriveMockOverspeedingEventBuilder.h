//
//  ZendriveMockOverspeedingEventBuilder.h
//  ZendriveMockDriveTests
//
//  Created by Sudeep Kumar on 08/12/18.
//  Copyright © 2018 Zendrive Inc. All rights reserved.
//

#import "ZendriveMockRangeEventBuilder.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * An event builder for [overspeeding](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventOverSpeeding) event.
 */
@interface ZendriveMockOverspeedingEventBuilder : ZendriveMockRangeEventBuilder

/**
 * Constructs and return a new overspeeding event builder.
 * @param startTimestamp [start timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startTime) of the event
 * @param endTimestamp [end timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)endTime) of the event.
 * @param speedingData [overspeeding information](https://zendrive-root.bitbucket.io/ios/docs/appledoc-5.6.1/Classes/ZendriveSpeedingData.html)
 */
- (id)initWithStartTimestamp:(long long)startTimestamp
                endTimestamp:(long long)endTimestamp
                speedingData:(ZendriveSpeedingData *)speedingData;

@end

NS_ASSUME_NONNULL_END
