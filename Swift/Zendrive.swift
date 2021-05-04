//
//  Zendrive.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 20/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK
import ZendriveSDK.Insurance
import ZendriveSDK.Test

///  Zendrive Object.
@objc(ZDZendrive) public final class Zendrive : NSObject {

    private static var zendriveDelegate: ZendriveSDK.ZendriveDelegateProtocol? = nil


    /// Zendrive SDK version
    @objc public static let zendriveSDKVersion: String = kZendriveSDKVersion

    /// Identifier used by `Zendrive` SDK for region monitoring geofences
    @objc public static let zendriveGeofenceIdentifier: String = "com.zendrive.sdk.geofence"

    /// Initializes the Zendrive library to automatically detect driving and collect
    /// data. Client code should call this method before anything else in the Zendrive API.
    ///
    /// This method authenticates the configuration with the server asynchronously
    /// before returning status.
    ///
    /// Calling this method multiple times with the same values for
    /// applicationKey, driverId  and region is a no-op.
    /// Changing either will be the same as calling teardown followed by calling setup with
    /// the new parameters.
    /// Please note that even if other configuration parameters like driverAttributes or
    /// driveDetectionMode are changed, but driverId, applicationKey and region remain same,
    /// calling this method would still be a no-op.
    /// If you want to change these configuration parameters, invoke teardown
    /// explicitly and call this method again with the new configuration.
    ///
    /// This method requires network connection for every time the setup is called with a
    /// different value for
    /// applicationKey, driverId pair to validate the applicationKey from the server.
    /// Setup fails and returns `false` if network is not available in such cases.
    ///
    /// This method returns `false` whenever setup fails and sets up the error with the
    /// error code, cause and description.
    ///
    /// When data collection needs to be stopped call the teardown method.
    /// This might be done for example when the application's user has
    /// logged out (and possibly a different user might login later).
    ///
    /// - Parameters:
    ///   - configuration: The configuration object used to setup the SDK. This
    ///                              object contains your credentials along with
    ///                              additional setup parameters that you can use to provide
    ///                              meta-information about the user or to tune the sdk
    ///                              functionality.
    ///   - delegate: The delegate object on which Zendrive SDK will issue callbacks for
    ///                 handling various events. Can be nil if you do not want to
    ///                 register for callbacks.
    ///                 The delegate can also be set at a later point using `setDelegate(_:)`
    ///                 method.
    ///   - handler: This block is called when zendrive setup completes.
    ///                The application is expected to use the success and error
    ///                params passed to this block to handle failures. The handler
    ///                would be invoked on the main thread. Can be nil.
    ///
    @objc public static func setup(with configuration: Configuration,
                                       delegate: ZendriveDelegate?,
                      completionHandler handler: ((_ success: Bool, _ error: Error?) -> Void)? = nil) {
        zendriveDelegate = DelegateImpl(delegate: delegate)
        ZendriveSDK.Zendrive.setup(with: configuration.asObjcZendriveConfig(), delegate: zendriveDelegate) { (success, error) in
            if let completionHandler = handler {
                let swiftError = ZendriveError.fromError(error)
                completionHandler(success, swiftError)
            }
        }
    }


    /// Set delegate to receive callbacks for various events from Zendrive SDK.
    /// See `ZendriveDelegate` for further details.
    ///
    /// Calling this if Zendrive is not setup is a no-op.
    /// - SeeAlso: `setup(with:delegate:completionHandler:)` for further details.
    ///
    /// - Parameter delegate: The delegate object to give callbacks on.
    ///
    @objc public static func setDelegate(_ delegate: ZendriveDelegate?) {
        zendriveDelegate = DelegateImpl(delegate: delegate)
        ZendriveSDK.Zendrive.setDelegate(zendriveDelegate)
    }


