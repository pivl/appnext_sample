//
//  BPAppodealNativeSlotView§.h
//  BuyMeAPie
//
//  Created by Pavel Stasyuk on 04/08/16.
//  Copyright © 2016 BuyMeAPie. All rights reserved.
//

#import "BPAdSlot.h"

@protocol BPAdSlotImpressionable;
@class AppnextAdData;

@interface BPAppNextSlotView : UIView <BPAdSlot>

@property (nonatomic, strong) UIView *adView;
@property (nonatomic, strong) id<BPAdSlotImpressionable> providerOwner;

@property (nonatomic, weak) UIViewController *viewController;
@property (strong, nonatomic) AppnextAdData *attachedNativeAd;

@end
