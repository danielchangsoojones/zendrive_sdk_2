//
//  ZendirveMockRangeEventBuilder.h
//  ZendriveMockDrivePrivate
//
//  Created by Sudeep Kumar on 13/12/18.
//  Copyright © 2018 Zendrive Inc. All rights reserved.
//

#import "ZendriveMockEventBuilder.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Base range event builder. Range events are events which span a time duration. The [start timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startTime) and [end timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)endTime) are different. Also, [start location](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startLocation) is different from [end location](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)stopLocation).<br>
 * This will seldom be initialized directly. Instead use some of the specific range event builders (like `ZendriveMockHardBrakeEventBuilder`).
 **/
@interface ZendriveMockRangeEventBuilder : ZendriveMockEventBuilder

/**
 * Set [start location](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startLocation) and [end location](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)stopLocation) of the range event.
 * @param startLocation [start location](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startLocation) of this event.
 * @param endLocation [end location](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)stopLocation) of this event.
 */
- (instancetype)setLocation:(ZendriveLocationPoint *)startLocation
                endLocation:(ZendriveLocationPoint *)endLocation;

@end

NS_ASSUME_NONNULL_END