    /// The drive detection mode controls how Zendrive SDK detects drives.
    /// See `DriveDetectionMode` for further details.
    ///
    /// Use this method to get the current `DriveDetectionMode`.
    @objc public static func getDriveDetectionMode() -> DriveDetectionMode {
        return DriveDetectionMode.fromObjcDriveDetection(ZendriveSDK.Zendrive.getDriveDetectionMode())
    }


    /// Change the drive detection mode to control how Zendrive SDK detects drives.
    /// See `DriveDetectionMode` for further details. This will override the mode sent
    /// with `Configuration` during setup.
    ///
    /// Calling this method stops an ongoing auto-detected drive.
    /// If the SDK is not setup calling this method will result in a no-op.
    ///
    /// - Parameters:
    ///   - driveDetectionMode: The new drive detection mode.
    ///   - completionHandler: A block object to be executed when the task finishes.
    /// This block has no return value and two arguments:
    /// success, A boolean that suggests if drive is started successfully
    /// error, A valid error `ZendriveError` object with `zendriveErrorDomain` is
    /// returned in case of a failure.
    /// Possible error codes returned: `ZendriveError.notSetup`
    /// Refer to ZendriveError for more details on the errors.
    @objc public static func setDriveDetectionMode(_ driveDetectionMode: DriveDetectionMode, completionHandler: ((_ success: Bool, _ error: Error?) -> Void)? = nil) {

        ZendriveSDK.Zendrive.setDriveDetectionMode(driveDetectionMode.toObjcDriveDetection()) { (success, error) in
            if let completionHandler = completionHandler {
                let swiftError = ZendriveError.fromError(error)
                completionHandler(success, swiftError)
            }
        }
    }


    /// Stops driving data collection. The application can disable the Zendrive SDK
    /// by invoking this method. This method is asynchronous.
    ///
    /// The teardown method is internally synchronized with
    /// `setup(with:delegate:completionHandler:)` method, and the enclosing
    /// application should avoid synchronizing the two methods independently. Calling this
    /// with nil completion handler is same as calling teardown method.
    ///
    /// - Parameter handler: Called when method completes. The handler would be invoked on main
    ///        thread. Can be nil.
    @objc public static func teardown(completionHandler handler: (() -> Void)? = nil) {
        ZendriveSDK.Zendrive.teardown(completionHandler: handler)
        zendriveDelegate = nil
    }


    /// Wipe out all the data that Zendrive keeps locally on the device.
    ///
    /// When Zendrive SDK is torn down, trip data that is locally persisted continues to remain persisted.
    /// The data will be uploaded when SDK setup is called at a later time.
    /// Wipeout should be used when the application wants to remove all traces of Zendrive on the device.
    /// Data cannot be recovered after this call.
    /// NOTE: This call can only be made when the SDK is not running.
    /// Call `teardown(completionHandler:)` to tear down a live SDK before making this call.
    @objc public static func wipeOut() throws {
        do {
            try ZendriveSDK.Zendrive.wipeOut()
        } catch let error {
            throw ZendriveError.fromError(error) ?? error
        }
    }


