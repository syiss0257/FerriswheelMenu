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
CDCircle* circle2 ;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    numberOfSegment = 8;
    
    circle = [[CDCircle alloc] initWithFrame:CGRectMake(10 , 150, 300, 300) numberOfSegments:numberOfSegment ringWidth:100.f];
    circle.dataSource = self;
    circle.delegate = self;
    //[circle.recognizer append];
    CDCircleOverlayView *overlay = [[CDCircleOverlayView alloc] initWithCircle:circle];
    [self.view addSubview:circle];

    overlay.alpha = 0.0f;
    [self.view addSubview:overlay];

//    double delayInSeconds = 0.3f;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//    [self circle:circle didMoveToSegment:0 thumb:[circle.thumbs objectAtIndex:0]];
//     });
    
    
    UIApplication *application = [UIApplication sharedApplication];
    

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationDidBecomeActiveNotification object:application];
    
//    base = [[UIView alloc]initWithFrame:CGRectMake(120, 115, 80, 80)];
//    base.backgroundColor = [UIColor blueColor];
//    base.alpha = 0.5;
//    //base.center = overlay.center;
//    //base.hidden = NO;
//    [self.view addSubview:base];
    //[
    
    
//    circle2 = [[CDCircle alloc] initWithFrame:CGRectMake(0 ,0, 800, 800) numberOfSegments:numberOfSegment ringWidth:100.f];
//    circle2.center = CGPointMake(160, 300);
//    circle2.dataSource = self;
//    circle2.delegate = self;
//    //[circle.recognizer append];
//    //CDCircleOverlayView *overlay = [[CDCircleOverlayView alloc] initWithCircle:circle];
//    [self.view addSubview:circle2];
//    [self.view bringSubviewToFront:circle];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//delegateMethod

-(void) circle:(CDCircle *)circle didMoveToSegment:(NSInteger)segment thumb:(CDCircleThumb *)thumb{
    
    [self changeBackGroundColor:segment];
    _highlightLb.hidden = NO;
    _highlightLb.alpha = 0.2;
    _highlightLb.text = [Common cubesLabel:thumb.tag];
    [UIView animateWithDuration:0.5
                     animations:^{
                         _highlightLb.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                     }];
    
    
    for (CDCircleThumb* otherThumb in circle.thumbs){
        otherThumb.label.hidden = NO;

        otherThumb.sublayer.affineTransform = CGAffineTransformIdentity;
        otherThumb.sublayer.affineTransform = CGAffineTransformMakeRotation(degreesToRadians(-(360/numberOfSegment)*(otherThumb.tag-thumb.tag)));
        
        //double delayInSeconds = 0.2f;
        double delayInSeconds = 0.1f;
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

    thumb.sublayer.affineTransform = CGAffineTransformMakeRotation(degreesToRadians(0));
    if (thumb.tag%2 == 1) {
    thumb.sublayer.affineTransform = CGAffineTransformMakeScale(1.6, 1.6);
//        thumb.sublayer.frame = CGRectMake(0, 0, CGRectGetWidth(thumb.sublayer.frame)*1.6, CGRectGetHeight(thumb.sublayer.frame)*1.6);
//        thumb.sublayer.position = thumb.center;
    } else {
    thumb.sublayer.affineTransform = CGAffineTransformMakeScale(1.4, 1.4);
    }
    thumb.label.hidden = YES;
    //base.hidden = NO;
    [self.view bringSubviewToFront:_highlightLb];

//    [thumb.sublayer setRasterizationScale:[[UIScreen mainScreen] scale]];
//    [thumb.sublayer setShouldRasterize:YES];
//    [thumb.sublayer setNeedsDisplay];

    
    double delayInSeconds = 0.2f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    CAKeyframeAnimation * anim = [ CAKeyframeAnimation animationWithKeyPath:@"transform" ] ;
    anim.values = @[ [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-1.5f, 0.0f, 0.0f) ], [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(1.5f, 0.0f, 0.0f) ] ] ;
    anim.autoreverses = YES ;
    anim.repeatCount = 2.0f ;
    anim.duration = 0.07f ;
    
    [thumb.baselayer addAnimation:anim forKey:nil ] ;
    
    [_highlightLb.layer addAnimation:anim forKey:nil];
    });
    
    [thumb.label setNeedsDisplay];

}

-(void)hiddenLb{
    _highlightLb.hidden = YES;
}


- (IBAction)kaitenBtn:(id)sender {
    //_highlightLb.hidden = YES;
    _rotateBtn.userInteractionEnabled = NO;
    double delayInSeconds = 0.3f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

     _rotateBtn.userInteractionEnabled = YES;
    });
    [circle.recognizer append];
    
}



-(void)changeBackGroundColor:(NSInteger)segment{
    
    switch (segment) {
        case 0:
            self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.55 blue:0.42 alpha:0.5];
            break;
        case 1:
            self.view.backgroundColor = [UIColor colorWithRed:0.56 green:0.73 blue:0.89 alpha:0.5];
            break;
        case 2:
            self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.89 blue:0.63 alpha:0.5];
            break;
        case 3:
            self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.8 blue:0.84 alpha:0.5];
            break;
        case 4:
            self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.53 blue:0.49 alpha:0.5];
            break;
        case 5:
            self.view.backgroundColor = [UIColor colorWithRed:0.63 green:0.9 blue:0.86 alpha:0.5];
            break;
        case 6:
            self.view.backgroundColor = [UIColor colorWithRed:0.86 green:0.58 blue:0.68 alpha:0.5];
            break;
        case 7:
            self.view.backgroundColor = [UIColor colorWithRed:0.87 green:0.7 blue:0.53 alpha:0.5];
            break;
        default:
            break;
    }
    
    
    
}

-(void)applicationWillEnterForeground:(NSNotification *)notification{
    [circle.recognizer append2];

}


@end