//
//  BPAppnextProvider.h
//  BuyMeAPie
//
//  Created by Pavel Stasyuk on 04/05/2017.
//  Copyright © 2017 BuyMeAPie. All rights reserved.
//

#import "BPAdContentProvider.h"

@class BPAppNextSlotView;
@class BPAdNativeViews;
@protocol BPAppSettings;

@interface BPAppnextProvider : NSObject<BPAdContentProvider>

@property (nonatomic, weak) id<BPAppSettings> appSettings;

@property (nonatomic, weak) BPAppNextSlotView *slotView;
@property (nonatomic, strong) BPAdNativeViews *nativeViews;

@property (nonatomic, assign) NSTimeInterval rotationInterval;
@property (nonatomic, copy) NSString *statisticsImpressionLabel;

@end
