//
//  BPAppodealSponsoredLabel.h
//  BuyMeAPie
//
//  Created by Pavel Stasyuk on 18/11/2016.
//  Copyright © 2016 BuyMeAPie. All rights reserved.
//

#import "BPSponsoredLabel.h"

@interface BPSponsoredLabel()
@property (nonatomic, readonly) NSDictionary *textAttributes;
@property (nonatomic, readonly) NSString *text;
@end

@implementation BPSponsoredLabel
@dynamic text, textAttributes;

- (NSString *)text
{
    return @"SPONSORED";
}

- (NSDictionary *)textAttributes
{
    UIFont *actualFont = [UIFont systemFontOfSize:7.5];
    NSMutableParagraphStyle *textStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *textFontAttributes = @{
                                         NSFontAttributeName: actualFont,
                                         NSForegroundColorAttributeName: [UIColor whiteColor],
                                         NSParagraphStyleAttributeName: textStyle
                                         };
    
    return textFontAttributes;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI_2);
    
    CGContextConcatCTM(context, transform);
    CGContextTranslateCTM(context, -self.bounds.size.height, 0);
    
    CGFloat intrinsicWidth = self.intrinsicContentSize.width;
    CGRect drawingRect = CGRectMake(0, (self.bounds.size.width - intrinsicWidth)*0.5, self.bounds.size.height, intrinsicWidth);
    [self.text drawInRect:drawingRect withAttributes:self.textAttributes];
}

- (CGSize)intrinsicContentSize
{
    CGSize size = [self.text sizeWithAttributes:self.textAttributes];
    return CGSizeMake(ceilf(size.height), ceilf(size.width));
}

@end
