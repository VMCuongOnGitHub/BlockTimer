//
//  AppHelper.m
//  BlockTimer
//
//  Created by Mac on 8/3/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import "AppHelper.h"
#import <QuartzCore/QuartzCore.h>

@implementation AppHelper
+ (void)createWithView:(UIView *)view withBackgroundColor:(UIColor *)backgroundColor
{
    view.layer.backgroundColor = backgroundColor.CGColor;
}
@end
