//
//  BPContentContainer.m
//  BuyMeAPie
//
//  Created by Anton Rusanov on 25.12.13.
//  Copyright (c) 2013 BuyMeAPie. All rights reserved.
//

#import "BPAdViewController.h"
#import "BPFooterBannerViewController.h"
#import "BPAdContentProvider.h"
#import "AppDelegate.h"

const CGFloat kBPCCiPhoneWidth = 320;
const CGFloat kBPCCiPadWidth = 728;

const CGFloat kBPCCiPhoneHeight = 64;
const CGFloat kBPCCiPadHeight = 90;

@interface BPAdViewController ()

@property (nonatomic, assign) BOOL bannerIsHidden;

@end

@implementation BPAdViewController

- (void)dealloc
{
    self.footerBannerViewController = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.footerBannerViewController = [[BPFooterBannerViewController alloc] initWithNibName:nil bundle:nil];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.footerBannerViewController.adContentProvider = delegate.contentProvider;
    self.footerBannerViewController.adContentProvider.adSlotViewController = self;

    self.bannerIsHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.footerBannerViewController initializeBanner];
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController:parent];

    if (parent != nil) {
        self.bannerIsHidden = NO;
        [self layoutAnimated:YES];
    }
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    [super willMoveToParentViewController:parent];

    if (parent == nil) {
        [self.view setNeedsLayout];
    }
}

- (BOOL)hasAd
{
    id provider = self.footerBannerViewController.adContentProvider;
    return provider != nil;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutAnimated:NO];
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    CGSize childContentSize;

    if (container == self.footerBannerViewController) {
        childContentSize = [self sizeForFooterBannerViewControllerForParentSize:parentSize];
    }
    else {
        childContentSize = [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
    }

    return childContentSize;
}

- (CGSize)sizeForFooterBannerViewControllerForParentSize:(CGSize)parentSize
{
    BOOL isRegularSizeClass = self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular;
    CGFloat footerBannerViewHeight = isRegularSizeClass ? kBPCCiPadHeight : kBPCCiPhoneHeight;
    CGSize size = {parentSize.width, footerBannerViewHeight};
    return size;
}

- (void)layoutAnimated:(BOOL)animated
{
    BOOL hasAd = [self hasAd] && !self.bannerIsHidden && self.footerBannerViewController.adContentProvider.status == kBPAdContentProviderStatusReady;

    CGSize footerBannerViewSize = [self sizeForFooterBannerViewControllerForParentSize:self.view.bounds.size];
    CGRect contentViewFrame = UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(0.f, 0.f, footerBannerViewSize.height, 0.f));

    CGRect footerBannerViewFrame = {.origin = {0., CGRectGetHeight(self.view.bounds) - footerBannerViewSize.height},
                                    .size = footerBannerViewSize};

    if (!hasAd) {
        footerBannerViewFrame.origin.y += footerBannerViewFrame.size.height;
        contentViewFrame = self.view.bounds;
    }

    void (^animation)() = ^() {
        self.footerBannerViewController.view.frame = footerBannerViewFrame;
    };

    void (^completion)(BOOL finished) = ^(BOOL finished) {
        self.contentViewController.view.frame = contentViewFrame;
    };

    if (animated) {
        [UIView animateWithDuration:0.25 animations:animation completion:completion];
    }
    else {
        animation();
        completion(YES);
    }
}

- (void)setContentViewController:(UIViewController *)contentViewController
{
    [_contentViewController removeFromParentViewController];
    [_contentViewController.view removeFromSuperview];

    _contentViewController = contentViewController;

    [self addChildViewController:_contentViewController];
    [self.view addSubview:_contentViewController.view];

    _contentViewController.view.frame = self.view.bounds;

    if (_contentViewController.view) {
        [self.view sendSubviewToBack:_contentViewController.view];
    }
}

- (void)setFooterBannerViewController:(BPFooterBannerViewController *)footerBannerController
{
    [_footerBannerViewController removeObserver:self forKeyPath:@"adContentProvider.status"];

    [_footerBannerViewController willMoveToParentViewController:nil];
    [_footerBannerViewController.view removeFromSuperview];
    [_footerBannerViewController removeFromParentViewController];

    _footerBannerViewController = footerBannerController;

    if (_footerBannerViewController) {
        CGSize bannerSize = [self sizeForFooterBannerViewControllerForParentSize:self.view.bounds.size];

        CGRect frame = {.origin = {.0, self.view.bounds.size.height - bannerSize.height}, .size = bannerSize};

        footerBannerController.view.frame = frame;

        [self addChildViewController:footerBannerController];
        [self.view addSubview:footerBannerController.view];
        [footerBannerController didMoveToParentViewController:self];

        NSKeyValueObservingOptions observingOptions = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        [_footerBannerViewController addObserver:self forKeyPath:@"adContentProvider.status" options:observingOptions context:NULL];
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.footerBannerViewController) {
        if ([keyPath isEqualToString:@"adContentProvider.status"]) {
            NSValue *currentAdStatus = @(self.footerBannerViewController.adContentProvider.status);
            NSValue *oldAdStatus = change[NSKeyValueChangeOldKey];
            NSValue *adStatusReady = @(kBPAdContentProviderStatusReady);

            if ([currentAdStatus isEqual:adStatusReady] && ![oldAdStatus isEqual:adStatusReady]) {
                [self layoutAnimated:YES];
            }
            else if (![currentAdStatus isEqual:adStatusReady] && [oldAdStatus isEqual:adStatusReady]) {
                [self.view setNeedsLayout];
            }
        }
    }
}

@end
