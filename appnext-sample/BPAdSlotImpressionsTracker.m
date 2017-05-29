//
//  BPAdSlotImpressionsTracker.m
//  BuyMeAPie
//
//  Created by Pavel Stasyuk on 09/12/15.
//  Copyright © 2015 BuyMeAPie. All rights reserved.
//

#import "BPAdSlotImpressionsTracker.h"

@interface BPAdSlotImpressionsTracker () <BPAdImpressionsDelegate>
@end

@interface BPAdSlotImpressionsTracker (State)
- (void)initializeStateMachine;

#pragma mark - State Events
- (BOOL)eventNewContent;
- (BOOL)eventWindows;
- (BOOL)eventShow;
- (BOOL)eventHide;
- (BOOL)eventDealloc;

@end

@implementation BPAdSlotImpressionsTracker

#pragma mark - <BPAdImpressionsDelegate>

- (void)impressionStarted:(id)impressionSource
{
    [self.delegate impressionStarted:self];
}

#pragma mark - <BPAdSlotImpressionable>

- (void)slotViewDidDealloc:(id)source
{
}

- (void)slotViewDidAddToWindow:(id)source
{
}

- (void)slotViewDidLoadNewContent:(id)source
{
    [self impressionStarted:self];
}

- (void)slotViewDidShow:(id)source
{
    [self impressionStarted:self];
}

- (void)slotViewDidHide:(id)source
{
}

@end
