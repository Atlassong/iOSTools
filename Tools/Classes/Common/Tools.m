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
@end
