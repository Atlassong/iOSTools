//
//  Created by xiang.song on 06/08/19.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (FOFoundation)

- (void)fo_performSelect:(BOOL (^)(id object, id key))block;

- (void)fo_performReject:(BOOL (^)(id object, id key))block;

- (void)fo_performMap:(id (^)(id object, id key))block;

@end
