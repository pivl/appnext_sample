//
//  BPAdSlotDelegate.h
//  BuyMeAPie
//
//  Created by Pavel Stasyuk on 09/12/15.
//  Copyright © 2015 BuyMeAPie. All rights reserved.
//

@import Foundation;

#pragma mark -

@protocol BPAdSlotImpressionable <NSObject>

- (void)slotViewDidDealloc:(id)source;
- (void)slotViewDidAddToWindow:(id)source;
- (void)slotViewDidLoadNewContent:(id)source;
- (void)slotViewDidShow:(id)source;
- (void)slotViewDidHide:(id)source;

@end

#pragma mark -

@protocol BPAdImpressionsDelegate <NSObject>
- (void)impressionStarted:(id)impressionSource;
@end
