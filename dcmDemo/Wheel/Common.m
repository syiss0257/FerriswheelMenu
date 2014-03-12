

#import "Common.h"
@implementation Common
void drawLinearGradient(CGContextRef context, CGPathRef path, CFArrayRef colors, CGGradientPosition position, CGFloat locations[], CGRect rect) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colors, locations);
    CGPoint startPoint;
    CGPoint endPoint;
    
    
        
    switch (position) {
        case CGGradientPositionHorizontal:
            startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
             endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
            
            break;
            
        case CGGradientPositionVertical:
            startPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMidY(rect));
            endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMidY(rect));
            break;
}
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

CGRect rectFor1PxStroke(CGRect rect) {
    return CGRectMake(rect.origin.x + 0.5, rect.origin.y + 0.5, 
                      rect.size.width - 1, rect.size.height - 1);
}



+(NSString*)cubesLabel:(int)num{
    
       NSMutableArray* exps = [NSMutableArray arrayWithObjects:@"飲みに行く", @"後で読む",@"あれから\n100日",@"気になる\n夕刊",@"スケジュール",@"明日の\nアラーム",@"美沙に\nメール",@"家まで\n45分",nil];
    return [exps objectAtIndex:num];
}

@end
