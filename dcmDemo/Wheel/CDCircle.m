
#define degreesToRadians(x) (M_PI * (x) / 180.0)
#define radiansToDegrees(x) ((x) / M_PI * 180)
#define kRotationDegrees 90
//#define kRotationDegrees 0
#import "CDCircle.h"
#import <QuartzCore/QuartzCore.h>
//#import "CDCircleGestureRecognizer.h"
#import "CDCircleThumb.h"
//#import "CDCircleOverlayView.h"
#import "CDCircleGestureRecognizer.h"



@implementation CDCircle
@synthesize circle, recognizer, path, numberOfSegments, separatorStyle, overlayView, separatorColor, ringWidth, circleColor, thumbs, overlay;
@synthesize delegate, dataSource;
@synthesize inertiaeffect;


//Need to add property "NSInteger numberOfThumbs" and add this property to initializer definition, and property "CGFloat ringWidth equal to circle radius - path radius. 

//Circle radius is equal to rect / 2 , path radius is equal to rect1/2.

-(id) initWithFrame:(CGRect)frame numberOfSegments: (NSInteger) nSegments ringWidth:(CGFloat)width {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.inertiaeffect = YES;
        self.recognizer = [[CDCircleGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:self.recognizer];
        self.opaque = NO;
        self.numberOfSegments = nSegments;
        self.separatorStyle = CDCircleThumbsSeparatorBasic;
        //self.separatorStyle = CDCircleThumbsSeparatorNone;
        self.ringWidth = width;
        self.circleColor = [UIColor yellowColor];
        
        
        CGRect rect1 = CGRectMake(0, 0, CGRectGetHeight(frame) - (2*ringWidth), CGRectGetWidth(frame) - (2*ringWidth));
        self.thumbs = [NSMutableArray array];
        for (int i = 0; i < self.numberOfSegments; i++) {
              CDCircleThumb * thumb = [[CDCircleThumb alloc] initWithShortCircleRadius:rect1.size.height/2 longRadius:frame.size.height/2 numberOfSegments:self.numberOfSegments];
            //thumb.tag = i;
            [self.thumbs addObject:thumb];
        }
          
            }
    return self;
}


