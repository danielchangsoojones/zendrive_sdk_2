//
//  ZendriveEvent.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK

/// This is returned in `Event.eventSeverity`, it represents the
/// severity of event if application for that event type.
@objc(ZDEventSeverity) public enum EventSeverity : Int {

    /// Severity not applicable for this event type.
    case none

    /// This is a low severity event.
    case low

    /// This is a high severity event.
    case high

    func toObjcEventSeverity() -> ZendriveSDK.ZendriveEventSeverity {
        return ZendriveSDK.ZendriveEventSeverity(rawValue: self.rawValue) ?? ZendriveSDK.ZendriveEventSeverity.none
    }

    static func fromObjcEventSeverity(_ objcEventSeverity: ZendriveSDK.ZendriveEventSeverity) -> EventSeverity {
        return EventSeverity(rawValue: objcEventSeverity.rawValue) ?? EventSeverity.none
    }
}

/// This is returned in `Event.turnDirection`, it represents the turn direction for `EventType.hardTurn`
@objc(ZDTurnDirection) public enum TurnDirection : Int {

    /// This is returned for all `Event.eventType` values other than `EventType.hardTurn`
    case notAvailable

    /// Indicates that the turn direction of the event was Left.
    case left

    /// Indicates that the turn direction of the event was right.
    case right

    func toObjcTurnDirection() -> ZendriveSDK.ZendriveTurnDirection {
        return ZendriveSDK.ZendriveTurnDirection(rawValue: self.rawValue) ?? ZendriveSDK.ZendriveTurnDirection.notAvailable
    }

    static func fromObjcTurnDirection(_ objcTurnDirection: ZendriveSDK.ZendriveTurnDirection) -> TurnDirection {
        return TurnDirection(rawValue: objcTurnDirection.rawValue) ?? TurnDirection.notAvailable
    }
}

/// The event type as specified in `Event.eventType`
@objc(ZDEventType) public enum EventType : Int {

    /// This denotes the aggressive behavior of braking too hard.
    case hardBrake


    /// This denotes the aggressive behavior of accelerating too fast.
    case aggressiveAcceleration


    /// This denotes the distracting behavior of handling the phone while driving.
    case phoneHandling


    /// This denotes the aggressive behavior of speeding more than allowed.
    /// You will also receive `Event.speedingData` in this case.
    case overSpeeding


    /// This denotes a collision as detected by Zendrive SDK.
    /// You will also receive `ZendriveDelegate.processAccidentDetected(_:)`
    /// in realtime for this event.
    case accident


    /// This denotes a hard turn as detected by Zendrive SDK.
    case hardTurn


    /// This denotes the distracting behavior of interacting with the phone screen while driving.
    case phoneScreenInteraction


    /// This denotes stop sign violations as detected by Zendrive SDK.
    case stopSignViolation

    func toObjcEventType() -> ZendriveSDK.ZendriveEventType {
        return ZendriveSDK.ZendriveEventType(rawValue: self.rawValue)!
    }

    static func fromObjcEventType(_ objcEventType: ZendriveSDK.ZendriveEventType) -> EventType {
        return EventType(rawValue: objcEventType.rawValue)!
    }
}

/// A valid object of this class is returned in `Event.speedingData`
/// whenever `Event.eventType` is equal to `EventType.overSpeeding`.
@objc(ZDSpeedingData) public class SpeedingData : NSObject {

    /// The speed limit in metres per second.
    @objc public var speedLimitMPS: Double

    /// The average speed of the user during this speeding event duration in metres per second.
    @objc public var userSpeedMPS: Double

    /// Maximum speed of the user during this speeding event duration in metres per second.
    @objc public var maxUserSpeedMPS: Double

    override convenience init() {
        let speedingData: ZendriveSDK.ZendriveSpeedingData = ZendriveSDK.ZendriveSpeedingData()
        self.init(with: speedingData)
    }

    convenience init?(with speedingData: ZendriveSDK.ZendriveSpeedingData?) {
        if let speedingData = speedingData {
            self.init(with: speedingData)
        } else {
            return nil
        }
    }

