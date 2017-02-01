//
//  TestViewController.m
//  BlockTimer
//
//  Created by Mac on 8/4/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import "TestViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppHelper.h"

@interface TestViewController ()
@property (strong, nonatomic) IBOutlet UIView *sampleView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
            //Adds a shadow to sampleView
//        CALayer *layer = self.sampleView.layer;
//        layer.shadowOffset = CGSizeMake(1, 1);
//        layer.shadowColor = [[UIColor blackColor] CGColor];
//        layer.shadowRadius = 4.0f;
//        layer.shadowOpacity = 0.80f;
//        layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
