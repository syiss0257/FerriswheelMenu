
#define degreesToRadians(x) (M_PI * (x) / 180.0)
#define radiansToDegrees(x) ((x) / M_PI * 180)
#define deceleration_multiplier 30.0f

#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioServices.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "CDCircle.h"
#import "CDCircleGestureRecognizer.h"
#import "CDCircleOverlayView.h"
#import "Common.h"
//#import "CDCircleThumb.h"


@implementation CDCircleGestureRecognizer

@synthesize rotation = rotation_, controlPoint;
@synthesize ended;
@synthesize currentThumb;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CDCircle *view = (CDCircle *) [self view];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:view];
    
    //NSLog(@"%@",NSStringFromCGPoint(point));
    
   // Fail when more than 1 finger detected.
   if ([[event touchesForGestureRecognizer:self] count] > 1 || ([view.path containsPoint:point] == YES )) {
      [self setState:UIGestureRecognizerStateFailed];
   }
    self.ended = NO;
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
   if ([self state] == UIGestureRecognizerStatePossible) {
      [self setState:UIGestureRecognizerStateBegan];
   } else {
      [self setState:UIGestureRecognizerStateChanged];
   }

   // We can look at any touch object since we know we 
   // have only 1. If there were more than 1 then 
   // touchesBegan:withEvent: would have failed the recognizer.
   UITouch *touch = [touches anyObject];

   // To rotate with one finger, we simulate a second finger.
   // The second figure is on the opposite side of the virtual
   // circle that represents the rotation gesture.

    CDCircle *view = (CDCircle *) [self view];
   CGPoint center = CGPointMake(CGRectGetMidX([view bounds]), CGRectGetMidY([view bounds]));
   CGPoint currentTouchPoint = [touch locationInView:view];
   CGPoint previousTouchPoint = [touch previousLocationInView:view];
    previousTouchDate = [NSDate date];
    CGFloat angleInRadians = atan2f(currentTouchPoint.y - center.y, currentTouchPoint.x - center.x) - atan2f(previousTouchPoint.y - center.y, previousTouchPoint.x - center.x);
    
    //NSLog(@"fffff%f",currentTouchPoint.x - previousTouchPoint.x);
    if (currentTouchPoint.x - previousTouchPoint.x <0) {
        //[self setRotation:angleInRadians];
    }
    
