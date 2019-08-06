//
//  Created by xiang.song on 06/08/19.
//

#import "NSMutableArray+FOFoundation.h"

@implementation NSMutableArray (FOFoundation)

- (void)fo_performSelect:(BOOL (^)(id, NSUInteger))block
{
    NSParameterAssert(block);
    NSIndexSet *list = [self indexesOfObjectsPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block) {
            return !block(obj, idx);
        }
        return NO;
    }];
    if (!list.count) return;
    [self removeObjectsAtIndexes:list];
}

- (void)fo_performReject:(BOOL (^)(id, NSUInteger))block
{
    NSParameterAssert(block);
    return [self fo_performSelect:^BOOL(id object, NSUInteger index) {
        if (block) {
            return !block(object, index);
        }
        return NO;
    }];
}

- (void)fo_performMap:(id (^)(id, NSUInteger))block
{
    NSParameterAssert(block);
    NSMutableArray *new = [self mutableCopy];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id value = block(obj, idx) ?: [NSNull null];
        if ([value isEqual:obj]) return;
        new[idx] = value;
    }];
    [self setArray:new];
}

@end
