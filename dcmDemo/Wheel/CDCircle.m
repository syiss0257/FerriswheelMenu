
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
    
//    exps = [NSMutableArray arrayWithObjects:@"飲みに行く", @"後で読む",@"あれから\n100日",@"気になる\n夕刊",@"スケジュール",@"明日の\nアラーム",@"美沙に\nメール",@"家まで\n45分",nil];
    
    if (self) {
        self.inertiaeffect = YES;
        self.recognizer = [[CDCircleGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:self.recognizer];
        self.opaque = NO;
        self.numberOfSegments = nSegments;
        self.separatorStyle = CDCircleThumbsSeparatorBasic;
        //self.separatorStyle = CDCircleThumbsSeparatorNone;
        self.ringWidth = width;
        //self.circleColor = [UIColor yellowColor];
        self.circleColor = [UIColor clearColor];
        
        
        CGRect rect1 = CGRectMake(0, 0, CGRectGetHeight(frame) - (2*ringWidth), CGRectGetWidth(frame) - (2*ringWidth));
        self.thumbs = [NSMutableArray array];
        for (int i = 0; i < self.numberOfSegments; i++) {
            CDCircleThumb * thumb = [[CDCircleThumb alloc] initWithShortCircleRadius:rect1.size.height/2 longRadius:frame.size.height/2 numberOfSegments:self.numberOfSegments numberOfTag:i];
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
//        thumb.tag = i;
//        thumb.lb.text = [NSString stringWithFormat:@"%long",(long)thumb.tag];
        //[thumb.label setString:[NSString stringWithFormat:@"%long",(long)thumb.tag]];
        //[thumb.label setString:[exps objectAtIndex:thumb.tag]];
        [thumb.label setString:[Common cubesLabel:thumb.tag]];
        
        CGFloat radius = rect1.size.height/2 + ((rect.size.height/2 - rect1.size.height/2)/2) - thumb.yydifference;
        CGFloat x = centerPoint.x + (radius * cos(degreesToRadians(perSectionDegrees)));
        CGFloat yi = centerPoint.y + (radius * sin(degreesToRadians(perSectionDegrees)));
        

        [thumb setTransform:CGAffineTransformMakeRotation(degreesToRadians(perSectionDegrees + kRotationDegrees))];
        //thumb.lb.transform = CGAffineTransformMakeRotation(-degreesToRadians(perSectionDegrees -totalRotation));
        thumb.sublayer.affineTransform = CGAffineTransformMakeRotation(-degreesToRadians(perSectionDegrees -totalRotation));

        if (i==0) {
            deltaAngle= degreesToRadians(360 - kRotationDegrees) + atan2(thumb.transform.a, thumb.transform.b);
            self.recognizer.currentThumb = thumb;
        }
       
        //set position of the thumb
        thumb.layer.position = CGPointMake(x, yi);
        perSectionDegrees += totalRotation;

        [self addSubview:thumb];
        
        
        
        thumb.sublayer.name = [NSString stringWithFormat:@"%long",(long)thumb.tag];
        //thumb.sublayer.name = [exps objectAtIndex:thumb.tag];
        [thumb.sublayer setNeedsDisplay];
    }
    
    [self setTransform:CGAffineTransformRotate(self.transform,deltaAngle)];
 
 }

-(void) tapped: (CDCircleGestureRecognizer *) arecognizer{
    
    if (arecognizer.ended == NO) {
    CGPoint point = [arecognizer locationInView:self];
    if ([path containsPoint:point] == NO) {

            [self setTransform:CGAffineTransformRotate([self transform], [arecognizer rotation])];

    }
}
    
}



@end
