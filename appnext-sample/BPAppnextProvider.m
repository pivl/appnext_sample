//
//  BPAppnextProvider.m
//  BuyMeAPie
//
//  Created by Pavel Stasyuk on 04/05/2017.
//  Copyright © 2017 BuyMeAPie. All rights reserved.
//

#import "BPAppnextProvider.h"

#import "BPAdNativeView.h"
#import "BPAdNativeViews.h"
#import "UIShadowRoundedImageView.h"
#import "BPAdSlotImpressionProtocols.h"
#import "BPAppNextSlotView.h"
#import "BPAdSlotImpressionsTracker.h"

#import "AppnextAdData.h"
#import "AppnextNativeAdsSDKApi.h"
#import "AppnextNativeAdsRequest.h"
#import "AppnextSDKCorePublicDefs.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface BPAppnextProvider () <BPAdSlotImpressionable,
                                 BPAdNativeViewDelegate,
                                 AppnextNativeAdsRequestDelegate,
                                 AppnextNativeAdOpenedDelegate,
                                 BPAdImpressionsDelegate>

@property (nonatomic, assign) BPAdContentProviderStatus status;
@property (nonatomic, strong) AppnextAdData *currentNativeAd;

@property (nonatomic, strong) AppnextNativeAdsSDKApi *api;

@property (nonatomic, strong) BPAdSlotImpressionsTracker *impressionTracker;

@end


@implementation BPAppnextProvider

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.api = [[AppnextNativeAdsSDKApi alloc] initWithPlacementID:@""];
        self.nativeViews = [BPAdNativeViews new];
        self.rotationInterval = -1;
        self.impressionTracker = [BPAdSlotImpressionsTracker new];
        self.impressionTracker.delegate = self;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleEnterForeground:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleEnterBackground:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BPAppNextSlotView *)createSlotView
{
    BPAppNextSlotView *slotView = self.slotView;
    
    if (slotView == nil) {
        slotView = [[BPAppNextSlotView alloc] initWithFrame:CGRectZero];
        slotView.providerOwner = self;
        slotView.viewController = self.adSlotViewController;
        self.slotView = slotView;
    }
    
    return slotView;
}

- (void)updateNativeView
{
    if (self.slotView) {
        BPAdNativeView *adView = [self.nativeViews viewForSize:self.slotView.bounds.size];
        
        if (adView.adChoicesView == nil) {
            UIImage *image = [UIImage imageNamed:@"i-icon_black"];
            UIButton *privacyButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [privacyButton setImage:image forState:UIControlStateNormal];
            [privacyButton addTarget:self
                              action:@selector(handlePrivacyButton:)
                    forControlEvents:UIControlEventTouchUpInside];
            
            adView.adChoicesView = privacyButton;
        }
        
        [self updateView:adView with:self.currentNativeAd];
        self.slotView.attachedNativeAd = self.currentNativeAd;
        self.slotView.adView = adView;
    }
}

- (void)loadNewAd
{
    AppnextNativeAdsRequest *request = [AppnextNativeAdsRequest new];
    request.creativeType = ANCreativeTypeManaged;
    [self.api loadAds:request withRequestDelegate:self];
}

#pragma mark - <BPAdSlotImpressionable>

- (void)slotViewDidAddToWindow:(id)source
{
    [self.impressionTracker slotViewDidAddToWindow:self];
}

- (void)slotViewDidLoadNewContent:(id)source
{
    [self.impressionTracker slotViewDidLoadNewContent:self];
}

- (void)slotViewDidDealloc:(id)source
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)slotViewDidShow:(id)source
{
    if (self.rotationInterval > 0) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(loadNewAd) withObject:nil afterDelay:self.rotationInterval];
    }
    [self.impressionTracker slotViewDidShow:self];
}

- (void)slotViewDidHide:(id)source
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.impressionTracker slotViewDidHide:self];
}

#pragma mark - <BPAdImpressionsDelegate>

