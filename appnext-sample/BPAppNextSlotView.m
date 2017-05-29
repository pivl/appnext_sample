//
//  BPAppodealNativeSlotView§.m
//  BuyMeAPie
//
//  Created by Pavel Stasyuk on 04/08/16.
//  Copyright © 2016 BuyMeAPie. All rights reserved.
//

#import "BPAppNextSlotView.h"

#import "BPAdSlotImpressionProtocols.h"
#import <Masonry/Masonry.h>
#import "AppnextAdData.h"

@implementation BPAppNextSlotView

- (void)dealloc
{
    [self.providerOwner slotViewDidDealloc:self];
}

- (void)setAdView:(UIView *)adView
{
    if (_adView == adView) {
        return;
    }
    
    [_adView removeFromSuperview];
    _adView = adView;
    [self addSubview:_adView];
    [self setNeedsUpdateConstraints];
    [self updateAttachedNativeAd];
}

- (void)setViewController:(UIViewController *)viewController
{
    _viewController = viewController;
    [self updateAttachedNativeAd];
}

- (void)setAttachedNativeAd:(AppnextAdData *)attachedNativeAd
{
    if (_attachedNativeAd != attachedNativeAd) {
        _attachedNativeAd = attachedNativeAd;
        [self updateAttachedNativeAd];
    }
}

- (void)updateConstraints
{
    [self.adView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [super updateConstraints];
}

#pragma mark - UIView

- (void)didMoveToWindow
{
    if (self.window) {
        [self.providerOwner slotViewDidAddToWindow:self];
    }
}

#pragma mark - <BPAdSlot>

- (void)wasHidden
{
    [self.providerOwner slotViewDidHide:self];
}

- (void)wasUnHidden
{
    [self.providerOwner slotViewDidShow:self];
}

- (void)advanceToNextAd
{
}

#pragma mark -

- (void)updateAttachedNativeAd
{
}

@end
