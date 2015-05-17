//
//  BBSBars.m
//  Bar Buzz
//
//  Created by Owen Yang on 5/16/15.
//  Copyright (c) 2015 Bar Buzz. All rights reserved.
//

#import "BBSBars.h"
#import "BBNetworking.h"

@interface BBSBars ()

@property (nonatomic, strong) NSMutableArray *barsArray;
@property (nonatomic) NSUInteger searchRadius;

@end

@implementation BBSBars

+ (BBSBars*)bars {
    static BBSBars *bars;
    dispatch_once_t barsToken;
    dispatch_once(&barsToken, ^{
        bars = [self new];
    });
    return bars;
}

+ (void)initialize {
    [super initialize];
    [self bars];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.searchRadius = [[NSUserDefaults standardUserDefaults] integerForKey:@"searchRadius"];
        if (!self.searchRadius) {
            self.searchRadius = 1; // default 1 mile search radius
        }
        self.barsArray = [NSMutableArray new];
    }
    return self;
}

- (void)reloadBars {
#warning add parameters for current location
    [BBNetworking sendAsynchronousRequestType:BBRequestTypeGET toRoute:BBRequestRouteAPIBarsLocate appending:nil parameters:nil withJSONBody:nil block:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error || [(NSHTTPURLResponse*)response statusCode] >= 300) {
            [[NSNotificationCenter defaultCenter] postNotificationName:BBNotificationBarsUpdateFailed object:self userInfo:error.userInfo];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:BBNotificationBarsUpdated object:self userInfo:nil];
        }
    }];
}

#pragma mark - Setters/Getters

+ (void)setSearchRadius:(NSUInteger)searchRadius {
    self.searchRadius = searchRadius;
}

+ (NSUInteger)searchRadius {
    return self.searchRadius;
}


@end
