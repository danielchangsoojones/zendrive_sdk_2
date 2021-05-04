//
//  ZendriveDebug.swift
//  ZendriveSDKSwift
//
//  Created by Sudeep Kumar on 21/06/19.
//  Copyright © 2019 Zendrive Inc. All rights reserved.
//

import Foundation
import ZendriveSDK

/// Status of the debug upload request. As received in the delegate.
@objc(ZDDebugUploadStatus) public enum DebugUploadStatus : Int32 {

    /// Debug data upload finished successfully.
    case success


    /// Failed due to missing driverId.
    case failedMissingDriverId


    /// Failed due to missing application key.
    case failedMissingApplicationKey


    /// Failed due to some other reason while uploading.
    case failedInternal


    /// Failed because application is not authorized to upload data to given region.
    case failedUnauthorizedRegion


    internal func toObjcDebugUploadStatus() -> ZendriveSDK.ZendriveDebugUploadStatus {
        return ZendriveSDK.ZendriveDebugUploadStatus(rawValue: self.rawValue)!
    }

    internal static func fromObjcDebugUploadStatus(_ objcDebugUploadStatus: ZendriveSDK.ZendriveDebugUploadStatus) -> DebugUploadStatus {
        return DebugUploadStatus(rawValue: objcDebugUploadStatus.rawValue)!
    }
}

/// Utility class which helps in uploading data required for
/// debugging Zendrive SDK related issues.
@objc(ZDZendriveDebug) public final class ZendriveDebug : NSObject {

    private static var zendriveDebugDelegate: ZendriveSDK.ZendriveDebugDelegateProtocol? = nil


    /// Upload all zendrive related data that will help in debugging.
    ///
    /// The method uploads all data to the zendrive servers via a background upload task.
    /// This does not require the `Zendrive` SDK to be setup but needs a valid application key.
    /// This is a no-op if upload is already in progress.
    ///
    /// - Parameters:
    ///   - configuration: The configuration object which should have valid
    ///                    value of applicaitonKey and driverId.
    ///   - delegate: The delegate which will receive success or failure callbacks.
    ///               No callback will be deliverd if the user force terminates
    ///               the app while a download is going on.
    @objc public static func uploadAllZendriveData(with configuration: Configuration, delegate: ZendriveDebugDelegate?) {
        zendriveDebugDelegate = DebugDelegateImpl(delegate: delegate)
        ZendriveSDK.ZendriveDebug.uploadAllZendriveData(with: configuration.asObjcZendriveConfig(), delegate: zendriveDebugDelegate)
    }


    /// Check using a session identifier if the corresponding session was started for data upload.
    ///
    /// Typically this method should be used to check the ownership of a session idenfier obtained in
    /// `application(_:handleEventsForBackgroundURLSession:completionHandler:)` method of
    /// UIApplicationDelegate
    ///
    /// - Parameter identifier: The identifier in `application(_:handleEventsForBackgroundURLSession:completionHandler:)`
    ///
    @objc public static func isZendriveSessionIdentifier(_ identifier: String) -> Bool {
        return ZendriveSDK.ZendriveDebug.isZendriveSessionIdentifier(identifier)
    }


    /// Tell the SDK that events for a URLSession are waiting to be processed.
    ///
    /// The call to `application(_:handleEventsForBackgroundURLSession:completionHandler:)` method of `UIApplicationDelegate`
    /// should be forwarded here if it is a `Zendrive` session identifier. This will ensure the correct
    /// handling of the relevant session creation and callbacks to the delegate.
    ///
    /// - Parameters:
    ///   - identifier: The identifier in `application(_:handleEventsForBackgroundURLSession:completionHandler:)`
    ///   - completionHandler The completionhandler in `application(_:handleEventsForBackgroundURLSession:completionHandler:)`
    @objc public static func handleEvents(forBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        ZendriveSDK.ZendriveDebug.handleEvents(forBackgroundURLSession: identifier, completionHandler: completionHandler)
    }

    /// Set delegate to receive callback in response to `uploadAllZendriveData(with:delegate:)` request.
    /// - SeeAlso: `ZendriveDebugDelegate` for further details.
    ///
    /// - Parameter delegate: The delegate object to give callbacks on.
    @objc public static func setDelegate(_ delegate: ZendriveDebugDelegate?) {
        zendriveDebugDelegate = DebugDelegateImpl(delegate: delegate)
        ZendriveSDK.ZendriveDebug.setDelegate(zendriveDebugDelegate)
    }
}

/// Delegate for `ZendriveDebug`
@objc(ZDZendriveDebugDelegate) public protocol ZendriveDebugDelegate : NSObjectProtocol {

    /// This delegate callback provides the status of the request to upload debug information to Zendrive.
    /// This callback is sent on the main thread.
    ///
    /// - Parameter status: Status of the debug upload request. As received in the delegate.
    @objc optional func debugUploadFinished(_ status: DebugUploadStatus)
}


private class DebugDelegateImpl : NSObject, ZendriveSDK.ZendriveDebugDelegateProtocol {

    weak var delegate: ZendriveDebugDelegate?

    public init(delegate: ZendriveDebugDelegate?) {
        self.delegate = delegate
    }

    func zendriveDebugUploadFinished(_ status: ZendriveDebugUploadStatus) {
        self.delegate?.debugUploadFinished?(DebugUploadStatus.fromObjcDebugUploadStatus(status))
    }
}
