//
//  ZendriveTest.h
//  Zendrive
//
//  Created by Yogesh on 5/20/15.
//  Copyright (c) 2015 Zendrive Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZendriveAccidentInfo.h"
#import "ZendriveMockAccidentConfig.h"

/**
 * This class contains methods that mock Zendrive's functionality for testing purposes.
 *
 */
@interface ZendriveTest : NSObject

/**
 *  Use this method to test `Zendrive` Accident detection integration. Works only in
 *  DEBUG mode, disabled in RELEASE mode.
 *  On invoking this method, you will get a `-[ZendriveDelegateProtocol processAccidentDetected:]`
 *  callback on your delegate after 5 seconds. You can look at console logs for debugging in case you
 *  do not receive the callback. If issue persists, please contact us at support@zendrive.com.
 *
 *  @param confidence Any value from `ZendriveAccidentConfidence` enum.
 *
 *  @warning While invoking this method on a simulator, make sure your are simulating
 *  location (In Simulator menu bar, select Features->Location->Apple).
 */
+ (void)raiseMockAccident:(ZendriveAccidentConfidence)confidence;

/**
*  Use this method to test `Zendrive` Accident detection integration. Works only in
*  DEBUG mode, disabled in RELEASE mode.
*
*  This API can be used to test multiple callbacks. You need to enable
*  `ZendriveConfiguration.implementsMultipleAccidentCallbacks` for that.
*  In case of multiple callbacks enabled, on invoking this method, you will get a [potential accident callback][potentialId]
*  on your delegate.
*  After `ZendriveMockAccidentConfig.delayBetweenCallbacks` seconds, you will
*  get a [final accident callback][finalId] callback.
*
*  In case only single callback is enabled by setting `ZendriveConfiguration.implementsMultipleAccidentCallbacks` as NO,
*  on invoking this method, you will get a [final callback][finalId].
*  You can look at console logs for debugging in case you do not receive the callback.
*  If issue persists, please contact us at support@zendrive.com.
*
*  @param config Configuration which determines the `ZendriveAccidentInfo` values in the two callbacks.
*
*  @warning While invoking this method on a simulator, make sure your are simulating
*  location (In Simulator menu bar, select Features->Location->Apple).
*
* [potentialId]: ../Protocols/ZendriveDelegateProtocol.html#/c:objc(pl)ZendriveDelegateProtocol(im)processPotentialAccidentDetected:
* [finalId]: ../Protocols/ZendriveDelegateProtocol.html#/c:objc(pl)ZendriveDelegateProtocol(im)processAccidentDetected:
*/
+ (void)raiseMockAccidentUsingConfig:(ZendriveMockAccidentConfig *)config;

@end
