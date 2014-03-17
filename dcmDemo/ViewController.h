//
//  ViewController.h
//  dcmDemo
//
//  Created by ohtake shingo on 2014/02/22.
//  Copyright (c) 2014年 ohtake shingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDCircle.h"
#import "CDCircleGestureRecognizer.h"
#import "CDCircleOverlayView.h"

//#import "a"


@interface ViewController : UIViewController<CDCircleDelegate,CDCircleDataSource>{
    int numberOfSegment;
    UIView* base;
}
//@property (strong, nonatomic) IBOutlet AnimationImageView *avatarImageView;
@property (strong, nonatomic) IBOutlet UIButton *rotateBtn;
@property (strong, nonatomic) IBOutlet UILabel *highlightLb;
- (IBAction)kaitenBtn:(id)sender;


@end
