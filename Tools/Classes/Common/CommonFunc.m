//
//  CommonFunc.m
//  zDiggerLibrary
//
//  Created by Atlas on 14/12/4.
//  Copyright (c) 2014年 zdigger.com. All rights reserved.
//

#import "CommonFunc.h"

@implementation CommonFunc
+ (NSString *)iosVersion {
    return [UIDevice currentDevice].systemVersion;
} 

+ (NSString *)app_Name {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)app_Version {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)app_BuildVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

+ (DevicesType)devicesType {
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat screenWidth = screen.bounds.size.width;
    CGFloat screenHeight = screen.bounds.size.height;
    if (screenWidth == 320.0f && screenHeight == 568.0f) {
        return Devices_4Inch;
    } else if (screenWidth == 375.0f && screenHeight == 667.0f) {
        return Devices_47Inch;
    } else if (screenWidth == 414.0f && screenHeight == 736.0f) {
        return Devices_55Inch;
    } else if (screenWidth == 375.0f && screenHeight == 812.0f) {
        return Devices_58Inch;
    } else if (screenWidth == 414.0f && screenHeight == 896.0f) {
        if (screen.scale == 2.0f) {
            return Devices_61Inch;
        } else {
            return Devices_65Inch;
        }
    }
    return Devices_NoSupport;
}
@end
