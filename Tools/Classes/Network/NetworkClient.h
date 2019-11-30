//
//  NetworkClient.h
//  Pods-Tools_Example
//
//  Created by Atlas on 11/30/19.
//

#import <ReactiveObjC/ReactiveObjC.h>

typedef NS_ENUM(NSUInteger, Request_Type) {
    Request_Get,
    Request_Post
};

NS_ASSUME_NONNULL_BEGIN

@interface NetworkClient : NSObject
+ (instancetype) Client;
- (RACSignal *) dataByUrlPath:(NSString *)urlPath requestType:(Request_Type)type parameters:(NSDictionary *)parameters;
@end

NS_ASSUME_NONNULL_END
