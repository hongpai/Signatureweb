//
//  DrawLinerLayer.m
//  pdfAZxbk
//
//  Created by pai hong on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DrawLinerLayer.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Extras.h"

@implementation DrawLinerLayer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        // Initialization code
        //[self setBackgroundColor:[UIColor redColor]];
        /*layer = [[CALayer alloc] init];
         [self.layer addSublayer:layer];
         [layer release];
         
         CGContextRef context;
         CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
         context = CGBitmapContextCreate(NULL, self.frame.size.width, self.frame.size.height, 8, 4 *self.frame.size.width, colorSpace, kCGImageAlphaPremultipliedFirst);
         CGColorSpaceRelease(colorSpace);
         layerref = CGLayerCreateWithContext(context, self.frame.size, NULL);*/
        
        lines = [[NSMutableArray alloc] init];
        
        /*
        self.layer.shadowOffset = CGSizeMake(3, 3);
        self.layer.shadowColor = [[UIColor grayColor] CGColor];
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 10.0;
        self.layer.shadowOpacity=0.7;
*/
        
        //self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    CGPoint pastLocation = [touch previousLocationInView:self];
        NSValue *pos = [NSValue valueWithCGPoint:location];
        
        [lines addObject:pos];
        
        [self setNeedsDisplay];
    //NSLog(@"f_____");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [lines addObject:[NSValue valueWithCGPoint:CGPointMake(-1, -1)]];
//    [lines removeAllObjects];
    NSLog(@"end-----------");
}


- (void)drawRect:(CGRect)rect
{
    //NSLog(@"count:___%d",[lines count]);
    if ([lines count]<=1) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext(); 
    //r g b:2 173 216
    //CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:2.0f/255 green:173.0f/255 blue:216.0f/255 alpha:1].CGColor);
    //CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:66.0f/255 green:173.0f/255 blue:10.0f/255 alpha:1].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth  (context, 12.0f);
    for (int a = 1; a<[lines count]; a++) {
        CGPoint currpoint = [[lines objectAtIndex:a] CGPointValue];
        CGPoint prevpoint = [[lines objectAtIndex:a-1] CGPointValue];
        if ((currpoint.x==-1 && currpoint.y==-1) || (prevpoint.x==-1 && prevpoint.y==-1)) {
            continue;
        }
        CGContextMoveToPoint   (context,prevpoint.x , prevpoint.y);
        CGContextAddLineToPoint(context,currpoint.x , currpoint.y);
    }
    CGContextStrokePath(context);

}

-(void)reset{
    
    [lines removeAllObjects];
    [self setNeedsDisplay];
}


-(void)diponse{
    [lines removeAllObjects];
    [lines release];
    [self removeFromSuperview];
}

/*
-(UIImage *)imageByRenderingview{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultimage;
}
*/
-(UIImage *)getImageRendering;{
    return [self imageRenderingInView];
}









@end
