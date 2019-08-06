//
//  Created by xiang.song on 06/08/19.
//

#import "NSDictionary+FOFoundation.h"

@implementation NSDictionary (FOFoundation)

- (void)fo_each:(void (^)(id, id))block
{
    NSParameterAssert(block);
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (block) {
            block(obj, key);
        }
    }];
}

- (void)fo_apply:(void (^)(id, id))block
{
    NSParameterAssert(block);
    [self enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent
                                  usingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL *_Nonnull stop){
                                      if (block) {
                                          block(obj, key);
                                      }
                                  }];
}

- (NSDictionary *)fo_map:(id (^)(id, id))block
{
    NSParameterAssert(block);
    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionaryWithCapacity:self.count];
    for (id key in self) {
        id value = self[key];
        id result = nil;
        if (block) {
            result = block(value, key);
        }
        if (!result) {
            result = [NSNull null];
        }
        resultDictionary[key] = result;
    }
    return [resultDictionary copy];
}

- (id)fo_reduce:(id (^)(id, id, id))block
{
    NSParameterAssert(block);
    id accumulated = nil;
    for (id key in self) {
        id value = self[key];
        if (!accumulated) {
            accumulated = value;
        } else {
            if (block) {
                accumulated = block(accumulated, value, key);
            }
        }
    }
    return accumulated;
}

- (id)fo_match:(BOOL (^)(id, id))block
{
    NSParameterAssert(block);
    id result = nil;
    for (id key in self) {
        id value = self[key];
        if (block) {
            if (block(value, key)) {
                result = value;
                break;
            }
        }
    }
    return result;
}

- (NSDictionary *)fo_filter:(BOOL (^)(id, id))block
{
    NSParameterAssert(block);
    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionary];
    for (id key in self) {
        id value = self[key];
        if (block && block(value, key)) {
            resultDictionary[key] = value;
        }
    }
    return [resultDictionary copy];
}

- (NSDictionary *)fo_select:(BOOL (^)(id, id))block
{
    NSParameterAssert(block);
    return [self fo_filter:block];
}

- (NSDictionary *)fo_reject:(BOOL (^)(id, id))block
{
    NSParameterAssert(block);
    return [self fo_select:^BOOL(id object, id key) {
        if (block) {
            return !block(object, key);
        }
        return NO;
    }];
}

- (BOOL)fo_every:(BOOL (^)(id, id))block
{
    NSParameterAssert(block);
    BOOL result = YES;
    for (id key in self) {
        id value = self[key];
        if (block) {
            result = block(value, key);
        }
        if (!result) {
            break;
        }
    }
    return result;
}

- (BOOL)fo_some:(BOOL (^)(id, id))block
{
    NSParameterAssert(block);
    BOOL result = NO;
    for (id key in self) {
        id value = self[key];
        if (block) {
            result = block(value, key);
        }
        if (result) {
            break;
        }
    }
    return result;
}

- (BOOL)fo_notAny:(BOOL (^)(id, id))block
{
    return ![self fo_some:block];
}

- (BOOL)fo_notEvery:(BOOL (^)(id, id))block
{
    return ![self fo_every:block];
}

- (void)fo_mergeToDestinationDic:(NSMutableDictionary *)mergedDic withAnotherDic:(NSDictionary *)dic
{
    NSParameterAssert(mergedDic);
    NSParameterAssert(dic);
    
    [mergedDic addEntriesFromDictionary:self];
    [mergedDic addEntriesFromDictionary:dic];
}

- (NSDictionary *)fo_merge:(NSDictionary *)other {
    NSMutableDictionary *merged = [self mutableCopy];
    [other enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull src, BOOL * _Nonnull stop) {
        id dst = merged[key];
        if (dst) {
            if ([src isKindOfClass:[NSDictionary class]] && [dst isKindOfClass:[NSDictionary class]]) {
                merged[key] = [dst fo_merge:src];
            } else {
                merged[key] = src;
            }
        } else {
            merged[key] = src;
        }
    }];
    return merged;
}
#pragma mark - DictionaryToQuery
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (NSString *)URLEncode:(NSString *)value {
	return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
																				 (CFStringRef)value,
																				 NULL, // characters to leave unescaped
																				 CFSTR(":!*();@/&?+$,='"),
																				 kCFStringEncodingUTF8);
}

#pragma clang diagnostic pop

- (id)convertRequestValue:(id)value {
	if ([value isKindOfClass:[NSNumber class]]) {
		value = ((NSNumber *)value).stringValue;
	} else if ([value isKindOfClass:[NSURL class]]) {
		value = ((NSURL *)value).absoluteString;
	}
	return value;
}
- (NSString *)fo_queryString {
	NSMutableString *queryString = [[NSMutableString alloc] init];
	__block BOOL hasParameters = NO;
	
	NSMutableArray<NSString *> *keys = [self.allKeys mutableCopy];
	// remove non-string keys, as they are not valid
	[keys filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
		return [evaluatedObject isKindOfClass:[NSString class]];
	}]];
	// sort the keys so that the query string order is deterministic
	[keys sortUsingSelector:@selector(compare:)];
	
	for (NSString *key in keys) {
		id value = [self convertRequestValue:self[key]];
		if ([value isKindOfClass:[NSString class]]) {
			value = [self URLEncode:value];
		}
		if (value) {
			if (hasParameters) {
				[queryString appendString:@"&"];
			}
			[queryString appendFormat:@"%@=%@", key, value];
			hasParameters = YES;
		}
	}
	return (queryString.length ? [queryString copy] : nil);
}

@end
