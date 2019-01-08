//
//  CommonFunc.m
//  zDiggerLibrary
//
//  Created by Atlas on 14/12/4.
//  Copyright (c) 2014年 zdigger.com. All rights reserved.
//

#import "CommonFunc.h"

@implementation CommonFunc
+(NSString *)iosVersion
{
    return [UIDevice currentDevice].systemVersion;
}
+(NSString *)app_Name
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

+(NSString *)app_Version
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+(NSString *)app_BuildVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

+(IphoneType)currentIphoneType
{
    UIScreen *screen = [UIScreen mainScreen];
    if (screen.bounds.size.width == 320) {
        if (screen.bounds.size.height == 480) {
            if(screen.scale == 2)
            {
                return IphoneType_4Retina;
            }
            else
            {
                return IphoneType_4;
            }
        }
        else
        {
            return IphoneType_5;
        }
    }
    else if (screen.bounds.size.width == 375)
    {
        return IphoneType_6;
    }
    else
    {
        return IphoneType_6Plus;
    }
}
@end
