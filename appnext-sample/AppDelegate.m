//
//  AppDelegate.m
//  adadapted-sample
//
//  Created by Pavel Stasyuk on 29/01/2017.
//  Copyright © 2017 Buy Me a Pie!. All rights reserved.
//

#import "AppDelegate.h"
#import "BPAdContentProvider.h"
#import "BPAppnextProvider.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    BPAppnextProvider *appnextProvider = [BPAppnextProvider new];
    appnextProvider.statisticsImpressionLabel = @"footer";
    appnextProvider.rotationInterval = -1;
    
    self.contentProvider = appnextProvider;
    
    return YES;
}

@end
