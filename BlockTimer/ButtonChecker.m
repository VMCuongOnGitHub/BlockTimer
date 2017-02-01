//
//  ButtonChecker.m
//  BlockTimer
//
//  Created by Mac on 10/6/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import "ButtonChecker.h"

@interface ButtonChecker()

@property(nonatomic,strong)IBInspectable UIImage* checkedStateImage;
@property(nonatomic,strong)IBInspectable UIImage* uncheckedStateImage;

@end

@implementation ButtonChecker

-(id)init
{
    self = [super init];
    
    if(self)
    {
        [self addTarget:self action:@selector(switchState) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        [self addTarget:self action:@selector(switchState) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        [self addTarget:self action:@selector(switchState) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

-(void)setIsChecked:(BOOL)isChecked
{
    _isChecked = isChecked;
    
    if(isChecked)
    {
        [self setImage:self.checkedStateImage forState:UIControlStateNormal];
    }
    else
    {
        [self setImage:self.uncheckedStateImage forState:UIControlStateNormal];
    }
}

-(void)switchState
{
    self.isChecked = !self.isChecked;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end