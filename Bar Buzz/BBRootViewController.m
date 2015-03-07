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
    
    [self presentViewController:[BBSplashViewController new] animated:YES completion:nil];
}

@end
