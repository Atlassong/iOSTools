//
//  AppManager.m
//  AFNetworking
//
//  Created by Atlas on 1/15/20.
//

#import "AppManager.h"

@implementation AppManager
/// 上传用户基础信息
+(void)uploadUserInfo {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"upload_user_info"]) return;
     NSString *uuid = [Tools uuid];
     NSTimeZone *zone = [NSTimeZone localTimeZone];
     // 获取指定时区的名称
     NSString *strZoneName = [zone name];
     NSDictionary *userinfoDic = @{
         @"uid" : uuid,
         @"devicesname" : [NSString stringWithFormat:@"%@", [UIDevice currentDevice].name],
         @"systemverson" : [UIDevice currentDevice].systemVersion,
         @"devicetype" : [NSString stringWithFormat:@"%@", strZoneName],
         @"device" : [Tools devicesModel],
         @"carier" : [Tools mobileCarrier],
         @"appversion" : [Tools app_BuildVersion],
         @"bundleid": [Tools app_BundleId]
     };
     [[[NetworkClient Client] dataByUrlPath:@"api/v1/registernewuser" requestType:Request_Post parameters:userinfoDic] subscribeNext:^(NSDictionary *responseDic) {
         [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:UPLOAD_USER_INFO];
    }];
    
}
@end
