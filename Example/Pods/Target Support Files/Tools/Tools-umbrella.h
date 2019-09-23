#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSArray+FOFoundation.h"
#import "NSDictionary+FOFoundation.h"
#import "NSMutableArray+FOFoundation.h"
#import "NSMutableDictionary+FOFoundation.h"
#import "NSString+Widget.h"
#import "UIColor+Widget.h"
#import "UIView+Additions.h"
#import "CommonFunc.h"

FOUNDATION_EXPORT double ToolsVersionNumber;
FOUNDATION_EXPORT const unsigned char ToolsVersionString[];

