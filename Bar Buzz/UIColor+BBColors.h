//
//  UIColor+BBColors.h
//  Bar Buzz
//
//  Created by Owen Yang on 3/6/15.
//  Copyright (c) 2015 Bar Buzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BBColors)

/**
 *  Creates a UIColor with the given hex and alpha values. Hex is given in integer
 *  form. This method is generally called with hex given in hexadecimal form
 *  0xRRGGBB.
 *
 *  @param hex   Hex value of the color
 *  @param alpha Alpha value of the color
 *
 *  @return A UIColor object with the given hex and alpha values.
 */
+ (UIColor*)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor*)BBYellow;
+ (UIColor*)BBOrange;
+ (UIColor*)BBCyan;
+ (UIColor*)BBGray;
+ (UIColor*)BBDarkGray;

@end
