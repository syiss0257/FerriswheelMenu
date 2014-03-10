//
//  CustomLayer.m
//  dcmDemo
//
//  Created by ohtake shingo on 2014/03/09.
//  Copyright (c) 2014年 ohtake shingo. All rights reserved.
//

#import "CustomLayer.h"

//float value =0;

@implementation CustomLayer


//+(id)layer{
//    
//    return la;
//}

- (void)drawInContext:(CGContextRef)ctx{
    NSLog(@"OK");
    [super drawInContext:ctx];
    

        UIGraphicsPushContext(ctx);
        //CGRect box = CGRectInset(self.bounds, self.bounds.size.width, self.bounds.size.height);
        //CGRect box = CGRectInset(self.bounds, self.bounds.size.width * -0.5, self.bounds.size.height *-0.5);
//        UIBezierPath *ballBezierPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
//        [[UIColor blackColor] setStroke];
//        [[UIColor whiteColor] setFill]; // Green here to show the black area
//        [ballBezierPath stroke];
//        [ballBezierPath fill];
    UIColor* fillColor;
    UIColor* strokeColor;
    UIBezierPath* path;
    strokeColor = [UIColor clearColor];
    path = [UIBezierPath bezierPath];
    
    
    [path moveToPoint: CGPointMake((50+self.value*-2)*CGRectGetWidth(self.bounds)/100,96*CGRectGetHeight(self.bounds)/96)];
    
    [path addCurveToPoint: CGPointMake((81+self.value*2)*CGRectGetWidth(self.bounds)/100,(87+self.value*-7)*CGRectGetHeight(self.bounds)/96) controlPoint1: CGPointMake((51+self.value*10)*CGRectGetWidth(self.bounds)/100,96*CGRectGetHeight(self.bounds)/96) controlPoint2: CGPointMake((65+self.value*9)*CGRectGetWidth(self.bounds)/100,(97+self.value*-7)*CGRectGetHeight(self.bounds)/96)];
    
    [path addCurveToPoint: CGPointMake((99+self.value*-3)*CGRectGetWidth(self.bounds)/100,(46+self.value*2)*CGRectGetHeight(self.bounds)/96) controlPoint1: CGPointMake((93+self.value*-2)*CGRectGetWidth(self.bounds)/100,(79+self.value*-8)*CGRectGetHeight(self.bounds)/96) controlPoint2: CGPointMake((100+self.value*-4)*CGRectGetWidth(self.bounds)/100,60*CGRectGetHeight(self.bounds)/96)];
    
    [path addCurveToPoint: CGPointMake((86+self.value*-2)*CGRectGetWidth(self.bounds)/100,(9+self.value*7)*CGRectGetHeight(self.bounds)/96) controlPoint1: CGPointMake((99+self.value*-3)*CGRectGetWidth(self.bounds)/100,35*CGRectGetHeight(self.bounds)/96) controlPoint2: CGPointMake((97+self.value*-6)*CGRectGetWidth(self.bounds)/100,(17+self.value*8)*CGRectGetHeight(self.bounds)/96)];
    
    [path addCurveToPoint: CGPointMake((50+self.value*-2)*CGRectGetWidth(self.bounds)/100,0) controlPoint1: CGPointMake((73+self.value*2)*CGRectGetWidth(self.bounds)/100,(0+self.value*6)*CGRectGetHeight(self.bounds)/96) controlPoint2: CGPointMake((51+self.value*11)*CGRectGetWidth(self.bounds)/100,0)];
    
    [path addCurveToPoint: CGPointMake((13+self.value*-2)*CGRectGetWidth(self.bounds)/100,(9+self.value*7)*CGRectGetHeight(self.bounds)/96) controlPoint1: CGPointMake((48+self.value*-15)*CGRectGetWidth(self.bounds)/100,0) controlPoint2: CGPointMake((26+self.value*-6)*CGRectGetWidth(self.bounds)/100,(0+self.value*6)*CGRectGetHeight(self.bounds)/96)];
    
    [path addCurveToPoint: CGPointMake(0,(46+self.value*2)*CGRectGetHeight(self.bounds)/96) controlPoint1: CGPointMake((2+self.value*2)*CGRectGetWidth(self.bounds)/100,(17+self.value*8)*CGRectGetHeight(self.bounds)/96) controlPoint2: CGPointMake(0,(35+self.value*1)*CGRectGetHeight(self.bounds)/96)];
    
    [path addCurveToPoint: CGPointMake((18+self.value*-4)*CGRectGetWidth(self.bounds)/100,(87+self.value*-5)*CGRectGetHeight(self.bounds)/96) controlPoint1: CGPointMake(0,(60+self.value*1)*CGRectGetHeight(self.bounds)/96) controlPoint2: CGPointMake((6+self.value*-1)*CGRectGetWidth(self.bounds)/100,(79+self.value*-5)*CGRectGetHeight(self.bounds)/96)];
    
    
    
    [path addCurveToPoint: CGPointMake((50+self.value*-2)*CGRectGetWidth(self.bounds)/100,96*CGRectGetHeight(self.bounds)/96) controlPoint1: CGPointMake((34+self.value*-11)*CGRectGetWidth(self.bounds)/100,(97+self.value*-7)*CGRectGetHeight(self.bounds)/96) controlPoint2: CGPointMake((48+self.value*-13)*CGRectGetWidth(self.bounds)/100,96*CGRectGetHeight(self.bounds)/96)];
    
    
    //[fillColor setFill];
    [fillColor setFill];
    [path fill];
    [strokeColor setStroke];
    path.lineWidth = 1;
    [path stroke];

        
        UIGraphicsPopContext();
    

    
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    NSLog(@"OK2");
}

@end
