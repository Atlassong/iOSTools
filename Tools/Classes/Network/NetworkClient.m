//
//  NetworkClient.m
//  Pods-Tools_Example
//
//  Created by Atlas on 11/30/19.
//

#import "NetworkClient.h"
#import "AFHTTPSessionManager.h"
#import <Tools/NSArray+FOFoundation.h>
#import <Tools/Tools.h>
#import <Tools/NSDictionary+FOFoundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@implementation NetworkClient
static NetworkClient *_networkClient;
+ (instancetype) Client {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _networkClient = [[NetworkClient alloc] init];
    });
    return _networkClient;
}


- (NSDictionary *)httpHeaders {
    return @{
        @"device" : [UIDevice currentDevice].name,
        @"deviceType" : [UIDevice currentDevice].localizedModel,
        @"phoneVersion" : [Tools iosVersion],
        @"model" : [Tools devicesModel],
        @"rect" : [NSString stringWithFormat:@"%@*%@",@([UIScreen mainScreen].bounds.size.width), @([UIScreen mainScreen].bounds.size.height)],
        @"mobileCarrier" : [Tools mobileCarrier],
        @"appVersion" : [Tools app_BuildVersion]
    };
}

- (RACSignal *) dataByUrlPath:(NSString *)urlPath requestType:(Request_Type)type parameters:(NSDictionary *)parameters {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //最大请求并发任务数
    manager.operationQueue.maxConcurrentOperationCount = 5;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 上传普通格式
    manager.requestSerializer.timeoutInterval = 30.0f;// 超时时间
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [[self httpHeaders] fo_each:^(NSString *value, NSString *key) {
        [manager.requestSerializer setValue:value forHTTPHeaderField:key];
    }];
    // 设置请求头
    // 设置接收的Content-Type
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回格式 JSON
    //设置返回C的ontent-type
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/json",nil];

    //创建请求地址
    NSString *url= [NSString stringWithFormat:@"%@/%@", @"https://www.ilianliankan.com", urlPath];
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        if (type == Request_Get) {
            [manager GET:url parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //请求成功返回数据 根据responseSerializer 返回不同的数据格式
                if ([responseObject isKindOfClass:[NSDictionary class]] && responseObject[@"code"]) {
                    if ([responseObject[@"code"] integerValue] == 200) {
                        [subscriber sendNext:responseObject[@"response"]];
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //请求失败
                [subscriber sendError:error];
            }];
        } else {
            [manager POST:url parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //请求成功返回数据 根据responseSerializer 返回不同的数据格式
                if ([responseObject isKindOfClass:[NSDictionary class]] && responseObject[@"code"]) {
                    if ([responseObject[@"code"] integerValue] == 200) {
                        [subscriber sendNext:responseObject[@"response"]];
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //请求失败
                [subscriber sendError:error];
            }];
        }
        return nil;
    }];
}
@end
