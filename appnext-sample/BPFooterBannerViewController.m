//
//  BPFooterBannerViewController.m
//  BuyMeAPie
//
//  Created by Anton Rusanov on 26.12.13.
//  Copyright (c) 2013 BuyMeAPie. All rights reserved.
//

#import "BPFooterBannerViewController.h"

#import "BPAdContentProvider.h"

const CGFloat kBPAdMobPhoneWidth = 320.f;
const CGFloat kBPAdMobPadWidth = 728.f;

const CGFloat kBPAdMobPhoneHeight = 50.f;
const CGFloat kBPAdMobPadHeight = 90.f;

@interface BPFooterBannerViewController ()

@property (nonatomic, strong) UIView *currentBannerView;
@property (nonatomic, strong) UIView *internalAdContentView;

@end

@implementation BPFooterBannerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew;
        [self addObserver:self forKeyPath:@"adContentProvider.status" options:options context:nil];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"adContentProvider.status" context:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    [self initializeBannerWithSize:self.view.bounds.size];

    self.currentBannerView.frame = self.view.bounds;
}

- (void)setCurrentBannerView:(UIView *)currentBannerView
{
    if (_currentBannerView == currentBannerView) {
        return;
    }

    [_currentBannerView removeFromSuperview];
    _currentBannerView = currentBannerView;
    _currentBannerView.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                            CGRectGetHeight(self.view.bounds) - CGRectGetHeight(_currentBannerView.frame) * 0.5);

    if (_currentBannerView) {
        [self.view addSubview:_currentBannerView];
    }
}

- (UIView *)internalAdContentView
{
    if (_internalAdContentView == nil && self.adContentProvider.status == kBPAdContentProviderStatusReady) {
        [self initializeBanner];
    }

    return _internalAdContentView;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *, id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"adContentProvider.status"]) {
        BPAdContentProviderStatus status = self.adContentProvider.status;
        if (status == kBPAdContentProviderStatusReady) {
            self.currentBannerView = self.internalAdContentView;
        }
        else {
            self.currentBannerView = nil;
        }
    }
}

#pragma mark - Initialize Banner

- (void)initializeBanner
{
    [self initializeBannerWithSize:self.view.bounds.size];
}

- (void)initializeBannerWithSize:(CGSize)size
{
    self.internalAdContentView = [self.adContentProvider slotViewWithSize:size];
}

@end
