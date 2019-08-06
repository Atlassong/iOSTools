//
//  Created by xiang.song on 06/08/19.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FOFoundation)

- (void)fo_each:(void (^)(id object, id key))block;

- (void)fo_apply:(void (^)(id object, id key))block;

- (NSDictionary *)fo_map:(id (^)(id object, id key))block;

- (id)fo_reduce:(id (^)(id accumulated, id object, id key))block;

- (id)fo_match:(BOOL (^)(id object, id key))block;

- (NSDictionary *)fo_filter:(BOOL (^)(id object, id key))block;

- (NSDictionary *)fo_select:(BOOL (^)(id object, id key))block;

- (NSDictionary *)fo_reject:(BOOL (^)(id object, id key))block;

- (BOOL)fo_every:(BOOL (^)(id object, id key))block;

- (BOOL)fo_some:(BOOL (^)(id object, id key))block;

- (BOOL)fo_notAny:(BOOL (^)(id object, id key))block;

- (BOOL)fo_notEvery:(BOOL (^)(id object, id key))block;

- (void)fo_mergeToDestinationDic:(NSMutableDictionary *)mergedDic withAnotherDic:(NSDictionary *)dic;

- (NSDictionary *)fo_merge:(NSDictionary *)other;

- (NSString *)fo_queryString;

@end
