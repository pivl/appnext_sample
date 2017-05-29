//
//  BPAdSlotImpressionsTracker.h
//  BuyMeAPie
//
//  Created by Pavel Stasyuk on 09/12/15.
//  Copyright © 2015 BuyMeAPie. All rights reserved.
//

@import Foundation;

#import "BPAdSlotImpressionProtocols.h"

@interface BPAdSlotImpressionsTracker : NSObject <BPAdSlotImpressionable>
@property (nonatomic, weak) id<BPAdImpressionsDelegate> delegate;
@end
