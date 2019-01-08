//
//  CommonFunc.h
//  zDiggerLibrary
//
//  Created by Atlas on 14/12/4.
//  Copyright (c) 2014年 zdigger.com. All rights reserved.
//

typedef NS_ENUM(NSInteger,IphoneType){
    IphoneType_4,
    IphoneType_4Retina,
    IphoneType_5,
    IphoneType_6,
    IphoneType_6Plus
};

@interface CommonFunc : NSObject
+(NSString *)iosVersion;
+(NSString *)app_Name;
+(NSString *)app_Version;
+(NSString *)app_BuildVersion;
+(IphoneType)currentIphoneType;
@end
