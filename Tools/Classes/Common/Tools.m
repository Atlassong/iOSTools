//
//  CommonFunc.m
//  zDiggerLibrary
//
//  Created by Atlas on 14/12/4.
//  Copyright (c) 2014年 zdigger.com. All rights reserved.
//

#import "Tools.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>
#import <Tools/NSArray+FOFoundation.h>
#import "NSDictionary+FOFoundation.h"

@implementation Tools
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

+ (NSString *)mobileCarrier {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSDictionary<NSString *, CTCarrier *> *carrierDic = [info serviceSubscriberCellularProviders];
    if (carrierDic.allKeys.count == 0) {
        return @"无运营商";
    } else {
        return [[carrierDic.allValues fo_map:^id(CTCarrier *carrier, NSUInteger index) {
            return [carrier carrierName];
        }] componentsJoinedByString:@","];
    }
}

+ (NSString *)devicesModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
}

+ (NSString *)uuid {
    return [[NSUUID UUID] UUIDString];
}

+ (DevicesType)devicesType {
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat screenWidth = screen.bounds.size.width;
    CGFloat screenHeight = screen.bounds.size.height;
    if (screenWidth == 320.0f && screenHeight == 568.0f) {
        return Iphone_320_568_Point;
    } else if (screenWidth == 375.0f && screenHeight == 667.0f) {
        return Iphone_375_667_Point;
    } else if (screenWidth == 414.0f && screenHeight == 736.0f) {
        return Iphone_414_736_Point;
    } else if (screenWidth == 375.0f && screenHeight == 812.0f) {
        return Iphone_375_812_Point;
    } else if (screenWidth == 414.0f && screenHeight == 896.0f) {
        return Iphone_414_896_Point;
    }
    return Iphone_No_Support;
}

+ (DevicesTypeForIpad)devicesIpadType {
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat screenWidth = screen.bounds.size.width;
    CGFloat screenHeight = screen.bounds.size.height;
    if (screenWidth == 768.0f && screenHeight == 1024.0f) {
        return Ipad_768_1024_Point;
    } else if (screenWidth == 834.0f && screenHeight == 1112.0f) {
        return Ipad_834_1112_Point;
    } else if (screenWidth == 834.0f && screenHeight == 1194.0f) {
        return Ipad_834_1194_Point;
    } else if (screenWidth == 1024.0f && screenHeight == 1366.0f) {
        return Ipad_1024_1366_Point;
    }
    return Ipad_No_Supprot;
}
@end
