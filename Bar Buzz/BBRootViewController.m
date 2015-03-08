//
//  BBViewController.m
//  Bar Buzz
//
//  Created by Owen Yang on 3/6/15.
//  Copyright (c) 2015 Bar Buzz. All rights reserved.
//

#import "BBRootViewController.h"

#import "BBSplashViewController.h"

@interface BBRootViewController ()

@end

@implementation BBRootViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    BBSplashViewController *vc = [BBSplashViewController new];
    [self presentViewController:vc animated:NO completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc beginDismissSequence:nil];
        });
    }];
}

@end