    /// This API allows application to override Zendrive's auto drive detection
    /// algorithm.
    ///
    /// Invoking this method forces the start of a drive. If this API is
    /// used then it is application's responsibility to terminate the drive by
    /// invoking `stopManualDrive(_:)` method. If an auto-detected drive is in progress, that drive
    /// is stopped and a new drive is started.
    ///
    /// These methods should be used only by applications which have explicit
    /// knowledge of start and end of drives and want to attribute drive data to
    /// specific trackingIds.
    ///
    /// Calling it without having initialized the Zendrive framework
    /// `setup(with:delegate:completionHandler:)` is a no-op.
    ///
    /// Calling `startManualDrive(_:completionHandler:)` with the same trackingId without calling `stopManualDrive(_:)` in between
    /// is a no-op. Calling `startManualDrive(_:completionHandler:)` with a different trackingId: with implicitly call
    /// stopManualDrive(_:) before starting a new drive.
    ///
    /// This is an asynchronous method, `ZendriveDelegate.processStart(ofDrive:)`
    /// is triggered once this finishes with basic information about the drive
    /// `activeDriveInfo` will return nil until `ZendriveDelegate.processStart(ofDrive:)` is called
    ///
    /// - Parameter completionHandler: A block object to be executed when the task finishes.
    /// This block has no return value and two arguments:
    /// isSuccess, A boolean that suggests if drive is started successfully
    /// error, A valid error of `zendriveErrorDomain` is
    /// returned in case of a failure.
    /// Possible error codes returned: `ZendriveError.notSetup`, `ZendriveError.invalidTrackingId`
    /// Refer to `ZendriveError` for more details on the errors.
    ///
    /// - SeeAlso: `stopManualDrive(_:)`
    ///
    /// You need to call `stopManualDrive(_:)` to stop drive data collection.
    ///
    @objc public static func startManualDrive(_ trackingId: String?, completionHandler: ((_ success: Bool, _ error: Error?) -> Void)? = nil) {
        ZendriveSDK.Zendrive.startManualDrive(trackingId) { (success, error) in
            if let completionHandler = completionHandler {
                let swiftError = ZendriveError.fromError(error)
                completionHandler(success, swiftError)
            }
        }
    }


    /// This should be called to indicate the end of a drive started by invoking
    /// `startManualDrive(_:completionHandler:)`
    ///
    ///
    /// This block has no return value and two arguments:
    /// the error, A valid error of `zendriveErrorDomain` is
    /// returned in case of a failure.
    /// Possible error codes returned: `ZendriveError.notSetup`, `ZendriveError.invalidTrackingId`,
    /// `ZendriveError.internalFailure`. Refer to `ZendriveError` for more details on the errors.
    /// success, A boolean that suggests if drive is stopped successfully
    ///
    /// Calling it without having initialized the Zendrive SDK is a no-op.
    ///
    /// - SeeAlso: `startManualDrive(_:completionHandler:)`
    ///
    @objc public static func stopManualDrive(_ completionHandler: ((_ success: Bool, _ error: Error?) -> Void)? = nil) {
        ZendriveSDK.Zendrive.stopManualDrive() { (success, error) in
            if let completionHandler = completionHandler {
                let swiftError = ZendriveError.fromError(error)
                completionHandler(success, swiftError)
            }
        }
    }


    /// Start a session in the SDK.
    ///
    /// Applications which want to record several user's drives as a session may use
    /// this call.
    ///
    /// All drives, either automatically detected or started using `startManualDrive(_:completionHandler:)`,
    /// will be tagged with the sessionId if a session is already in progress. If a drive
    /// is already on when this call is made, that drive will not belong to this
    /// session.
    ///
    /// This session id will be made available as a query parameter in the
    /// reports and API that Zendrive provides.
    ///
    /// The application must call `stopSession()` when it wants to end the session.
    ///
    /// Only one session may be active at a time. Calling startSession when a session is
    /// already active with a new sessionId will stop the ongoing session and start a new
    /// one.
    ///
    /// Calling it without having initialized the Zendrive SDK is a no-op.
    ///
    /// - Parameter sessionId: an identifier that identifies this session uniquely. Cannot
    ///                  be null or an empty string. Cannot be longer than 64 characters.
    ///                  Use `isValidInputParameter(_:)` to verify that groupId is valid.
    ///                  Passing invalid string is a no-op.
    ///
    @objc public static func startSession(_ sessionId: String) {
        ZendriveSDK.Zendrive.startSession(sessionId)
    }


    /// Stop currently ongoing session. No-op if no session is ongoing. Trips that
    /// start after this call do not belong to the session. Ongoing trips at the time of this
    /// call will continue to belong to the session that was just stopped.
    ///
    /// - SeeAlso: `startSession(_:)`
    ///
    @objc public static func stopSession() {
        ZendriveSDK.Zendrive.stopSession()
    }


