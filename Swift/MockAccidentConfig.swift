//
//  MockAccidentConfig.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep on 20/04/20.
//  Copyright © 2020 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK

/// This class contains parameters required by `ZendriveTest.raiseMockAccidentUsingConfig(using:)` for testing accident flow.
@objc(ZDMockAccidentConfig) public class MockAccidentConfig : NSObject, NSCopying {

    /// This field specifies the [confidence][confidenceId] for the [potential accident callback][potentialId].
    ///
    /// Default value is `AccidentConfidence.high`.
    ///
    /// [potentialId]: ../Protocols/ZendriveDelegate.html#/c:@M@ZendriveSDKSwift@objc(pl)ZendriveDelegate(im)processPotentialAccidentDetected:
    /// [confidenceId]: ../Enums/AccidentConfidence.html
    @objc public var potentialAccidentConfidence: AccidentConfidence

    /// This field specifies the [confidence][confidenceId] for the [final accident callback][finalId].
    ///
    /// Default value is `AccidentConfidence.high`.
    ///
    /// [finalId]: ../Protocols/ZendriveDelegate.html#/c:@M@ZendriveSDKSwift@objc(pl)ZendriveDelegate(im)processAccidentDetected:
    /// [confidenceId]: ../Enums/AccidentConfidence.html
    @objc public var finalAccidentConfidence: AccidentConfidence

    /// This field specifies the [confidence number][confidenceNumberId] for the [potential accident callback][potentialId].
    ///
    /// Default value is 70.
    /// [potentialId]: ../Protocols/ZendriveDelegate.html#/c:@M@ZendriveSDKSwift@objc(pl)ZendriveDelegate(im)processPotentialAccidentDetected:
    /// [finalId]: ../Protocols/ZendriveDelegate.html#/c:@M@ZendriveSDKSwift@objc(pl)ZendriveDelegate(im)processAccidentDetected:
    /// [confidenceNumberId]: AccidentInfo.html#/c:@M@ZendriveSDKSwift@objc(cs)ZDAccidentInfo(py)confidenceNumber
    @objc public var potentialAccidentConfidenceNumber: Int32

    /// This field specifies the [confidence number][confidenceNumberId] for the [final accident callback][finalId].
    ///
    /// Default value is 70.
    ///
    /// [finalId]: ../ Protocols/ZendriveDelegate.html#/c:@M@ZendriveSDKSwift@objc(pl)ZendriveDelegate(im)processAccidentDetected:
    /// [confidenceNumberId]: AccidentInfo.html#/c:@M@ZendriveSDKSwift@objc(cs)ZDAccidentInfo(py)confidenceNumber
    @objc public var finalAccidentConfidenceNumber: Int32

    /// This field specifies the callback delay (in seconds) between the [potential][potentialId] and [final accident callback][finalId].
    ///
    /// Default value is 20 seconds.
    ///
    /// [potentialId]: ../Protocols/ZendriveDelegate.html#/c:@M@ZendriveSDKSwift@objc(pl)ZendriveDelegate(im)processPotentialAccidentDetected:
    /// [finalId]: ../Protocols/ZendriveDelegate.html#/c:@M@ZendriveSDKSwift@objc(pl)ZendriveDelegate(im)processAccidentDetected:
    @objc public var delayBetweenCallbacks: Int32

    /// Creates a Zendrive `MockAccidentConfig` object.
    @objc public override convenience init() {
        let config: ZendriveSDK.ZendriveMockAccidentConfig = ZendriveSDK.ZendriveMockAccidentConfig()
        self.init(with: config)
    }

    init(with config: ZendriveSDK.ZendriveMockAccidentConfig) {
        self.potentialAccidentConfidence =
            AccidentConfidence.fromObjcAccidentConfidence(config.potentialAccidentConfidence)
        self.finalAccidentConfidence = AccidentConfidence.fromObjcAccidentConfidence(config.finalAccidentConfidence)
        self.potentialAccidentConfidenceNumber = config.potentialAccidentConfidenceNumber
        self.finalAccidentConfidenceNumber = config.finalAccidentConfidenceNumber
        self.delayBetweenCallbacks = config.delayBetweenCallbacks
    }

    func asObjcZendriveMockConfig() -> ZendriveSDK.ZendriveMockAccidentConfig {
        let config: ZendriveSDK.ZendriveMockAccidentConfig = ZendriveSDK.ZendriveMockAccidentConfig()
        config.potentialAccidentConfidence = self.potentialAccidentConfidence.toObjcAccidentConfidence()
        config.finalAccidentConfidence = self.finalAccidentConfidence.toObjcAccidentConfidence()
        config.potentialAccidentConfidenceNumber = self.potentialAccidentConfidenceNumber
        config.finalAccidentConfidenceNumber = self.finalAccidentConfidenceNumber
        config.delayBetweenCallbacks = self.delayBetweenCallbacks
        return config
    }

    /// Creates a copy of Zendrive `MockAccidentConfig` object.
    @objc public func copy(with zone: NSZone? = nil) -> Any {
        let config: ZendriveSDK.ZendriveMockAccidentConfig = self.asObjcZendriveMockConfig()
        let copiedConfig = config.copy(with: zone) as! ZendriveMockAccidentConfig
        return MockAccidentConfig(with: copiedConfig)
    }

    /// This method causes the [final callback][finalId] to invalidate the [potential callback][potentialId].
    ///
    /// Invalidating final callbacks have [confidence number][confidenceNumberId] as 0 and [confidence][confidenceId] as `AccidentConfidence.invalid`,
    /// signifying that the accident send out via the potential accident callback on further analysis has been reclassified as *not* being an accident.
    ///
    /// [potentialId]: ../Protocols/ZendriveDelegate.html#/c:@M@ZendriveSDKSwift@objc(pl)ZendriveDelegate(im)processPotentialAccidentDetected:
    /// [finalId]: ../Protocols/ZendriveDelegate.html#/c:@M@ZendriveSDKSwift@objc(pl)ZendriveDelegate(im)processAccidentDetected:
    /// [confidenceNumberId]: AccidentInfo.html#/c:@M@ZendriveSDKSwift@objc(cs)ZDAccidentInfo(py)confidenceNumber
    /// [confidenceId]: AccidentInfo.html#/c:@M@ZendriveSDKSwift@objc(cs)ZDAccidentInfo(py)confidence
    @objc public func invalidateFinalCallback() {
        self.finalAccidentConfidenceNumber = 0
        self.finalAccidentConfidence = .invalid
    }
}
