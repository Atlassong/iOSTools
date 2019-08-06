//
//  Created by xiang.song on 06/08/19.
//

#import "NSMutableDictionary+FOFoundation.h"

@implementation NSMutableDictionary (FOFoundation)

- (void)fo_performSelect:(BOOL (^)(id, id))block
{
    NSParameterAssert(block);
    NSArray *keys = [[self keysOfEntriesWithOptions:NSEnumerationConcurrent
                                        passingTest:^BOOL(id _Nonnull key, id _Nonnull obj, BOOL *_Nonnull stop) {
                                            if (block) {
                                                return !block(obj, key);
                                            }
                                            return NO;
                                        }] allObjects];
    [self removeObjectsForKeys:keys];
}

- (void)fo_performReject:(BOOL (^)(id, id))block
{
    NSParameterAssert(block);
    return [self mmp_performSelect:^BOOL(id object, id key) {
        if (block) {
            return !block(object, key);
        }
        return NO;
    }];
}

- (void)fo_performMap:(id (^)(id, id))block
{
    NSParameterAssert(block);
    NSMutableDictionary *new = [self mutableCopy];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id value = block(obj, key) ?: [NSNull null];
        if ([value isEqual:obj]) return;
        new[key] = value;
    }];
    [self setDictionary:new];
}

@end