    /// Use this method to check whether the parameter string passed
    /// to the SDK is valid.
    ///
    /// All strings passed as input params to Zendrive SDK cannot contain
    /// the following characters-
    /// "?", " ", "&", "/", "\", ";", "#"
    /// Non-ascii characters are not allowed.
    ///
    /// - Parameter input: The string to validate.
    /// - Returns: `true` if the string is `nil` or valid, `false` otherwise.
    ///
    @objc public static func isValidInputParameter(_ input: String?) -> Bool {
        return ZendriveSDK.Zendrive.isValidInputParameter(input)
    }


    /// Returns `true` if the Zendrive SDK is already setup. Else `false`.
    @objc public static var isSDKSetup: Bool {
        return ZendriveSDK.Zendrive.isSDKSetup()
    }


    /// Returns an identifier which can be used to identify this SDK build.
    @objc public static var buildVersion: String {
        return ZendriveSDK.Zendrive.buildVersion()
    }


    /// Get info on the currently active drive. If sdk is not setup or if
    /// no drive is in progress, nil is returned.
    ///
    /// - Returns: The currently active drive information.
    @objc public static var activeDriveInfo: ActiveDriveInfo? {
        return ActiveDriveInfo(with: ZendriveSDK.Zendrive.activeDriveInfo())
    }


    /// Get the current state of the Zendrive SDK.
    ///
    /// - Parameter completionHandler: A block object to be executed when the task finishes.
    /// This block has no return value and a single argument:
    /// state, A Zendrive `State` object that informs about the current state
    /// of the sdk. If the SDK is not set up, the state is nil.
    @objc public static func getState(_ completionHandler: ((State?) -> Void)? = nil) {
        ZendriveSDK.Zendrive.getState { (state: ZendriveState?) in
            completionHandler?(State.fromObjcState(with: state))
        }
    }


    /// Returns a boolean indicating whether Zendrive SDK can detect accidents
    /// on this devices or not.
    @objc public static var isAccidentDetectionSupportedByDevice: Bool {
        return ZendriveSDK.Zendrive.isAccidentDetectionSupportedByDevice()
    }


    /// Returns a NSDictionary with keys as `EventType` and values being Bool which represent
    /// if a particular event will be detected by the SDK on this device.
    @objc public static var getEventSupportForDevice: [AnyHashable : Any] {
        return ZendriveSDK.Zendrive.getEventSupportForDevice()
    }


    /// Send a debug report of the current driver to Zendrive.
    /// The Zendrive SDK will create a background task to ensure the
    /// completion of this upload task.
    @objc public static func uploadAllDebugDataAndLogs() {
        return ZendriveSDK.Zendrive.uploadAllDebugDataAndLogs()
    }

    /// - Returns: A valid `Settings` object if the SDK is setup, otherwise nil.
    @objc public static func getSettings() -> Settings? {
        if let objcSettings =  ZendriveSDK.Zendrive.getSettings() {
            return Settings.fromObjcSettings(objcSettings)
        }
        return nil
    }
}

///  Delegate for `Zendrive`.
@objc(ZDZendriveDelegate) public protocol ZendriveDelegate : NSObjectProtocol {

    ///
    /// Called on delegate in the main thread when `Zendrive` SDK detects a potential
    /// start of a drive.
    ///
    /// - Parameter startInfo: Info about drive start. Refer to `DriveStartInfo` for
    ///                  further details.
    ///
    @objc optional func processStart(ofDrive startInfo: DriveStartInfo)


    ///
    /// Called on delegate in the main thread when `Zendrive` SDK resumes a
    /// drive after a gap.
    ///
    /// The gap in drive recording may occur due to an application restart by the OS,
    /// application kill and restart by a user, an application crash or other reasons.
    /// Drives started by calling `Zendrive.startManualDrive(_:completionHandler:)` are always resumed and they
    /// will not end until `Zendrive.stopManualDrive(_:)` is called.
    ///
    /// - Parameter resumeInfo: Info about drive resume. Refer to `DriveResumeInfo` for
    ///                  further details.
    ///
    @objc optional func processResume(ofDrive resumeInfo: DriveResumeInfo)


