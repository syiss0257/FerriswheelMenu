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


@interface ViewController : UIViewController<CDCircleDelegate,CDCircleDataSource>{
    int numberOfSegment;
}
- (IBAction)kaitenBtn:(id)sender;


@end