    init(with speedingData: ZendriveSDK.ZendriveSpeedingData) {
        self.speedLimitMPS = speedingData.speedLimitMPS
        self.userSpeedMPS = speedingData.userSpeedMPS
        self.maxUserSpeedMPS = speedingData.maxUserSpeedMPS
    }

    func toObjcSpeedingData() -> ZendriveSpeedingData {
        let objcSpeedingData = ZendriveSpeedingData()
        objcSpeedingData.speedLimitMPS = speedLimitMPS
        objcSpeedingData.userSpeedMPS = userSpeedMPS
        objcSpeedingData.maxUserSpeedMPS = maxUserSpeedMPS
        return objcSpeedingData
    }

    static func fromObjcSpeedingData(_ objcSpeedingData: ZendriveSDK.ZendriveSpeedingData?) -> SpeedingData? {
        return SpeedingData(with: objcSpeedingData)
    }
}

/// Represents a driving behavior event like phone use, aggressive acceleration etc.
/// It is part of `DriveInfo` object of `ZendriveDelegate.processEnd(ofDrive estimatedDriveInfo:)` callback.
@objc(ZDEvent) public class Event : NSObject {

    /// Start location of the event.
    @objc public var startLocation: LocationPoint

    /// Stop location of the event.
    @objc public var stopLocation: LocationPoint

    /// Epoch timestamp of the start of the event.
    @objc public var startTime: Int64

    /// Epoch timestamp of the end of the event;
    @objc public var endTime: Int64

    /// The type of the event.
    @objc public var eventType: EventType

    /// The severity of the event.
    @objc public var eventSeverity: EventSeverity

    /// Denotes the turn direction of a hard turn whether a left or right turn.
    @objc public var turnDirection: TurnDirection

    /// Additional data in the `eventType` is `Event.overSpeeding`, will be nil otherwise.
    @objc public var speedingData: SpeedingData?

    @objc override convenience init() {
        self.init(with: ZendriveSDK.ZendriveEvent())
    }

    init(with objcEvent: ZendriveEvent) {
        self.startLocation = LocationPoint.fromObjcLocationPoint(objcEvent.startLocation)
        self.stopLocation = LocationPoint.fromObjcLocationPoint(objcEvent.stopLocation)
        self.startTime = objcEvent.startTime
        self.endTime = objcEvent.endTime
        self.eventType = EventType.fromObjcEventType(objcEvent.eventType)
        self.eventSeverity = EventSeverity.fromObjcEventSeverity(objcEvent.eventSeverity)
        self.turnDirection = TurnDirection.fromObjcTurnDirection(objcEvent.turnDirection)
        self.speedingData = SpeedingData.fromObjcSpeedingData(objcEvent.speedingData)
    }

    func toObjcEvent() -> ZendriveEvent {
        let objcEvent = ZendriveEvent()
        objcEvent.startLocation = startLocation.toObjcLocationPoint()
        objcEvent.stopLocation = stopLocation.toObjcLocationPoint()
        objcEvent.startTime = startTime
        objcEvent.endTime = endTime
        objcEvent.eventType = eventType.toObjcEventType()
        objcEvent.eventSeverity = eventSeverity.toObjcEventSeverity()
        objcEvent.turnDirection = turnDirection.toObjcTurnDirection()
        objcEvent.speedingData = speedingData?.toObjcSpeedingData()
        return objcEvent
    }

    static func fromObjcEvent(_ objcEvent: ZendriveSDK.ZendriveEvent) -> Event {
        return Event.init(with: objcEvent)
    }

    static func convertArray(objcEvents: [ZendriveSDK.ZendriveEvent]?) -> [Event] {
        var events: [Event] = []
        if let objcEvents = objcEvents {
            for event in objcEvents {
                events.append(Event.fromObjcEvent(event))
            }
        }
        return events
    }

    static func convertArray(swiftEvents : [Event]?) -> [ZendriveEvent] {
        var events: [ZendriveEvent] = []
        if let swiftEvents = swiftEvents {
            for event in swiftEvents {
                events.append(event.toObjcEvent())
            }
        }
        return events
    }
}
