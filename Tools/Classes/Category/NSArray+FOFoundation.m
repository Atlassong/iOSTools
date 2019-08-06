//
//  Created by xiang.song on 06/08/19.
//

#import "NSArray+FOFoundation.h"

@implementation NSArray (FOFoundation)

- (void)fo_each:(void (^)(id, NSUInteger))block
{
    NSParameterAssert(block);
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block) {
            block(obj, idx);
        }
    }];
}

- (void)fo_apply:(void (^)(id, NSUInteger))block
{
    NSParameterAssert(block);
    [self enumerateObjectsWithOptions:NSEnumerationConcurrent
                           usingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop){
                               if (block) {
                                   block(obj, idx);
                               }
                           }];
}

- (NSArray *)fo_map:(id (^)(id, NSUInteger))block
{
    NSParameterAssert(block);
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:self.count];
    NSUInteger index = 0;
    for (id object in self) {
        id result = nil;
        if (block) {
            result = block(object, index++);
        }
        if (!result) {
            result = [NSNull null];
        }
        [resultArray addObject:result];
    }
    return [resultArray copy];
}

- (id)fo_reduce:(id (^)(id, id))block
{
    NSParameterAssert(block);
    id accumulated = nil;
    for (id object in self) {
        if (!accumulated) {
            accumulated = object;
        } else {
            if (block) {
                accumulated = block(accumulated, object);
            }
        }
    }
    return accumulated;
}

- (id)fo_match:(BOOL (^)(id, NSUInteger))block
{
    NSParameterAssert(block);
    id result = nil;
    NSUInteger index = 0;
    for (id object in self) {
        if (block) {
            if (block(object, index++)) {
                result = object;
                break;
            }
        }
    }
    return result;
}

- (id)fo_find:(BOOL (^)(id obj))block {
    NSParameterAssert(block);
    for (id obj in self) {
        if (block && block(obj)) {
            return obj;
        }
    }
    return nil;
}

- (NSArray *)fo_filter:(BOOL (^)(id, NSUInteger))block
{
    NSParameterAssert(block);
    NSMutableArray *resultArray = [NSMutableArray array];
    NSUInteger index = 0;
    for (id object in self) {
        if (block && block(object, index++)) {
            [resultArray addObject:object];
        }
    }
    return [resultArray copy];
}

- (NSArray *)fo_select:(BOOL (^)(id, NSUInteger))block
{
    NSParameterAssert(block);
    return [self fo_filter:block];
}

- (NSArray *)fo_reject:(BOOL (^)(id, NSUInteger))block
{
    NSParameterAssert(block);
    return [self fo_select:^BOOL(id object, NSUInteger index) {
        if (block) {
            return !block(object, index);
        }
        return NO;
    }];
}

- (BOOL)fo_every:(BOOL (^)(id, NSUInteger))block
{
    NSParameterAssert(block);
    BOOL result = YES;
    NSUInteger index = 0;
    for (id object in self) {
        if (block) {
            result = block(object, index++);
        }
        if (!result) {
            break;
        }
    }
    return result;
}

- (BOOL)fo_some:(BOOL (^)(id, NSUInteger))block
{
    NSParameterAssert(block);
    BOOL result = NO;
    NSUInteger index = 0;
    for (id object in self) {
        if (block) {
            result = block(object, index++);
        }
        if (result) {
            break;
        }
    }
    return result;
}

- (BOOL)fo_notAny:(BOOL (^)(id, NSUInteger))block
{
    return ![self fo_some:block];
}

- (BOOL)fo_notEvery:(BOOL (^)(id, NSUInteger))block
{
    return ![self fo_every:block];
}

- (instancetype)fo_evenIndexObjects {
    NSMutableArray *array = [NSMutableArray array];
    NSInteger index = 0;
    for (id obj in self) {
        if (index % 2 == 0) {
            [array addObject:obj];
        }
        index += 1;
    }
    return array;
}

- (instancetype)fo_oddIndexObjects {
    NSMutableArray *array = [NSMutableArray array];
    NSInteger index = 0;
    for (id obj in self) {
        if (index % 2 == 1) {
            [array addObject:obj];
        }
        index += 1;
    }
    return array;
}

- (BOOL)fo_allObjectsMatched:(BOOL (^)(id obj))block {
    for (id obj in self) {
        if (block) {
            if (!block(obj)) {
                return NO;
            }
        }
    }
    return YES;
}

- (NSString *)fo_join:(NSString *)seperator {
    NSMutableString *string = [NSMutableString string];
    [self fo_each:^(id obj, NSUInteger index) {
        if (index != 0) {
            [string appendString:seperator];
        }
        [string appendString:obj];
    }];
    return string;
}

- (BOOL)fo_existObjectMatch:(BOOL (^)(id obj, NSUInteger index))block {
    return [self fo_match:block] != nil;
}

- (NSArray *)fo_groupBy:(id (^)(id obj))block {
    NSParameterAssert(block);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (id obj in self) {
        if (block) {
            NSString *key = block(obj);
            if (dic[key] == nil) {
                dic[key] = [NSMutableArray array];
            }
            [dic[key] addObject:obj];
        }
    }
    return [dic allValues];
}

- (NSArray *)fo_zip:(NSArray *)array {
    NSMutableArray *result = [NSMutableArray array];
    [self fo_each:^(id obj, NSUInteger index) {
        [result addObject:obj];
        if (index >= array.count) return;
        [result addObject:array[index]];
    }];
    return result;
}

- (NSString *)fo_insertIntoPlaceHolderString:(NSString *)placeHolder {
    NSArray *components = [placeHolder componentsSeparatedByString:@"%%"];
    if ([components count] < 2) return placeHolder;
    return [[components fo_zip:self] fo_join:@""];
}

- (id)fo_reduce:(id)initial withBlock:(id (^)(id sum, id obj))block {
    if (!block) {
        NSParameterAssert(block != nil);
        return initial;
    }
    id result = initial;
    
    for (id obj in self) {
        result = block(result, obj);
    }
    return result;
}

- (instancetype)fo_take:(NSInteger)n {
    if (n >= self.count) return self;
    return [self subarrayWithRange:NSMakeRange(0, n)];
}

- (instancetype)fo_withoutFirst:(NSInteger)n {
    if (n >= self.count) return @[];
    return [self subarrayWithRange:NSMakeRange(n, self.count - n)];
}

- (instancetype)fo_last:(NSInteger)n {
    if (n >= self.count) return self;
    return [self subarrayWithRange:NSMakeRange(self.count - n, n)];
}

- (instancetype)fo_withoutLast:(NSInteger)n {
    if (n >= self.count) return @[];
    return [self subarrayWithRange:NSMakeRange(0, self.count - n)];
}

- (instancetype)fo_seprate:(NSInteger)length
{
    NSMutableArray * array = [@[] mutableCopy];
    for (int i = 0; i < self.count; i += length) {
        if (i + length <= self.count) {
            [array addObject:[self subarrayWithRange:(NSRange){i, length}]];
        } else {
            [array addObject:[self fo_last:self.count - i]];
        }
    }
    return array;
}

- (instancetype)fo_flatten {
    NSMutableArray *array = [NSMutableArray array];
    for (NSArray *subArray in self) {
        if ([subArray isKindOfClass:[NSArray class]]) {
            for (id obj in subArray) {
                [array addObject:obj];
            }
        } else {
            id obj = subArray;
            [array addObject:obj];
        }
    }
    return array;
}


@end
