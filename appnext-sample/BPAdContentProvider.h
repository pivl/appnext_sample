//
//  AdContentProvider.h
//  BuyMeAPie
//
//  Created by Pavel Stasyuk on 08/10/15.
//  Copyright © 2015 BuyMeAPie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BPAdSlot;

typedef NS_ENUM(NSInteger, BPAdContentProviderStatus) {
    kBPAdContentProviderStatusNotInitialized = 0,
    kBPAdContentProviderStatusInitialization = 1,
    kBPAdContentProviderStatusReady = 2,
    kBPAdContentProviderStatusNoAd = 3
};

@protocol BPAdContentProvider <NSObject>

@property (nonatomic, readonly) BPAdContentProviderStatus status;
@property (nonatomic, weak) UIViewController *adSlotViewController;

- (UIView<BPAdSlot> *)slotViewWithSize:(CGSize)size;

@end
