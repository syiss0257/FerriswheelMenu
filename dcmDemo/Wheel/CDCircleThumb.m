
//#define kIconViewWidth 30
//#define kIconViewHeight 30
#define degreesToRadians(x) (M_PI * x / 180.0)
#import "Common.h"
#import "CDCircleThumb.h"
#import <QuartzCore/QuartzCore.h>
@implementation CDCircleThumb
@synthesize sRadius, lRadius, yydifference, arc, separatorColor,  centerPoint;
//@synthesize iconView;
@synthesize gradientFill, gradientColors, arcColor;
@synthesize colorsLocations;



- (id)initWithShortCircleRadius:(CGFloat)shortRadius longRadius:(CGFloat)longRadius numberOfSegments: (CGFloat) sNumber

{
    //Calculating suitable frame
        //Variables
    
    CGRect frame;
    
    CGFloat width;
    CGFloat height;
    //
    CGFloat fstartAngle = 270 - ((360/sNumber)/2);
    CGFloat fendAngle = 270 + ((360/sNumber)/2);
    //
    CGFloat startAngle = degreesToRadians(fstartAngle);
    CGFloat endAngle = degreesToRadians(fendAngle);
    
    
    UIBezierPath *bigArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(longRadius, longRadius) radius:longRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    UIBezierPath *smallArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(longRadius, longRadius) radius:shortRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
            // Start of calculations
    if ((fendAngle - fstartAngle) <= 180) {
            width = bigArc.bounds.size.width;
        height = smallArc.currentPoint.y ;
        //frame = CGRectMake(0, 0, width, height);
        frame = CGRectMake(0, 0, width, width);
    }
    if ((fendAngle - fstartAngle) > 269) {
        //frame = CGRectMake(0, 0, bigArc.bounds.size.width, bigArc.bounds.size.height);
        frame = CGRectMake(0, 0, bigArc.bounds.size.width, bigArc.bounds.size.width);
    }
            //End of calculations
    
    //frame = CGRectMake(0, 0, 80, 80);
    
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        sRadius = shortRadius;
        lRadius = longRadius;
        numberOfSegments = sNumber;
        CGFloat y = (lRadius - sRadius)/2.00;
        CGFloat xi = 0.5;
        CGFloat yi = y/frame.size.height;
        self.layer.anchorPoint = CGPointMake(xi, yi);
        self.gradientFill = YES;

        self.arcColor = [UIColor blackColor];
        
        self.centerPoint = CGPointMake(CGRectGetMidX(self.bounds), y);

        self.gradientColors =  [NSArray arrayWithObjects:(id)[UIColor blackColor].CGColor,(id)[UIColor grayColor].CGColor,  nil];
    }
    
    
    //ohtake_wrote
    _lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
    _lb.text = @"1";
    //_lb.transform = CGAffineTransformMakeRotation(degreesToRadians(60));
    //_lb.transform = CGAffineTransformMakeRotation(atan2(self.transform.a,self.transform.b)-degreesToRadians(90));
    NSLog(@"%f",atan2(self.transform.a,self.transform.b));
    _lb.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    [self addSubview:_lb];
    _lb.hidden = YES;
    
    _scale = 0.25f;
    
    
    //CALayer *sublayer = [CALayer layer];
    //CustomLayer *sublayer = [CALayer layer];
    _sublayer = [[CustomLayer alloc]init];
    //sublayer.delegate = sublayer;
    //sublayer.backgroundColor = [UIColor blueColor].CGColor;
    _sublayer.backgroundColor = [UIColor clearColor].CGColor;
