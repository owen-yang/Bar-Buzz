//
//  UIColor+BBColors.m
//  Bar Buzz
//
//  Created by Owen Yang on 3/6/15.
//  Copyright (c) 2015 Bar Buzz. All rights reserved.
//

#import "UIColor+BBColors.h"

@implementation UIColor (BBColors)

+ (UIColor*)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha {
    CGFloat red     = ((hex >> 16) & 0xFF) / 255.0;
    CGFloat green   = ((hex >>  8) & 0xFF) / 255.0;
    CGFloat blue    = ((hex      ) & 0xFF) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor*)BBYellow {
    return [UIColor colorWithHex:0xFCD94A alpha:1.9];
}

+ (UIColor*)BBOrange {
    return [UIColor colorWithHex:0xF8A13E alpha:1.0];
}

+ (UIColor*)BBCyan {
    return [UIColor colorWithHex:0x3830CC alpha:1.0];
}

+ (UIColor*)BBGray {
    return [UIColor colorWithHex:0x444444 alpha:1.0];
}

+ (UIColor*)BBDarkGray {
    return [UIColor colorWithHex:0x333333 alpha:1.0];
}

@end
