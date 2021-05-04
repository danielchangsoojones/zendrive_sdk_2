//
//  ZendriveMockAccidentConfig.h
//  ZendriveSDK
//
//  Created by Sudeep on 16/04/20.
//  Copyright © 2020 Zendrive Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZendriveAccidentInfo.h"

/**
 *  This class contains parameters required by `+[ZendriveTest raiseMockAccidentUsingConfig:]` during setup.
*/
@interface ZendriveMockAccidentConfig : NSObject<NSCopying>

/**
 * This field specifies the [confidence][confidenceId] for the [potential accident callback][potentialId].
 *
 * Default value is `ZendriveAccidentConfidence.ZendriveAccidentConfidenceHigh`.
 *
 *  [confidenceId]: ../Enums/ZendriveAccidentConfidence.html
 *  [potentialId]: ../Protocols/ZendriveDelegateProtocol.html#/c:objc(pl)ZendriveDelegateProtocol(im)processPotentialAccidentDetected:
*/
@property (nonatomic, assign) ZendriveAccidentConfidence potentialAccidentConfidence;


/**
 * This field specifies the [confidence][confidenceId] for the [final accident callback][finalId].
 *
 * Default value is `ZendriveAccidentConfidence.ZendriveAccidentConfidenceHigh`.
 *
 * [confidenceId]: ../Enums/ZendriveAccidentConfidence.html
 * [finalId]: ../Protocols/ZendriveDelegateProtocol.html#/c:objc(pl)ZendriveDelegateProtocol(im)processAccidentDetected:
*/
@property (nonatomic, assign) ZendriveAccidentConfidence finalAccidentConfidence;


/**
 * This field specifies the [confidence number][confidenceNumberId] for the [potential accident callback][potentialId].
 *
 * Default value is 70.
 *
 * [confidenceNumberId]: ZendriveAccidentInfo.html#/c:objc(cs)ZendriveAccidentInfo(py)confidenceNumber
 * [potentialId]: ../Protocols/ZendriveDelegateProtocol.html#/c:objc(pl)ZendriveDelegateProtocol(im)processPotentialAccidentDetected:
*/
@property (nonatomic, assign) int potentialAccidentConfidenceNumber;


/**
 * This field specifies the [confidence number][confidenceNumberId] for the [final accident callback][finalId].
 *
 * Default value is 70.
 *
 * [confidenceNumberId]: ZendriveAccidentInfo.html#/c:objc(cs)ZendriveAccidentInfo(py)confidenceNumber
 * [finalId]: ../Protocols/ZendriveDelegateProtocol.html#/c:objc(pl)ZendriveDelegateProtocol(im)processAccidentDetected:
*/
@property (nonatomic, assign) int finalAccidentConfidenceNumber;

/**
 * This field specifies the callback delay (in seconds) between the [potential][potentialId] and [final accident callback][finalId].
 *
 * Default value is 20 seconds.
 *
 * [potentialId]: ../Protocols/ZendriveDelegateProtocol.html#/c:objc(pl)ZendriveDelegateProtocol(im)processPotentialAccidentDetected:
 * [finalId]: ../Protocols/ZendriveDelegateProtocol.html#/c:objc(pl)ZendriveDelegateProtocol(im)processAccidentDetected:
*/
@property (nonatomic, assign) int delayBetweenCallbacks;


/**
 * This method causes the [final callback][finalId] to invalidate the [potential accident callback][potentialId].
 *
 * Invalidating final callbacks have [confidence number][confidenceNumberId] as 0 and [confidence][confidenceId] as `ZendriveAccidentConfidence.ZendriveAccidentConfidenceInvalid`,
 * signifying that the accident send out via the potential accident callback on further analysis has been reclassified as *not* being an accident.
 *
 * [potentialId]: ../Protocols/ZendriveDelegateProtocol.html#/c:objc(pl)ZendriveDelegateProtocol(im)processPotentialAccidentDetected:
 * [finalId]: ../Protocols/ZendriveDelegateProtocol.html#/c:objc(pl)ZendriveDelegateProtocol(im)processAccidentDetected:
 * [confidenceNumberId]: ZendriveAccidentInfo.html#/c:objc(cs)ZendriveAccidentInfo(py)confidenceNumber
 * [confidenceId]: ZendriveAccidentInfo.html#/c:objc(cs)ZendriveAccidentInfo(py)confidence
*/
- (void)invalidateFinalCallback;

@end