//    if (angleInRadians <0) {
//               [self setRotation:angleInRadians];
//            }

  [self setRotation:angleInRadians];
    //self.rotation = angleInRadians;
    //NSLog(@"%f",radiansToDegrees(atan2f(view.transform.b, view.transform.a)));
    currentTransformAngle = atan2f(view.transform.b, view.transform.a);

    
    
    
    for (CDCircleThumb *thumb in view.thumbs) {
        CGPoint point = [thumb convertPoint:thumb.centerPoint toView:nil];
        CDCircleThumb *shadow = view.overlayView.overlayThumb;
        CGRect shadowRect = [shadow.superview convertRect:shadow.frame toView:nil];
        
        CDCircleThumb *currentThumb2;
        if (CGRectContainsPoint(shadowRect, point) == YES) {
            
            currentThumb2 = thumb;
 
            float kyori = CGRectGetMidX(shadowRect)-shadowRect.origin.x;
//            
//            thumb.scale = 0.15/kyori*fabs(CGRectGetMidX(shadowRect)-point.x)+0.1;
//            
////            
////            thumb.scale = 0.4;
////            thumb.scale = 0.25 - 0.15;
//            NSLog(@"%f",thumb.scale);
//            [thumb setNeedsDisplay];
            thumb.sublayer.affineTransform = CGAffineTransformMakeRotation(degreesToRadians(45/kyori*fabs(CGRectGetMidX(shadowRect)-point.x)));
            
//            thumb.sublayer.affineTransform = CGAffineTransformMakeScale(-0.6/kyori*fabs(CGRectGetMidX(shadowRect)-point.x)+1.6, -0.6/kyori*fabs(CGRectGetMidX(shadowRect)-point.x)+1.6);
            thumb.sublayer.affineTransform = CGAffineTransformScale(thumb.sublayer.affineTransform,-0.6/kyori*fabs(CGRectGetMidX(shadowRect)-point.x)+1.6, -0.6/kyori*fabs(CGRectGetMidX(shadowRect)-point.x)+1.6);
        } else {
            //thumb.backgroundColor = [UIColor clearColor];
//            thumb.sublayer.affineTransform = CGAffineTransformMakeRotation(degreesToRadians(-(360/numberOfSegment)*(otherThumb.tag-thumb.tag)));
//            thumb.sublayer.affineTransform = CGAffineTransformMakeRotation(degreesToRadians(45/kyori*fabs(CGRectGetMidX(shadowRect)-point.x));
            thumb.sublayer.affineTransform = CGAffineTransformMakeRotation(degreesToRadians(-45*(thumb.tag-currentThumb2.tag)));
            thumb.sublayer.affineTransform = CGAffineTransformScale(thumb.sublayer.affineTransform,1.0,1.0);
        }
    }
    ;
    }

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   // Perform final check to make sure a tap was not misinterpreted.
   if ([self state] == UIGestureRecognizerStateChanged) {
    
       
       CDCircle *view = (CDCircle *) [self view];
       CGFloat flipintime = 0;
       CGFloat angle = 0;
       if (view.inertiaeffect == YES) {
           CGFloat angleInRadians = atan2f(view.transform.b, view.transform.a) - currentTransformAngle;
           double time = [[NSDate date] timeIntervalSinceDate:previousTouchDate];
           double velocity = angleInRadians/time;
           CGFloat a = deceleration_multiplier;
           
            flipintime = fabs(velocity)/a; 
           
            angle = (velocity*flipintime)-(a*flipintime*flipintime/2);
           
           if (angle>M_PI/2 || (angle<0 && angle<-1*M_PI/2)) {
               if (angle<0) {
                   angle =-1 * M_PI/2.1f;
               }    
               else { angle = M_PI/2.1f; }
               
               flipintime = 1/(-1*(a/2*velocity/angle));
           }

       }
       //NSLog(@"BBBBBBBBBBBBBB%f",radiansToDegrees(angle));
       [UIView animateWithDuration:flipintime delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
           [view setTransform:CGAffineTransformRotate(view.transform,angle)];

       } completion:^(BOOL finished) {
           
//           if (radiansToDegrees(angle)<0) {
//             if (currentThumb.tag != 0) {

               for (CDCircleThumb *thumb in view.thumbs) {
 
                   CGPoint point = [thumb convertPoint:thumb.centerPoint toView:nil];
                   CDCircleThumb *shadow = view.overlayView.overlayThumb;
                   CGRect shadowRect = [shadow.superview convertRect:shadow.frame toView:nil];
                   
                   if (CGRectContainsPoint(shadowRect, point) == YES) {
                       //NSLog(@"ZZZZZZZZZZZZZZZ%d",thumb.tag);
                       
                       CGPoint pointInShadowRect = [thumb convertPoint:thumb.centerPoint toView:shadow];
                       if (CGPathContainsPoint(shadow.arc.CGPath, NULL, pointInShadowRect, NULL)) {

                           
                           
                           [self rotatePropaty:view selected:thumb];
                           break;
                       }
                       //thumb.backgroundColor = [UIColor blueColor];
                   }
                   //               else {
                   //                   thumb.backgroundColor = [UIColor redColor];
                   //               }
               };

//           } else {
//               for (CDCircleThumb *thumb in view.thumbs) {
//                   
//                   //CGPoint touchPoint = [touch locationInView:thumb];
//                   if (thumb.tag == 0) {
//                       if (radiansToDegrees(angle)<0) {
//                       [self rotatePropaty:view selected:thumb];
//                       } else {
//                       [self rotatePropaty:view selected:thumb];
//                       }
//                       break;
//                   }
//                   
//               }
//
//           }
           
           
           
       }];


       currentTransformAngle = 0;
   
     [self setState:UIGestureRecognizerStateEnded];
       
   } else {
       
       CDCircle *view = (CDCircle *)[self view];
       UITouch *touch = [touches anyObject];
       
       for (CDCircleThumb *thumb in view.thumbs) {
           
           CGPoint touchPoint = [touch locationInView:thumb];
           if (CGPathContainsPoint(thumb.arc.CGPath, NULL, touchPoint, NULL)) {
               
               //NSLog(@"33333333____%f",radiansToDegrees(atan2(view.transform.a, view.transform.b)));

               [self rotatePropaty:view selected:thumb];
               break;
           }
           
       }
       
       [self setState:UIGestureRecognizerStateFailed];
   }
}



- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
   [self setState:UIGestureRecognizerStateFailed];
}


-(void)append{
    
    CDCircle *view = (CDCircle *)[self view];
    
    long nextThumbTag = currentThumb.tag+1;
    if (nextThumbTag >= view.numberOfSegments) {
        nextThumbTag = 0;
    }
    

    for (CDCircleThumb *thumb in view.thumbs) {
        
        //CGPoint touchPoint = [touch locationInView:thumb];
        if (thumb.tag == nextThumbTag) {
            

            [self rotatePropaty:view selected:thumb];
            break;
        }
        
    }
    
    
    [self setState:UIGestureRecognizerStateFailed];
    
}



-(void)rotatePropaty:(CDCircle*)view selected:(CDCircleThumb*)thumb{

    
    CGFloat deltaAngle= - degreesToRadians(180) + atan2(view.transform.a, view.transform.b) + atan2(thumb.transform.a, thumb.transform.b);
    //CGFloat deltaAngle= atan2(thumb.transform.a, thumb.transform.b);
    CGAffineTransform current = view.transform;
    [UIView animateWithDuration:0.3f animations:^{
        [view setTransform:CGAffineTransformRotate(current, deltaAngle)];
    } completion:^(BOOL finished) {
        
        SystemSoundID soundID;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"iPod Click" ofType:@"aiff"];
        
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileUrl, &soundID);
        AudioServicesPlaySystemSound(soundID);
        
        self.currentThumb = thumb;
        //Delegate method
        [view.delegate circle:view didMoveToSegment:thumb.tag thumb:thumb];
        self.ended = YES;
        
    }];
}

@end

