//
//  Created by xiang.song on 06/08/19.
//

#import <Foundation/Foundation.h>

@interface NSArray (FOFoundation)

- (void)fo_each:(void (^)(id object, NSUInteger index))block;

- (void)fo_apply:(void (^)(id object, NSUInteger index))block;

- (NSArray *)fo_map:(id (^)(id object, NSUInteger index))block;

- (id)fo_reduce:(id (^)(id accumulated, id object))block;

- (id)fo_match:(BOOL (^)(id object, NSUInteger index))block;

- (NSArray *)fo_filter:(BOOL (^)(id object, NSUInteger index))block;

- (NSArray *)fo_select:(BOOL (^)(id object, NSUInteger index))block;

- (NSArray *)fo_reject:(BOOL (^)(id object, NSUInteger index))block;

- (BOOL)fo_every:(BOOL (^)(id object, NSUInteger index))block;

- (BOOL)fo_some:(BOOL (^)(id object, NSUInteger index))block;

- (BOOL)fo_notAny:(BOOL (^)(id object, NSUInteger index))block;

- (BOOL)fo_notEvery:(BOOL (^)(id object, NSUInteger index))block;

- (instancetype)fo_evenIndexObjects;

- (instancetype)fo_oddIndexObjects;

- (id)fo_find:(BOOL (^)(id obj))block;

- (BOOL)fo_allObjectsMatched:(BOOL (^)(id obj))block;

- (NSString *)fo_join:(NSString *)seperator;

- (BOOL)fo_existObjectMatch:(BOOL (^)(id obj, NSUInteger index))block;

- (NSArray *)fo_groupBy:(id (^)(id obj))block;

- (NSArray *)fo_zip:(NSArray *)array;

- (NSString *)fo_insertIntoPlaceHolderString:(NSString *)placeHolder;

- (id)fo_reduce:(id)initial withBlock:(id (^)(id sum, id obj))block;

- (instancetype)fo_take:(NSInteger)n;

- (instancetype)fo_withoutFirst:(NSInteger)n;

- (instancetype)fo_last:(NSInteger)n;

- (instancetype)fo_withoutLast:(NSInteger)n;

- (instancetype)fo_flatten;

- (instancetype)fo_seprate:(NSInteger)length;

@end
