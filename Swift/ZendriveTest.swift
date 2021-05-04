//
//  ZendriveTest.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 17/07/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK.Test

/// This class contains methods that mock Zendrive's functionality for testing purposes.
@objc(ZDZendriveTest) public final class ZendriveTest: NSObject {

    /// Use this method to test `Zendrive` Accident detection integration. Works only in
    /// DEBUG mode, disabled in RELEASE mode.
    /// On invoking this method, you will get an [accident callback][finalId] on your
    /// delegate after 5 seconds. You can look at console logs for debugging in case you
    /// do not receive the callback. If issue persists, please contact us at
    /// support@zendrive.com.
    ///
    /// - Parameter confidence: Any value from `AccidentConfidence` enum.
    ///
    /// - Warning: While invoking this method on a simulator, make sure your are simulating
    ///            location (In Simulator menu bar, select Features->Location->Apple).
    ///
    /// [finalId]: ../Protocols/ZendriveDelegate.html#/c:@M@ZendriveSDKSwift@objc(pl)ZendriveDelegate(im)processAccidentDetected:
    @objc public static func raiseMockAccident(_ confidence: AccidentConfidence) {
        ZendriveSDK.ZendriveTest.raiseMockAccident(confidence.toObjcAccidentConfidence())
    }

    ///  Use this method to test `Zendrive` Accident detection integration. Works only in DEBUG mode,
    ///  disabled in RELEASE mode.
    ///
    ///  This API can be used to test multiple callbacks. You need to enable `Configuration.implementsMultipleAccidentCallbacks`
    ///  for that.
    ///  In case of multiple callbacks enabled, on invoking this method, you will get a [potential accident callback][potentialId]
    ///  on your delegate. After `MockAccidentConfig.delayBetweenCallbacks`seconds, you will
    ///  get a [final accident callback][finalId].
    ///
    ///  In case only single callback is enabled by setting `ZendriveConfiguration.implementsMultipleAccidentCallbacks` as NO,
    ///  on invoking this method, you will get a [final accident callback][finalId] callback.
    ///
    ///  You can look at console logs for debugging in case you do not receive the callback.
    ///  If issue persists, please contact us at support@zendrive.com.
    ///
    ///  - Parameter config: Configuration which determines the `AccidentInfo` values in the two callbacks.
    ///
    ///  - Warning:  While invoking this method on a simulator, make sure your are simulating
    ///              location (In Simulator menu bar, select Features->Location->Apple).
    ///
    /// [potentialId]: ../Protocols/ZendriveDelegate.html#/c:@M@ZendriveSDKSwift@objc(pl)ZendriveDelegate(im)processPotentialAccidentDetected:
    /// [finalId]: ../Protocols/ZendriveDelegate.html#/c:@M@ZendriveSDKSwift@objc(pl)ZendriveDelegate(im)processAccidentDetected:
    @objc public static func raiseMockAccident(using config: MockAccidentConfig) {
        ZendriveSDK.ZendriveTest.raiseMockAccident(using: config.asObjcZendriveMockConfig())
    }
}
