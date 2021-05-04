//
//  ZendriveEventRatings.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK

/// Represents ratings associated with the various event types for a trip. Higher rating for an event
/// represents safe driving behaviour with respect to that event. For cases where rating is absent,
/// `StarRating.NA` is reported.
///
/// - SeeAlso: `StarRating`
@objc(ZDEventRatings) public class EventRatings : NSObject {

    /// Represents rating associated with phone handling behavior while driving.
    public private(set) var phoneHandlingRating: StarRating

    /// Represents rating associated with hard braking while driving.
    public private(set) var hardBrakeRating: StarRating

    /// Represents rating associated with hard turning while driving.
    public private(set) var hardTurnRating: StarRating

    /// Represents rating associated with speeding while driving.
    public private(set) var speedingRating: StarRating

    /// Represents rating associated with aggressively accelerating while driving.
    public private(set) var aggressiveAccelerationRating: StarRating

    /// Initializer for `EventRatings`.
    init(with zendriveEventRatings: ZendriveSDK.ZendriveEventRatings) {
        self.phoneHandlingRating = StarRating.fromObjcStarRating(zendriveEventRatings.phoneHandlingRating)
        self.hardBrakeRating = StarRating.fromObjcStarRating(zendriveEventRatings.hardBrakeRating)
        self.hardTurnRating = StarRating.fromObjcStarRating(zendriveEventRatings.hardTurnRating)
        self.speedingRating = StarRating.fromObjcStarRating(zendriveEventRatings.speedingRating)
        self.aggressiveAccelerationRating = StarRating.fromObjcStarRating(zendriveEventRatings.aggressiveAccelerationRating)
        super.init()
    }

    func toObjcEventRatings() -> ZendriveEventRatings {
        let objcEventRatings: ZendriveEventRatings = ZendriveEventRatings()
        objcEventRatings.phoneHandlingRating =
            phoneHandlingRating.toObjcStarRating()
        objcEventRatings.hardBrakeRating = hardBrakeRating.toObjcStarRating()
        objcEventRatings.hardTurnRating = hardTurnRating.toObjcStarRating()
        objcEventRatings.speedingRating = speedingRating.toObjcStarRating()
        objcEventRatings.aggressiveAccelerationRating = aggressiveAccelerationRating.toObjcStarRating()
        return objcEventRatings
    }
}