    /// Called on the delegate in the main thread when `Zendrive` SDK detects a drive
    /// to have been completed.
    ///
    /// It is possible that `Zendrive` SDK might decide at a later time that an
    /// ongoing trip was a falsely detected trip. In such scenario `processEnd(ofDrive:)` will be
    /// invoked on delegate with `DriveInfo`.driveType set to `DriveType.invalid`.
    ///
    /// Every trip with `DriveInfo`.driveType not set to `DriveType.invalid`
    /// will receive a corresponding `processAnalysis(ofDrive:)` callback containing
    /// additional info related to this drive.
    ///
    /// - Parameter estimatedDriveInfo: Best estimate info about the drive.
    /// Refer to `EstimatedDriveInfo` for further details.
    ///
    @objc optional func processEnd(ofDrive estimatedDriveInfo: EstimatedDriveInfo)


    /// Called on the delegate in the main thread when `Zendrive` SDK finishes
    /// full analysis of all valid drives returned from `processEnd(ofDrive:)` callback.
    ///
    /// This will be called for all the `processEnd(ofDrive:)` callbacks
    /// with the value of `DriveInfo`.driveType not set to `DriveType.invalid`.
    ///
    /// This may contain additional or improved data over the `EstimatedDriveInfo`
    /// returned from `processEnd(ofDrive:)`
    ///
    /// Typically this callback will be fired within a few seconds after `processEnd(ofDrive:)`
    /// callback but in some rare cases this delay can be really large depending on
    /// phone network conditions.
    ///
    /// This callback will be fired in trip occurrence sequence, i.e from oldest trip to
    /// the latest trip.
    ///
    /// - Parameter analyzedDriveInfo: Analyzed insights of the drive.
    ///
    @objc optional func processAnalysis(ofDrive analyzedDriveInfo: AnalyzedDriveInfo)

    /// [Disabled by default]
    /// This callback is fired on the main thread when a potential accident is detected by the SDK during a drive.
    /// This is a preliminary callback of a potential collision. This collision is confirmed or invalidated by
    ///  `processAccidentDetected(_:)` callback.
    ///
    ///  To enable contact: support@zendrive.com
    ///
    /// - Parameter accidentInfo: Info about accident.
    ///
    @objc optional func processPotentialAccidentDetected(_ accidentInfo: AccidentInfo)

    /// This callback is fired on the main thread when an accident is detected by
    /// the SDK during a drive. Any ongoing auto-detected/manual drives will be stopped
    /// after this point.
    ///
    /// - Parameter accidentInfo: Info about accident.
    ///
    @objc optional func processAccidentDetected(_ accidentInfo: AccidentInfo)


    ///
    /// - Warning: This callback is deprecated. Use `settingsChanged(_:)` callback instead.
    ///
    /// This callback is fired on main thread when location services are denied for
    /// the SDK. After this callback, drive detection is paused until location
    /// services are re-enabled for the SDK.
    ///
    /// The expected behaviour is that the enclosing application shows an
    /// appropriate popup prompting the user to allow location services for the app.
    ///
    /// The callback is triggered once every time location services are denied by the user
    /// and can be triggered in background or in foreground, depending on whether the SDK
    /// has enough CPU time to execute.
    ///
    /// This callback is not sent if `Configuration.managesLocationPermission`
    /// value was set to `false` at setup.
    @available(*, deprecated, message: "Use `settingsChanged(_:)` callback instead.")
    @objc optional func processLocationDenied()


    ///
    /// - Warning: This callback is deprecated. Use `settingsChanged(_:)` callback instead.
    ///
    /// This method is called when location permission state is determined
    /// for the first time or whenever it changes.
    /// This callback is not sent if `Configuration.managesLocationPermission`
    /// value was set to `false` at setup.
    @available(*, deprecated, message: "Use `settingsChanged(_:)` callback instead.")
    @objc optional func processLocationApproved()

