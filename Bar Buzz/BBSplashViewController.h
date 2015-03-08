//
//  BBSplashViewController.h
//  Bar Buzz
//
//  Created by Owen Yang on 3/6/15.
//  Copyright (c) 2015 Bar Buzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSplashViewController : UIViewController

/**
 *  Begins the sequences of animations that results in the view controller's dismissal at the end.
 *  Calls <code>completion</code> after the view controller has been dismissed.
 *
 *  @param completion The block to execute after the view controller has been dismissed
 */
- (void)beginDismissSequence:(void (^)())completion;

@end
