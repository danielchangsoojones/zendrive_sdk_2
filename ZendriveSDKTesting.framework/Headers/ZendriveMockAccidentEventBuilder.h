//
//  ZendriveMockAccidentEventBuilder.h
//  ZendriveMockDriveTests
//
//  Created by Sudeep Kumar on 08/12/18.
//  Copyright © 2018 Zendrive Inc. All rights reserved.
//

#import "ZendriveMockPointEventBuilder.h"
#import "ZendriveMockSDKHeaders.h"

@class ZendriveMockAccidentInfo;

NS_ASSUME_NONNULL_BEGIN

/**
 * An event builder for [accident](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Enums/ZendriveEventType.html#/c:@E@ZendriveEventType@ZendriveEventAccident) event.
 */
@interface ZendriveMockAccidentEventBuilder : ZendriveMockPointEventBuilder

/**
 * Contains callback related information about the accident. See [here]((https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveMockAccidentConfig.html#).
 */
@property (nonatomic) ZendriveMockAccidentConfig *config;

/**
 * Constructs and return a new accident event builder.
 * @param timestamp [start timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startTime) of the event.
 * @param tripTimestamp [start timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveDriveStartInfo.html#/c:objc(cs)ZendriveDriveStartInfo(py)startTimestamp) of the trip to which this accident event belongs.
 * @param accidentId [accident identifier](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveAccidentInfo.html#/c:objc(cs)ZendriveAccidentInfo(py)accidentId).
 * @param confidence [accident confidence](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveAccidentInfo.html#/c:objc(cs)ZendriveAccidentInfo(py)confidence)
 * @param confidenceNumber [accident confidence number](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveAccidentInfo.html#/c:objc(cs)ZendriveAccidentInfo(py)confidenceNumber)
 */
- (instancetype)initWithTimestamp:(long long)timestamp
                    tripTimestamp:(long long)tripTimestamp
                       accidentId:(nonnull NSString *)accidentId
                       confidence:(ZendriveAccidentConfidence)confidence
                 confidenceNumber:(int)confidenceNumber;


/**
 * Constructs and return a new accident event builder. When configured, Zendrive SDK can give multiple callbacks for an accident.
 * This API allows one to create accident builders which can be used to give out potential and final callback information.
 * @param config [Accident Config](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveMockAccidentConfig.html) which
 * specifies the details of the information in the two callbacks.
 * @param timestamp [start timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startTime) of the event.
 * @param tripTimestamp [start timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveDriveStartInfo.html#/c:objc(cs)ZendriveDriveStartInfo(py)startTimestamp) of the trip to which this accident event belongs.
 */
- (instancetype)initWithMockAccidentConfig:(ZendriveMockAccidentConfig *)config
                                timestamp:(long long)timestamp
                            tripTimestamp:(long long)tripTimestamp
                               accidentId:(nonnull NSString *)accidentId;

@end

NS_ASSUME_NONNULL_END
