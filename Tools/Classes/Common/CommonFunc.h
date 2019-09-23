//
//  CommonFunc.h
//  zDiggerLibrary
//
//  Created by Atlas on 14/12/4.
//  Copyright (c) 2014年 zdigger.com. All rights reserved.
//

typedef NS_ENUM(NSInteger,DevicesType){
    Devices_4Inch,
    Devices_47Inch,
    Devices_55Inch,
    Devices_58Inch,
    Devices_61Inch,
    Devices_65Inch,
    Devices_NoSupport
};

@interface CommonFunc : NSObject
+ (NSString *)iosVersion;
+ (NSString *)app_Name;
+ (NSString *)app_Version;
+ (NSString *)app_BuildVersion;
+ (DevicesType)devicesType;
@end
