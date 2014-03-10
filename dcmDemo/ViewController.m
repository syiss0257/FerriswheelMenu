//
//  ViewController.m
//  dcmDemo
//
//  Created by ohtake shingo on 2014/02/22.
//  Copyright (c) 2014年 ohtake shingo. All rights reserved.
//
#define degreesToRadians(x) (M_PI * (x) / 180.0)
#define radiansToDegrees(x) ((x) / M_PI * 180)
#import "ViewController.h"
CDCircle* circle ;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    numberOfSegment = 8;
    
    circle = [[CDCircle alloc] initWithFrame:CGRectMake(10 , 100, 300, 300) numberOfSegments:numberOfSegment ringWidth:100.f];
    circle.dataSource = self;
    circle.delegate = self;
    //[circle.recognizer append];
    CDCircleOverlayView *overlay = [[CDCircleOverlayView alloc] initWithCircle:circle];
    [self.view addSubview:circle];

    overlay.alpha = 0.0f;
    [self.view addSubview:overlay];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) circle:(CDCircle *)circle didMoveToSegment:(NSInteger)segment thumb:(CDCircleThumb *)thumb{

    for (CDCircleThumb* otherThumb in circle.thumbs){

        otherThumb.sublayer.affineTransform = CGAffineTransformIdentity;
        //otherThumb.lb.transform = CGAffineTransformMakeRotation(degreesToRadians(-(360/numberOfSegment)*(otherThumb.tag-thumb.tag)));
        //otherThumb.sublayer.affineTransform = CGAffineTransformMakeTranslation(50, 0);
        otherThumb.sublayer.affineTransform = CGAffineTransformMakeRotation(degreesToRadians(-(360/numberOfSegment)*(otherThumb.tag-thumb.tag)));
        
        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

            if (thumb.tag == 0) {
                if (otherThumb.tag == thumb.tag +1) {
                    otherThumb.sublayer.affineTransform = CGAffineTransformTranslate(otherThumb.sublayer.affineTransform, 20, 0);
                    otherThumb.lb.layer.affineTransform = CGAffineTransformTranslate(otherThumb.sublayer.affineTransform, 5, 0);
                } else if(otherThumb.tag == numberOfSegment-1){
                    otherThumb.sublayer.affineTransform = CGAffineTransformTranslate(otherThumb.sublayer.affineTransform, -20, 0);
                    otherThumb.lb.layer.affineTransform = CGAffineTransformTranslate(otherThumb.sublayer.affineTransform, -5, 0);
                }
            }
            else if(thumb.tag == numberOfSegment-1){
                if (otherThumb.tag == 0) {
                    otherThumb.sublayer.affineTransform = CGAffineTransformTranslate(otherThumb.sublayer.affineTransform, 20, 0);
                    otherThumb.lb.layer.affineTransform = CGAffineTransformTranslate(otherThumb.sublayer.affineTransform, 5, 0);
                } else if(otherThumb.tag == thumb.tag -1){
                    otherThumb.sublayer.affineTransform = CGAffineTransformTranslate(otherThumb.sublayer.affineTransform, -20, 0);
                    otherThumb.lb.layer.affineTransform = CGAffineTransformTranslate(otherThumb.sublayer.affineTransform, -5, 0);
                }
            }
            else {
                if (otherThumb.tag == thumb.tag +1) {
                    otherThumb.sublayer.affineTransform = CGAffineTransformTranslate(otherThumb.sublayer.affineTransform, 20, 0);
                    otherThumb.lb.layer.affineTransform = CGAffineTransformTranslate(otherThumb.sublayer.affineTransform, 5, 0);
                } else if(otherThumb.tag == thumb.tag -1){
                    otherThumb.sublayer.affineTransform = CGAffineTransformTranslate(otherThumb.sublayer.affineTransform, -20, 0);
                    otherThumb.lb.layer.affineTransform = CGAffineTransformTranslate(otherThumb.sublayer.affineTransform, -5, 0);
                }
            }
        });
        

     }


    [thumb setNeedsDisplay];
    
    //thumb.sublayer.affineTransform = CGAffineTransformMakeScale(1.2, 1.2);

    thumb.lb.transform = CGAffineTransformMakeRotation(degreesToRadians(0));
    thumb.sublayer.affineTransform = CGAffineTransformMakeRotation(degreesToRadians(0));
    if (thumb.tag%2 == 1) {
    thumb.sublayer.affineTransform = CGAffineTransformMakeScale(1.6, 1.6);
    } else {
    thumb.sublayer.affineTransform = CGAffineTransformMakeScale(1.4, 1.4);
    }
}


- (IBAction)kaitenBtn:(id)sender {
    
//    [circle.recognizer a];
    //[circle sampleRotate];
    
    
    [circle.recognizer append];
    
}
    
@end