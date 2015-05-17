//
//  BBBar.h
//  Bar Buzz
//
//  Created by Owen Yang on 5/17/15.
//  Copyright (c) 2015 Bar Buzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBBar : NSObject

@property (nonatomic, strong) NSString *address;
@property (nonatomic) CGFloat lat;
@property (nonatomic) CGFloat lng;
@property (nonatomic, readonly) CGFloat distance; // from user's position

// not implemented yet
//@property (nonatomic) CGFloat rating;
//@property (nonatomic, strong) NSArray *promotions;

- (instancetype)initWithAddress:(NSString*)address
                            lat:(CGFloat)lat
                            lng:(CGFloat)lng;

@end
