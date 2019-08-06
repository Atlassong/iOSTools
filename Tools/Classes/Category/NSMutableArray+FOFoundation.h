//
//  Created by xiang.song on 06/08/19.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (FOFoundation)

- (void)fo_performSelect:(BOOL (^)(id object, NSUInteger index))block;

- (void)fo_performReject:(BOOL (^)(id object, NSUInteger index))block;

- (void)fo_performMap:(id (^)(id object, NSUInteger index))block;

@end
