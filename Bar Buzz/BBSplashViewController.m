//
//  BBSplashViewController.m
//  Bar Buzz
//
//  Created by Owen Yang on 3/6/15.
//  Copyright (c) 2015 Bar Buzz. All rights reserved.
//

#import "BBSplashViewController.h"

@interface BBSplashViewController ()

// "Bar" and "Buzz" labels
@property (nonatomic, strong) UILabel *barLabel;
@property (nonatomic, strong) UILabel *buzzLabel;

// Lines above and below "Bar Buzz"
// Lines are labelled such that 1 corresponds to the topmost top line
// and bottommost bottom line.
@property (nonatomic, strong) UIView *topLine1;
@property (nonatomic, strong) UIView *topLine2;
@property (nonatomic, strong) UIView *topLine3;
@property (nonatomic, strong) UIView *bottomLine3;
@property (nonatomic, strong) UIView *bottomLine2;
@property (nonatomic, strong) UIView *bottomLine1;

@property (nonatomic, strong) NSArray *lines;

@property (nonatomic, strong) NSMutableArray *linesConstraints;
@property (nonatomic, strong) NSMutableArray *titleConstraints;

@end

@implementation BBSplashViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self loadSubviews];
    [self autoLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)loadSubviews {
    CGFloat titleHeight = [UIScreen mainScreen].bounds.size.height * 0.15;
    
    self.barLabel = [UILabel new];
    self.barLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@"Bar"];
    self.barLabel.textColor = [UIColor BBOrange];
    self.barLabel.font = [UIFont fontWithName:BBLogoFont size:titleHeight];
    self.barLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.barLabel];
    
    self.buzzLabel = [UILabel new];
    self.buzzLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@"Buzz"];
    self.buzzLabel.textColor = [UIColor BBOrange];
    self.buzzLabel.font = [UIFont fontWithName:BBLogoFont size:titleHeight];
    self.barLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.buzzLabel];
    
    self.topLine1 = [UIView new];
    self.topLine2 = [UIView new];
    self.topLine3 = [UIView new];
    self.bottomLine3 = [UIView new];
    self.bottomLine2 = [UIView new];
    self.bottomLine1 = [UIView new];
    
    self.topLine1.backgroundColor = self.bottomLine1.backgroundColor = [UIColor BBYellow];
    self.topLine2.backgroundColor = self.bottomLine2.backgroundColor = [UIColor BBCyan];
    self.topLine3.backgroundColor = self.bottomLine3.backgroundColor = [UIColor BBYellow];
    
    self.lines = @[self.topLine1, self.topLine2, self.topLine3, self.bottomLine3, self.bottomLine2, self.bottomLine1];
    for (UIView *view in self.lines) {
        [self.view addSubview:view];
    }
}

