//
//  NSString+Widget.h
//  MissYou
//
//  Created by Atlas on 14-9-17.
//  Copyright (c) 2014年 Atlas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSString (Widget)
/**
 *  计算字符串CGSize
 */
- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font;
- (BOOL)contains:(NSString*)string;
- (BOOL)isValidEmail;
- (NSString*)add:(NSString*)string;
- (NSDictionary*)firstAndLastName;
- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;
- (NSString*)safeSubstringToIndex:(NSUInteger)index;
- (NSString*)stringByRemovingPrefix:(NSString*)prefix;
- (NSString*)stringByRemovingPrefixes:(NSArray*)prefixes;
- (BOOL)hasPrefixes:(NSArray*)prefixes;
- (BOOL)isEqualToOneOf:(NSArray*)strings;

/**
 *  返回Base64字符串
 */
-(NSString *)base64String;
/**
 *  从Base64字符串返回正常字符串
 */
-(NSString *)fromBase64String;

/**
 *  返回Base64形式的Data
 */
-(NSData *)base64Data;

/**
 *  返回Data
 */
-(NSData *)nsData;
/**
 *  3DES加解密
 */
-(NSString*)TripleDES:(NSString*)keyString encryptOrDecrypt:(CCOperation)encryptOrDecrypt;
@end