-(void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState (ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeCopy);
    
//    [self.circleColor setFill];
//    circle = [UIBezierPath bezierPathWithOvalInRect:rect];
//    [circle closePath];
//    [circle fill];
    
    
    CGRect rect1 = CGRectMake(0, 0, CGRectGetHeight(rect) - (2*ringWidth), CGRectGetWidth(rect) - (2*ringWidth));
    rect1.origin.x = rect.size.width / 2  - rect1.size.width / 2;
    rect1.origin.y = rect.size.height / 2  - rect1.size.height / 2;
    
    
    path = [UIBezierPath bezierPathWithOvalInRect:rect1];
    //self.circleColor = [UIColor blueColor];
    [self.circleColor setFill];
    [path fill];
    CGContextRestoreGState(ctx);
    
    
    //Drawing Thumbs
    CGFloat fNumberOfSegments = self.numberOfSegments;
    CGFloat perSectionDegrees = 360.f / fNumberOfSegments;//36
    CGFloat totalRotation = 360.f / fNumberOfSegments;//36
    CGPoint centerPoint = CGPointMake(rect.size.width/2, rect.size.height/2);//150
    

    
    CGFloat deltaAngle;
    
    for (int i = 0; i < self.numberOfSegments; i++) {
        

        CDCircleThumb * thumb = [self.thumbs objectAtIndex:i];
        thumb.tag = i;
        thumb.lb.text = [NSString stringWithFormat:@"%d",thumb.tag];
        [thumb.label setString:[NSString stringWithFormat:@"%d",thumb.tag]];
        //thumb.label.position = thumb.center;
        if (thumb.tag%2 == 1) {
            thumb.sublayer.frame = CGRectMake(0, 0, 70, 70);
            thumb.sublayer.position = thumb.center;
            //[thumb.sublayer retain];
        }
        

        CGFloat radius = rect1.size.height/2 + ((rect.size.height/2 - rect1.size.height/2)/2) - thumb.yydifference;
        CGFloat x = centerPoint.x + (radius * cos(degreesToRadians(perSectionDegrees)));
        CGFloat yi = centerPoint.y + (radius * sin(degreesToRadians(perSectionDegrees)));
        

        //NSLog(@"%f,%f,%f",radius,x,yi);
        //NSLog(@"SSSSS%f__%d",perSectionDegrees + kRotationDegrees,i);
        //NSLog(@"SSSSS%f__%d(%f,%f)",perSectionDegrees,i,x,yi);
        [thumb setTransform:CGAffineTransformMakeRotation(degreesToRadians(perSectionDegrees + kRotationDegrees))];
//        thumb.lb.transform = CGAffineTransformMakeRotation(-degreesToRadians(perSectionDegrees -45));
//        thumb.sublayer.affineTransform = CGAffineTransformMakeRotation(-degreesToRadians(perSectionDegrees -45));
        thumb.lb.transform = CGAffineTransformMakeRotation(-degreesToRadians(perSectionDegrees -totalRotation));
        thumb.sublayer.affineTransform = CGAffineTransformMakeRotation(-degreesToRadians(perSectionDegrees -totalRotation));
        //[thumb setTransform:CGAffineTransformMakeRotation(degreesToRadians(kRotationDegrees))];
        
        //初期位置
        //NSLog(@"RRRRR%f",radiansToDegrees(atan2(thumb.transform.a, thumb.transform.b)));
        if (i==0) {
            //NSLog(@"%f",atan2(thumb.transform.a, thumb.transform.b));
            deltaAngle= degreesToRadians(360 - kRotationDegrees) + atan2(thumb.transform.a, thumb.transform.b);
            //deltaAngle= degreesToRadians(36);
            //deltaAngle= atan2(thumb.transform.a, thumb.transform.b);
            //[thumb.iconView setIsSelected:YES];
            self.recognizer.currentThumb = thumb;
        }
       
        //set position of the thumb
        thumb.layer.position = CGPointMake(x, yi);
        
        
        perSectionDegrees += totalRotation;
        //NSLog(@"%f",perSectionDegrees);
        
        
         [self addSubview:thumb];
        
    }
    
    //初期位置
    
    //NSLog(@"111111111____%f", degreesToRadians(atan2(self.transform.a, self.transform.b)));
    [self setTransform:CGAffineTransformRotate(self.transform,deltaAngle)];
    //NSLog(@"222222222____%f", degreesToRadians(atan2(self.transform.a, self.transform.b)));
    //NSLog(@"EEEEEEEEE%f", deltaAngle);
 }

-(void) tapped: (CDCircleGestureRecognizer *) arecognizer{
    
    if (arecognizer.ended == NO) {
    CGPoint point = [arecognizer locationInView:self];
    if ([path containsPoint:point] == NO) {
        //NSLog(@"AAAAAAAAAAAAAAAAAAA%f",[arecognizer rotation]);
//        if (arecognizer.rotation<0) {
            [self setTransform:CGAffineTransformRotate([self transform], [arecognizer rotation])];
//        }
    //[self setTransform:CGAffineTransformRotate([self transform], 4.084071)];
    }
}
    //[arecognizer append];
    
}


-(void)sampleRotate{
    
   // NSLog(@"")
    
    [UIView animateWithDuration:0.3f animations:^{
        [self setTransform:CGAffineTransformRotate(self.transform,degreesToRadians(36))];
    } completion:^(BOOL finished) {
        //[self setTransform:CGAffineTransformRotate(self.transform,degreesToRadians(36))];
        
    }];
    
    
//    for (CDCircleThumb *thumb in self.thumbs) {
//        
//        CGPoint touchPoint = [touch locationInView:thumb];
//        if (CGPathContainsPoint(thumb.arc.CGPath, NULL, touchPoint, NULL)) {
//            
//
//            
//            CGFloat deltaAngle= - degreesToRadians(180) + atan2(view.transform.a, view.transform.b) + atan2(thumb.transform.a, thumb.transform.b);
//            //CGFloat deltaAngle= atan2(thumb.transform.a, thumb.transform.b);
//            CGAffineTransform current = view.transform;
//            [UIView animateWithDuration:0.3f animations:^{
//                [view setTransform:CGAffineTransformRotate(current, deltaAngle)];
//            } completion:^(BOOL finished) {
//
//                
//                self.currentThumb = thumb;
//                //Delegate method
//                [view.delegate circle:view didMoveToSegment:thumb.tag thumb:thumb];
//                self.ended = YES;
//                
//            }];
//            
//            break;
//        }
//        
//    }
   
    
    
    
    
}



@end