- (void)autoLayoutSubviews {
    self.titleConstraints = [NSMutableArray new];
    self.linesConstraints = [NSMutableArray new];
    
    for (UIView *view in self.view.subviews) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    NSDictionary *views = @{
                            @"barLabel"     :   self.barLabel,
                            @"buzzLabel"    :   self.buzzLabel,
                            
                            @"topLine1"     :   self.topLine1,
                            @"topLine2"     :   self.topLine2,
                            @"topLine3"     :   self.topLine3,
                            @"bottomLine3"     :   self.bottomLine3,
                            @"bottomLine2"     :   self.bottomLine2,
                            @"bottomLine1"     :   self.bottomLine1
                            };
    
    NSDictionary *metrics = @{
                              @"sidePadding"    :   @10,
                              @"linePadding"    :   @10
                              };
    
    [self.titleConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-sidePadding-[barLabel]" options:0 metrics:metrics views:views]];
    [self.titleConstraints addObject:[NSLayoutConstraint constraintWithItem:self.barLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [self.titleConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[buzzLabel]-sidePadding-|" options:0 metrics:metrics views:views]];
    [self.titleConstraints addObject:[NSLayoutConstraint constraintWithItem:self.buzzLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    CGFloat line1WidthMultiplier = 0.22;
    CGFloat line2WidthMultiplier = line1WidthMultiplier * 2;
    CGFloat line3WidthMultiplier = line1WidthMultiplier * 4;
    
    // Lines width
    [self.linesConstraints addObject:[NSLayoutConstraint constraintWithItem:self.topLine1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:line1WidthMultiplier constant:0]];
    [self.linesConstraints addObject:[NSLayoutConstraint constraintWithItem:self.topLine2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:line2WidthMultiplier constant:0]];
    [self.linesConstraints addObject:[NSLayoutConstraint constraintWithItem:self.topLine3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:line3WidthMultiplier constant:0]];
    [self.linesConstraints addObject:[NSLayoutConstraint constraintWithItem:self.bottomLine3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:line3WidthMultiplier constant:0]];
    [self.linesConstraints addObject:[NSLayoutConstraint constraintWithItem:self.bottomLine2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:line2WidthMultiplier constant:0]];
    [self.linesConstraints addObject:[NSLayoutConstraint constraintWithItem:self.bottomLine1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:line1WidthMultiplier constant:0]];
    
    // Set one line's height, set all other heights equal to that one
    [self.linesConstraints addObject:[NSLayoutConstraint constraintWithItem:self.topLine1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.01 constant:0]];
    [self.linesConstraints addObject:[NSLayoutConstraint constraintWithItem:self.topLine2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topLine1 attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [self.linesConstraints addObject:[NSLayoutConstraint constraintWithItem:self.topLine3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topLine1 attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [self.linesConstraints addObject:[NSLayoutConstraint constraintWithItem:self.bottomLine3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topLine1 attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [self.linesConstraints addObject:[NSLayoutConstraint constraintWithItem:self.bottomLine2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topLine1 attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [self.linesConstraints addObject:[NSLayoutConstraint constraintWithItem:self.bottomLine1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topLine1 attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    [self.linesConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLine1]-linePadding-[topLine2]-linePadding-[topLine3]-20-[barLabel]" options:NSLayoutFormatAlignAllLeft metrics:metrics views:views]];
    [self.linesConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[buzzLabel]-20-[bottomLine3]" options:0 metrics:nil views:views]];
    [self.linesConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomLine3]-linePadding-[bottomLine2]-linePadding-[bottomLine1]" options:NSLayoutFormatAlignAllLeft metrics:metrics views:views]];
    
    [self.linesConstraints addObject:[NSLayoutConstraint constraintWithItem:self.bottomLine3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.barLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
    [self.view addConstraints:self.titleConstraints];
    [self.view addConstraints:self.linesConstraints];
    
    
}

- (void)viewDidLayoutSubviews {
    for (UIView *line in self.lines) {
        line.layer.masksToBounds = YES;
        line.layer.cornerRadius = line.frame.size.height / 2;
    }
}

static const CGFloat kLineAnimationDuration = 0.30;

- (void)animateLinesWithReset:(BOOL)reset completion:(void (^)())completion {
    static NSUInteger index = 0;
    index = reset ? 0 : index + 1;
    
    [UIView animateWithDuration:kLineAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = [self.lines[index] frame];
                         frame.origin.x = self.view.frame.size.width;
                         [self.lines[index] setFrame:frame];
                         
                         frame = [self.lines[self.lines.count-index-1] frame];
                         frame.origin.x = self.view.frame.size.width;
                         [self.lines[self.lines.count-index-1] setFrame:frame];
                     }
                     completion:^(BOOL finished) {
                         if (index >= self.lines.count / 2) {
                             [self.view removeConstraints:self.linesConstraints];
                             !completion ?: completion();
                         } else {
                             [self animateLinesWithReset:NO completion:completion];
                         }
                     }];
}

static const CGFloat kTitleFadeDuration = 0.10; // how long it takes for the title to fade (in seconds)
static const CGFloat kTitleFadeSteps = 25;      // how many steps from alpha = 1.0 to alpha = 0.0
static const CGFloat kTitleMoveDuration = 0.50; // how long it takes for the title to move (in seconds)

static const CGFloat titleFadeSecondsPerStep = kTitleFadeDuration / kTitleFadeSteps;
static const CGFloat titleFadeStep = 1 / kTitleFadeSteps;

- (void)animateTitleWithReset:(BOOL)reset completion:(void (^)())completion {
    static CGFloat alpha = 1.0;
    alpha = reset ? 1.0 : alpha - titleFadeStep;
    
    if (alpha + titleFadeStep > 0.0) {
        NSMutableAttributedString *mutableAttributedString = [self.barLabel.attributedText mutableCopy];
        for (NSUInteger i = 1; i < self.barLabel.attributedText.length; i ++) {
            [mutableAttributedString enumerateAttribute:NSForegroundColorAttributeName
                                                inRange:NSMakeRange(i, 1)
                                                options:0
                                             usingBlock:^(id value, NSRange range, BOOL *stop) {
                                                 [mutableAttributedString addAttribute:NSForegroundColorAttributeName
                                                                                 value:[value colorWithAlphaComponent:alpha]
                                                                                 range:range];
                                             }];
            
        }
        self.barLabel.attributedText = [mutableAttributedString copy];
        
        mutableAttributedString = [self.buzzLabel.attributedText mutableCopy];
        for (NSUInteger i = 1; i < self.buzzLabel.attributedText.length; i ++) {
            [mutableAttributedString enumerateAttribute:NSForegroundColorAttributeName
                                                inRange:NSMakeRange(i, 1)
                                                options:0
                                             usingBlock:^(id value, NSRange range, BOOL *stop) {
                                                 [mutableAttributedString addAttribute:NSForegroundColorAttributeName
                                                                                 value:[value colorWithAlphaComponent:alpha]
                                                                                 range:range];
                                             }];
            
        }
        self.buzzLabel.attributedText = [mutableAttributedString copy];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(titleFadeSecondsPerStep * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self animateTitleWithReset:NO completion:completion];
        });
    } else {
        [UIView animateWithDuration:kTitleMoveDuration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect frame = self.barLabel.frame;
                             frame.origin.x = self.view.center.x - self.barLabel.font.pointSize * 0.6;
                             frame.origin.y += self.barLabel.font.pointSize * 0.25 + frame.size.height * 0.5 - self.barLabel.font.pointSize * 0.45;
                             self.barLabel.frame = frame;
                             
                             frame = self.buzzLabel.frame;
                             frame.origin.x = self.view.center.x;
                             frame.origin.y -= self.buzzLabel.font.pointSize * 0.25 + frame.size.height * 0.5 - self.buzzLabel.font.pointSize * 0.45;
                             self.buzzLabel.frame = frame;
                         }
                         completion:^(BOOL finished) {
//                             [self.view removeConstraints:self.titleConstraints];
                             !completion ?: completion();
                         }];
    }
}

- (void)beginDismissSequence:(void (^)())completion {
    [self animateLinesWithReset:YES completion:^{
        [self animateTitleWithReset:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:completion];
            });
        }];
    }];
}

@end
