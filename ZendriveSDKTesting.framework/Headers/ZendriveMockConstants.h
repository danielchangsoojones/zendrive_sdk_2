//
//  ZendriveMockConstants.h
//  ZendriveMockDrive
//
//  Created by Sudeep Kumar on 07/12/18.
//  Copyright © 2018 Zendrive Inc. All rights reserved.
//

#ifndef ZendriveMockConstants_h
#define ZendriveMockConstants_h

/**
 * This BOOL key needs to be in target's <b>Info.plist</b> for Zendrive SDK mock mode to be enabled.
 * When the value against this is NO or this key is absent, the SDK behaves normally.
 */
NSString * __nonnull const kMockDriveBuildKey = @"ZendriveMockModeEnabled";

#endif //ZendriveMockConstants_h
