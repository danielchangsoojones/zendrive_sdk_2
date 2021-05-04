//
//  ZendriveLocationPoint.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK

/// Represents a geographical coordinate.
@objc(ZDLocationPoint) public class LocationPoint : NSObject {

    /// Epoch timestamp of the location point.
    @objc public var timestamp: Int64 {
        return self.internalLocationPoint.timestamp
    }

    /// Latitude in degrees
    @objc public var latitude: Double {
        return self.internalLocationPoint.latitude
    }

    /// Longitude in degrees
    @objc public var longitude: Double {
        return self.internalLocationPoint.longitude
    }

    var internalLocationPoint: ZendriveLocationPoint!

    /// Initializer for LocationPoint
    ///
    /// - Parameters:
    ///   - timestamp: Epoch timestamp of the location
    ///   - latitude: Latitude in degrees
    ///   - longitude: Longitude in degrees
    ///
    /// - Returns: LocationPoint object
    @objc public init(timestamp: Int64, latitude: Double, longitude: Double) {
        super.init()
        self.internalLocationPoint = ZendriveLocationPoint(timestamp: timestamp, latitude: latitude, longitude: longitude)
    }

    /// Compares any object with LocationPoint.
    /// - Parameter object: an object to be compared with this LocationPoint object.
    /// - Returns: `true` if the given object is equal to this LocationPoint object,
    ///            `false` otherwise.
    @objc public override func isEqual(_ object: Any?) -> Bool {
        if let locationPoint = object as? LocationPoint {
            return locationPoint.internalLocationPoint.isEqual(self.internalLocationPoint)
        }

        return false
    }

    /// Returns a dictionary that represents the `LocationPoint` object.
    @objc public func toDictionary() -> [AnyHashable : Any]! {
        return internalLocationPoint.toDictionary()
    }

    func toObjcLocationPoint() -> ZendriveLocationPoint {
        return ZendriveLocationPoint(timestamp: timestamp,
                                     latitude: latitude,
                                     longitude: longitude)
    }

    static func fromObjcLocationPoint(_ objcLocationPoint:
        ZendriveSDK.ZendriveLocationPoint) -> LocationPoint {
        return LocationPoint(timestamp: objcLocationPoint.timestamp, latitude: objcLocationPoint.latitude, longitude: objcLocationPoint.longitude)
    }

    static func convertArray(objcLocationPoints:
        [ZendriveSDK.ZendriveLocationPoint]?) -> [LocationPoint] {
        var locationPoints: [LocationPoint] = []
        if let objcLocationPoints = objcLocationPoints {
            for objcLocationPoint in objcLocationPoints {
                locationPoints.append(LocationPoint
                    .fromObjcLocationPoint(objcLocationPoint))
            }
        }
        return locationPoints
    }

    static func convertArray(swiftLocationPoints:
        [LocationPoint]?) -> [ZendriveLocationPoint] {
        var locationPoints: [ZendriveLocationPoint] = []
        if let swiftLocationPoints = swiftLocationPoints {
            for swiftLocationPoint in swiftLocationPoints {
                locationPoints.append(swiftLocationPoint.toObjcLocationPoint())
            }
        }
        return locationPoints
    }
}
