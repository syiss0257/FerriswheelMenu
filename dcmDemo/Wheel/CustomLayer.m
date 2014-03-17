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


- (void)drawInContext:(CGContextRef)ctx{

    [super drawInContext:ctx];
    

    UIGraphicsPushContext(ctx);

    UIColor* fillColor;
    UIColor* strokeColor;
    UIBezierPath* path;
    strokeColor = [UIColor clearColor];

    
    fillColor = [self changeBackGroundColor:[self.name intValue]];
    path = [UIBezierPath bezierPath];
    

    
    [path moveToPoint: CGPointMake(50*CGRectGetWidth(self.bounds)/100,96*CGRectGetHeight(self.bounds)/96)];
    
    [path addCurveToPoint: CGPointMake(81*CGRectGetWidth(self.bounds)/100,87*CGRectGetHeight(self.bounds)/96) controlPoint1: CGPointMake(51*CGRectGetWidth(self.bounds)/100,96*CGRectGetHeight(self.bounds)/96) controlPoint2: CGPointMake(65*CGRectGetWidth(self.bounds)/100,97*CGRectGetHeight(self.bounds)/96)];
    
    [path addCurveToPoint: CGPointMake(99*CGRectGetWidth(self.bounds)/100,46*CGRectGetHeight(self.bounds)/96) controlPoint1: CGPointMake(93*CGRectGetWidth(self.bounds)/100,79*CGRectGetHeight(self.bounds)/96) controlPoint2: CGPointMake(100*CGRectGetWidth(self.bounds)/100,60*CGRectGetHeight(self.bounds)/96)];
    
    [path addCurveToPoint: CGPointMake(86*CGRectGetWidth(self.bounds)/100,9*CGRectGetHeight(self.bounds)/96) controlPoint1: CGPointMake(99*CGRectGetWidth(self.bounds)/100,35*CGRectGetHeight(self.bounds)/96) controlPoint2: CGPointMake(97*CGRectGetWidth(self.bounds)/100,17*CGRectGetHeight(self.bounds)/96)];
    
    [path addCurveToPoint: CGPointMake(50*CGRectGetWidth(self.bounds)/100,0) controlPoint1: CGPointMake(73*CGRectGetWidth(self.bounds)/100,0*CGRectGetHeight(self.bounds)/96) controlPoint2: CGPointMake((51+self.value*11)*CGRectGetWidth(self.bounds)/100,0)];
    
    [path addCurveToPoint: CGPointMake(13*CGRectGetWidth(self.bounds)/100,(9+self.value*7)*CGRectGetHeight(self.bounds)/96) controlPoint1: CGPointMake((48+self.value*-15)*CGRectGetWidth(self.bounds)/100,0) controlPoint2: CGPointMake((26+self.value*-6)*CGRectGetWidth(self.bounds)/100,(0+self.value*6)*CGRectGetHeight(self.bounds)/96)];
    
    [path addCurveToPoint: CGPointMake(0,(46+self.value*2)*CGRectGetHeight(self.bounds)/96) controlPoint1: CGPointMake((2+self.value*2)*CGRectGetWidth(self.bounds)/100,17*CGRectGetHeight(self.bounds)/96) controlPoint2: CGPointMake(0,(35+self.value*1)*CGRectGetHeight(self.bounds)/96)];
    
    [path addCurveToPoint: CGPointMake(18*CGRectGetWidth(self.bounds)/100,87*CGRectGetHeight(self.bounds)/96) controlPoint1: CGPointMake(0,(60+self.value*1)*CGRectGetHeight(self.bounds)/96) controlPoint2: CGPointMake((6+self.value*-1)*CGRectGetWidth(self.bounds)/100,(79+self.value*-5)*CGRectGetHeight(self.bounds)/96)];
    
    
    
    [path addCurveToPoint: CGPointMake(50*CGRectGetWidth(self.bounds)/100,96*CGRectGetHeight(self.bounds)/96) controlPoint1: CGPointMake(34*CGRectGetWidth(self.bounds)/100,97*CGRectGetHeight(self.bounds)/96) controlPoint2: CGPointMake(48*CGRectGetWidth(self.bounds)/100,96*CGRectGetHeight(self.bounds)/96)];
    
    
    //[fillColor setFill];
    [fillColor setFill];
    [path fill];
    [strokeColor setStroke];
    path.lineWidth = 1;
    [path stroke];

        
        UIGraphicsPopContext();
    

    
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    //NSLog(@"OK2");
}

-(UIColor*)changeBackGroundColor:(NSInteger)segment{
    
    switch (segment) {
        case 0:
            bgColor = [UIColor colorWithRed:1.0 green:0.55 blue:0.42 alpha:1.0];
            break;
        case 1:
            bgColor = [UIColor colorWithRed:0.56 green:0.73 blue:0.89 alpha:1.0];
            break;
        case 2:
            bgColor = [UIColor colorWithRed:1.0 green:0.89 blue:0.63 alpha:1.0];
            break;
        case 3:
            bgColor = [UIColor colorWithRed:0.5 green:0.8 blue:0.84 alpha:1.0];
            break;
        case 4:
            bgColor = [UIColor colorWithRed:1.0 green:0.53 blue:0.49 alpha:1.0];
            break;
        case 5:
            bgColor = [UIColor colorWithRed:0.63 green:0.9 blue:0.86 alpha:1.0];
            break;
        case 6:
            bgColor = [UIColor colorWithRed:0.86 green:0.58 blue:0.68 alpha:1.0];
            break;
        case 7:
            bgColor = [UIColor colorWithRed:0.87 green:0.7 blue:0.53 alpha:1.0];
            break;
            
        default:
            break;
    }

    return bgColor;
}

@end
