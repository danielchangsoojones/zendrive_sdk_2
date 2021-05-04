//
//  ZendriveMockPointEventBuilder.h
//  ZendriveMockDrivePrivate
//
//  Created by Sudeep Kumar on 13/12/18.
//  Copyright © 2018 Zendrive Inc. All rights reserved.
//

#import "ZendriveMockEventBuilder.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Base point event builder. Point events are instantaneous events. The [start timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startTime) and [end timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)endTime) are equal. Also, [start location](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startLocation) is equal to [end location](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)stopLocation).<br>
 * This will seldom be initialized directly. Instead use some of the specific event builders (like `ZendriveMockAccidentEventBuilder`).
 **/
@interface ZendriveMockPointEventBuilder : ZendriveMockEventBuilder

/**
 * [Location](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startLocation) of the point event.
 * @param eventLocation [Location](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startLocation) of the point event.
 */
- (instancetype)setLocation:(ZendriveLocationPoint *)eventLocation;

@end

NS_ASSUME_NONNULL_END
