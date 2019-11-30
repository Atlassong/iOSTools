//
//  CommonFunc.h
//  zDiggerLibrary
//
//  Created by Atlas on 14/12/4.
//  Copyright (c) 2014年 zdigger.com. All rights reserved.
//
typedef NS_ENUM(NSInteger,DevicesType){
    Iphone_320_568_Point,
    Iphone_375_667_Point,
    Iphone_375_812_Point,
    Iphone_414_736_Point,
    Iphone_414_896_Point,
    Iphone_No_Support
};

typedef NS_ENUM(NSInteger,DevicesTypeForIpad){
    Ipad_768_1024_Point,
    Ipad_834_1112_Point,
    Ipad_834_1194_Point,
    Ipad_1024_1366_Point,
    Ipad_No_Supprot,
};

@interface Tools : NSObject
+ (NSString *)iosVersion;
+ (NSString *)app_Name;
+ (NSString *)app_Version;
+ (NSString *)app_BuildVersion;
+ (NSString *)app_BundleId;
+ (NSString *)mobileCarrier;
+ (NSString *)devicesModel;
+ (NSString *)uuid;
+ (DevicesType)devicesType;
+ (DevicesTypeForIpad)devicesIpadType;
@end
