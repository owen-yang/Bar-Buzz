//
//  BBBar.m
//  Bar Buzz
//
//  Created by Owen Yang on 5/17/15.
//  Copyright (c) 2015 Bar Buzz. All rights reserved.
//

#import "BBBar.h"

@interface BBBar ()
@property (nonatomic) CGFloat distance;
@end

@implementation BBBar

- (instancetype)initWithAddress:(NSString*)address
                            lat:(CGFloat)lat
                            lng:(CGFloat)lng
{
    self = [super init];
    if (self) {
        self.address = address;
        self.lat = lat;
        self.lng = lng;
    }
    return self;
}

- (void)setLat:(CGFloat)lat {
    _lat = lat;
    [self updateDistance];
}

- (void)setLng:(CGFloat)lng {
    _lng = lng;
    [self updateDistance];
}

- (void)updateDistance {
    // update distance
}

@end
