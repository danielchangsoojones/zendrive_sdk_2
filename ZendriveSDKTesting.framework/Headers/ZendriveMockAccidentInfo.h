//
//  ZendriveMockAccidentInfo.h
//  ZendriveMockDrive
//
//  Created by Sudeep on 12/05/20.
//  Copyright © 2020 Sudeep Kumar. All rights reserved.
//

#import "ZendriveMockSDKHeaders.h"

/**
 * A wrapper object over [ZendriveAccidentInfo](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveAccidentInfo.html).
 * This contains some additional information needed to simulate the callbacks.
 */
@interface ZendriveMockAccidentInfo : NSObject

/**
 * [ZendriveAccidentInfo](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveAccidentInfo.html) which gets wrapped by ZendriveMockAccidentInfo.
 */
@property (nonatomic) ZendriveAccidentInfo *accidentInfo;

/**
 * Indicates if the accident represented by this object is a [potential accident](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Protocols/ZendriveDelegateProtocol.html#/c:objc(pl)ZendriveDelegateProtocol(im)processPotentialAccidentDetected:).
 */
@property (nonatomic) BOOL isPotentialAccident;

/**
 * Delay with which the corresponding accident callback should be send from the actual [accident timestamp](https://zendrive-root.bitbucket.io/ios/docs/sdk-7.0.0/Classes/ZendriveEvent.html#/c:objc(cs)ZendriveEvent(py)startTime).
 */
@property (nonatomic) int delayFromAccidentSeconds;

@end
