//
//  TagInfo.swift
//  ZendriveSDKSwift
//
//  Created by Abhishek Aggarwal on 22/04/20.
//  Copyright © 2020 Zendrive Inc. All rights reserved.
//

import UIKit
import ZendriveSDK

/// This class is used to represent any additional information related to a drive.
@objc(ZDTagInfo) public final class TagInfo: NSObject {

    /// The key for the tag.
    @objc public var key: String

    /// The value for the tag.
    @objc public var value: String

    /// Initializer for `TagInfo`.
    @objc public override convenience init() {
        self.init(with: ZendriveTagInfo())
    }

    init(with objcTagInfo: ZendriveTagInfo) {
        key = objcTagInfo.key
        value = objcTagInfo.value
    }

    func toObjcTagInfo() -> ZendriveTagInfo {
        let tagInfo = ZendriveTagInfo()
        tagInfo.key = key
        tagInfo.value = value
        return tagInfo
    }

    static func convertArray(objcTagInfos : [ZendriveTagInfo]?) -> [TagInfo] {
        var tagInfos: [TagInfo] = []
        if let objcTagInfos = objcTagInfos {
            for objcTagInfo in objcTagInfos {
                tagInfos.append(TagInfo(with: objcTagInfo))
            }
        }
        return tagInfos
    }

    static func convertArray(swiftTagInfos : [TagInfo]?) -> [ZendriveTagInfo] {
        var tagInfos: [ZendriveTagInfo] = []
        if let swiftTagInfos = swiftTagInfos {
            for swiftTagInfo in swiftTagInfos {
                tagInfos.append(swiftTagInfo.toObjcTagInfo())
            }
        }
        return tagInfos
    }
}
