
#import <UIKit/UIKit.h>
//#import "CDCircle.h"
//#import "CDIconView.h"
#import "CustomLayer.h"




@interface CDCircleThumb : UIView
{
    CGFloat numberOfSegments;
    CGFloat bigArcHeight;
    CGFloat smallArcWidth;
}
@property (assign, readonly) CGFloat sRadius;
@property (assign, readonly) CGFloat lRadius;
@property (assign, readonly) CGFloat yydifference;
@property (nonatomic, strong) UIBezierPath *arc;
@property (nonatomic, strong) UIColor *separatorColor;
//@property (nonatomic, assign) CDCircleThumbsSeparator separatorStyle;
@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, strong) NSMutableArray * colorsLocations;
//@property (nonatomic, strong) CDIconView *iconView;
@property (assign) BOOL gradientFill;
@property (nonatomic, strong) NSArray *gradientColors;
@property (nonatomic, strong) UIColor *arcColor;

@property (nonatomic, strong) UILabel *lb;
@property  (nonatomic, assign) float scale;
@property (nonatomic, strong)CustomLayer *sublayer;
@property (nonatomic, strong)CALayer *baselayer;
@property (nonatomic, strong)CATextLayer *label;

//-(id) initWithShortCircleRadius: (CGFloat) shortRadius longRadius: (CGFloat) longRadius numberOfSegments: (CGFloat) sNumber;
- (id)initWithShortCircleRadius:(CGFloat)shortRadius longRadius:(CGFloat)longRadius numberOfSegments: (CGFloat) sNumber numberOfTag:(int)num;
-(void)changeSize;

@end