    ///
    /// - Warning: This callback is deprecated. Use `settingsChanged(_:)` callback instead.
    ///
    /// This callback is fired if activity and fitness permission is denied for the SDK.
    /// This callback is not sent if `Configuration.managesActivityPermission`
    /// value was set to `false` at setup
    @available(*, deprecated, message: "Use `settingsChanged(_:)` callback instead.")
    @objc optional func processActivityDenied()

    ///
    /// - Warning: This callback is deprecated. Use `settingsChanged(_:)` callback instead.
    ///
    /// This callback is fired if activity and fitness permission is approved for the SDK.
    /// This callback is not sent if `Configuration.managesActivityPermission`
    /// value was set to `false` at setup
    @available(*, deprecated, message: "Use `settingsChanged(_:)` callback instead.")
    @objc optional func processActivityApproved()

    ///
    /// This callback gives information about errors in device or application settings that
    /// may be affecting Zendrive SDK.
    ///
    /// This callback is fired on the main thread after SDK setup and whenever
    /// location permission or `Configuration.driveDetectionMode` changes,
    /// provided the location permission is determined.
    ///
    /// The recommended flow is to ask for the permissions before SDK is setup
    /// because if the location permission is not determined this callback will not be
    /// fired.
    ///
    /// If you receive this callback in the foreground you can show the errors using  any UI
    /// constructs like alert controllers, if this callback is received in the background you can
    /// use a notification. If you want to add actions to the notification then please don't
    /// rely on errors received at the time of notification as they might have changed by
    /// the time the user clicks on the notification. Instead use `Zendrive.getSettings()`
    /// to get the latest errors and show appropriate message to the user.
    ///
    /// - Parameter settings A valid `Settings` object that contains
    /// information about errors affecting the Zendrive SDK.
    ///
    @objc optional func settingsChanged(_ settings: Settings)
}


private class DelegateImpl : NSObject, ZendriveSDK.ZendriveDelegateProtocol {

    weak var delegate: ZendriveDelegate?

    fileprivate init(delegate: ZendriveDelegate?) {
        self.delegate = delegate
    }

    func processStart(ofDrive startInfo: ZendriveDriveStartInfo) {
        delegate?.processStart?(ofDrive: DriveStartInfo(with: startInfo))
    }

    func processResume(ofDrive resumeInfo: ZendriveDriveResumeInfo) {
        delegate?.processResume?(ofDrive: DriveResumeInfo(with: resumeInfo))
    }

    func processEnd(ofDrive estimatedDriveInfo: ZendriveEstimatedDriveInfo) {
        delegate?.processEnd?(ofDrive: EstimatedDriveInfo(with: estimatedDriveInfo))
    }

    func processAnalysis(ofDrive analyzedDriveInfo: ZendriveAnalyzedDriveInfo) {
        delegate?.processAnalysis?(ofDrive: AnalyzedDriveInfo(with: analyzedDriveInfo))
    }

    func processPotentialAccidentDetected(_ accidentInfo: ZendriveAccidentInfo) {
        delegate?.processPotentialAccidentDetected?(AccidentInfo(with: accidentInfo))
    }

    func processAccidentDetected(_ accidentInfo: ZendriveAccidentInfo) {
        delegate?.processAccidentDetected?(AccidentInfo(with: accidentInfo))
    }

    func processLocationDenied() {
        delegate?.processLocationDenied?()
    }

    func processLocationApproved() {
        delegate?.processLocationApproved?()
    }

    func processActivityDenied() {
        delegate?.processActivityDenied?()
    }

    func processActivityApproved() {
        delegate?.processActivityApproved?()
    }

    func settingsChanged(_ settings: ZendriveSettings) {
        delegate?.settingsChanged?(Settings.fromObjcSettings(settings))
    }
}