//    sublayer.shadowOffset = CGSizeMake(0, 3);
//    sublayer.shadowRadius = 5.0;
//    sublayer.shadowColor = [UIColor blackColor].CGColor;
//    sublayer.shadowOpacity = 0.8;
    _sublayer.opacity = 0.5;
    _sublayer.frame = CGRectMake(0, 0, 80, 80);
    _sublayer.position = self.center;
    //sublayer.affineTransform = CGAffineTransformMakeRotation(degreesToRadians(180));
    //[sublayer setNeedsDisplay];
    [self.layer addSublayer:_sublayer];
    [_sublayer setNeedsDisplay];
    
    
    
    _label = [[CATextLayer alloc] init];
    [_label setFont:@"Helvetica-Bold"];
    [_label setFontSize:20];
    [_label setFrame:CGRectMake(0, 0, 10, 20)];
    [_label setString:[NSString stringWithFormat:@"%d",5]];
    [_label setAlignmentMode:kCAAlignmentCenter];
    [_label setForegroundColor:[[UIColor redColor] CGColor]];
    _label.position = CGPointMake(35, 35);
    [_sublayer addSublayer:_label];
//    _lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
//    _lb.text = @"1";
//    //_lb.transform = CGAffineTransformMakeRotation(degreesToRadians(60));
//    //_lb.transform = CGAffineTransformMakeRotation(atan2(self.transform.a,self.transform.b)-degreesToRadians(90));
//    //NSLog(@"%f",atan2(self.transform.a,self.transform.b));
//    _lb.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
//    [_sublayer addSublayer:_lb.layer];
    
    
    
    
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];

//    CGRect box = CGRectInset(self.bounds, self.bounds.size.width * _scale, self.bounds.size.height * _scale);
//    //CGRect box = CGRectInset(self.bounds, self.bounds.size.width * -0.5, self.bounds.size.height *-0.5);
//    UIBezierPath *ballBezierPath = [UIBezierPath bezierPathWithOvalInRect:box];
//    [[UIColor blackColor] setStroke];
//    [[UIColor whiteColor] setFill]; // Green here to show the black area
//    [ballBezierPath stroke];
//    [ballBezierPath fill];

    //Angles
    
    CGFloat clockwiseStartAngle = degreesToRadians((270 - ((360/numberOfSegments)/2)));
    CGFloat clockwiseEndAngle = degreesToRadians((270 + ((360/numberOfSegments)/2)));
    
    CGFloat nonClockwiseStartAngle = clockwiseEndAngle;
    CGFloat nonClockwiseEndAngle = clockwiseStartAngle;
      
    CGPoint center = CGPointMake(CGRectGetMidX(rect), lRadius);

    self.arc = [UIBezierPath bezierPathWithArcCenter: center radius:lRadius startAngle:clockwiseStartAngle endAngle:clockwiseEndAngle clockwise:YES];

    [arc addArcWithCenter:center radius:sRadius startAngle:nonClockwiseStartAngle endAngle:nonClockwiseEndAngle clockwise:NO];


}

-(BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    

    return NO;
}

//-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
//    NSLog(@"KKK");
//    UIGraphicsPushContext(ctx);
//    CGRect box = CGRectInset(self.bounds, self.bounds.size.width * _scale, self.bounds.size.height * _scale);
//    //CGRect box = CGRectInset(self.bounds, self.bounds.size.width * -0.5, self.bounds.size.height *-0.5);
//    UIBezierPath *ballBezierPath = [UIBezierPath bezierPathWithOvalInRect:box];
//    [[UIColor blackColor] setStroke];
//    [[UIColor whiteColor] setFill]; // Green here to show the black area
//    [ballBezierPath stroke];
//    [ballBezierPath fill];
//    
//    //Angles
//    
//    CGFloat clockwiseStartAngle = degreesToRadians((270 - ((360/numberOfSegments)/2)));
//    CGFloat clockwiseEndAngle = degreesToRadians((270 + ((360/numberOfSegments)/2)));
//    
//    CGFloat nonClockwiseStartAngle = clockwiseEndAngle;
//    CGFloat nonClockwiseEndAngle = clockwiseStartAngle;
//    
//    CGPoint center = CGPointMake(CGRectGetMidX(layer.frame), lRadius);
//    
//    self.arc = [UIBezierPath bezierPathWithArcCenter: center radius:lRadius startAngle:clockwiseStartAngle endAngle:clockwiseEndAngle clockwise:YES];
//    
//    [arc addArcWithCenter:center radius:sRadius startAngle:nonClockwiseStartAngle endAngle:nonClockwiseEndAngle clockwise:NO];
//    
//    
//    UIGraphicsPopContext();
//}

@end