- (void)impressionStarted:(id)impressionSource
{
    NSString *label = @"show";
    if (self.statisticsImpressionLabel != nil) {
        label = [label stringByAppendingFormat:@"_%@", self.statisticsImpressionLabel];
    }
    
    NSLog(@"APPNEXT: IMPRESSION for %@", self.statisticsImpressionLabel);
    [self.api adImpression:self.currentNativeAd];
}

#pragma mark - <BPAdContentProvider>

@synthesize status = _status;
@synthesize adSlotViewController = _adSlotViewController;

- (UIView<BPAdSlot> *)slotViewWithSize:(CGSize)size
{
    UIView<BPAdSlot> *slotView = [self createSlotView];
    
    if (slotView && CGSizeEqualToSize(size, slotView.frame.size) == NO) {
        CGRect viewFrame = slotView.frame;
        viewFrame.size = size;
        slotView.frame = viewFrame;
    }
    
    [self updateNativeView];
    return slotView;
}

- (void)setAdSlotViewController:(UIViewController *)adSlotViewController
{
    if (_adSlotViewController != adSlotViewController) {
        _adSlotViewController = adSlotViewController;
        self.slotView.viewController = _adSlotViewController;
        
        if (self.status == kBPAdContentProviderStatusNotInitialized) {
            self.status = kBPAdContentProviderStatusInitialization;
            [self loadNewAd];
        }
    }
}

#pragma mark - <AppnextNativeAdsRequestDelegate>

- (void)onAdsLoaded:(NSArray *)ads forRequest:(AppnextNativeAdsRequest *)request
{
    AppnextAdData *nativeAd = ads.firstObject;
    
    if (nativeAd == nil) {
        [self loadNewAd];
        return;
    }
    
    self.currentNativeAd = nativeAd;
    [self updateNativeView];

    self.status = kBPAdContentProviderStatusReady;
    
    [self slotViewDidLoadNewContent:self];
    
    if (self.rotationInterval > 0) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(loadNewAd) withObject:nil afterDelay:self.rotationInterval];
    }
}

- (void)onError:(NSString *)error forRequest:(AppnextNativeAdsRequest *)request
{
    if ([error isEqualToString:kAdErrorNoAds]) {
        self.status = kBPAdContentProviderStatusNoAd;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.status = kBPAdContentProviderStatusNotInitialized;
        });
    }
}

#pragma mark - <BPAdNativeViewDelegate>

- (void)adNativeViewCloseButtonTouched:(BPAdNativeView *)adNativeView
{
    NSLog(@"APPNEXT: close clicked");
}

- (void)adClicked:(BPAdNativeView *)adNativeView
{
    if (adNativeView != self.slotView.adView) {
        return;
    }
    
    [self.api adClicked:self.currentNativeAd withAdOpenedDelegate:self];
    NSLog(@"APPNEXT: clicked");
}

#pragma mark - <AppnextNativeAdOpenedDelegate>

- (void)storeOpened:(AppnextAdData *)adData
{
    NSLog(@"APPNEXT: store opened");
}

- (void)onError:(NSString *)error forAdData:(AppnextAdData *)adData
{
    NSLog(@"APPNEXT: error while opening store %@", error);
}

#pragma mark - Notifications

- (void)handleEnterForeground:(NSNotification *)notification
{
    if (self.rotationInterval > 0) {
        [self performSelector:@selector(loadNewAd) withObject:nil afterDelay:self.rotationInterval];
    }
}

- (void)handleEnterBackground:(NSNotification *)notification
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark -

- (void)updateView:(BPAdNativeView *)view with:(AppnextAdData *)nativeAd
{
    view.titleLabel.text = nativeAd.title;
    view.descriptionLabel.text = nativeAd.desc;
    [view.callToActionButton setTitle:nativeAd.buttonText forState:UIControlStateNormal];
    [view.mainImage setImageWithURL:[NSURL URLWithString:nativeAd.urlImgWide]];
    
    [view.iconImageContainer.imageView setImageWithURL:[NSURL URLWithString:nativeAd.urlImg]];
    view.delegate = self;
}

- (void)handlePrivacyButton:(UIButton *)button
{
    [self.api privacyClicked:self.currentNativeAd withPrivacyClickedDelegate:nil];
}

@end
