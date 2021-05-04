//
//  ZendriveStarRating.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK

/// Zendrive follows the star rating system, under which five star defined as the best rating with
/// one being the worst.
@objc(ZDStarRating) public enum StarRating : Int32 {

    /// Indicates worst rating.
    case one = 1

    /// Indicates bad rating.
    case two = 2

    /// Indicates an average rating.
    case three = 3

    /// Indicates good rating.
    case four = 4

    /// Indicates best rating.
    case five = 5

    /// Reported when rating is absent.
    case NA = -1

    func toObjcStarRating() -> ZendriveSDK.ZendriveStarRating {
        return ZendriveSDK.ZendriveStarRating(rawValue: self.rawValue) ?? ZendriveSDK.ZendriveStarRating.NA
    }

    static func fromObjcStarRating(_ objcStarRating: ZendriveSDK.ZendriveStarRating) -> StarRating {
        return StarRating(rawValue: objcStarRating.rawValue) ?? StarRating.NA
    }
}
