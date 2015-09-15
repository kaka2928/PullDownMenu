//
//  PullMenuView.m
//  pullDownViewDemo
//
//  Created by caochao on 15/9/9.
//  Copyright (c) 2015年 snail. All rights reserved.
//

#import "PullMenuView.h"
#import "PullMenuDefine.h"
#import "CCFlowTableView.h"
@interface PullMenuView()<CCFlowTableViewDelegate>
{

    BOOL _isOpen;
    CGGradientRef _barGradient;
    CGPoint _barStartPoint, _barEndPoint;
    UIImageView *_barImageView;
    CGAffineTransform _barImageViewRotation;
    CGFloat _contractedHeight;
}

@property (nonatomic,strong) CCFlowTableView *flowTable;

@end

@implementation PullMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        _contractedHeight = frame.size.height;
        _isOpen = NO;
        
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Triangle" ofType:@"png"]];
        if (image == nil)
            NSLog(@"Failed to load image for control vieww");
        // Gradient setup for bar
        CGFloat barColors[8] = {
            0.70f, 0.70f, 0.70f, 0.75f,
            0.90f, 0.90f, 0.90f, 0.85f
            
        };
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        if (colorSpace != NULL)
        {
            _barGradient = CGGradientCreateWithColorComponents(colorSpace, barColors, NULL, 2);
            if (_barGradient == NULL)
                NSLog(@"Failed to create CGGradient");
            CGColorSpaceRelease(colorSpace);
        }
        _barStartPoint = CGPointMake(frame.size.height - PULLBUTTONHIGHT, 0.0f);
        _barEndPoint = CGPointMake(frame.size.height - PULLBUTTONHIGHT, PULLBUTTONHIGHT);
        _barImageView = [[UIImageView alloc] initWithFrame:CGRectMake(floorf((frame.size.width/2.0f) - PULLBUTTONHIGHT), frame.size.height - PULLBUTTONHIGHT, PULLBUTTONHIGHT*2, PULLBUTTONHIGHT)];
        _barImageView.image = image;
        
        [self addSubview:_barImageView];
        
        _barImageViewRotation = CGAffineTransformMake(cos(-M_PI), sin(-M_PI), -sin(-M_PI), cos(-M_PI), 0.0f, 0.0f);
        
        self.opaque = FALSE;

        self.flowTable = [[CCFlowTableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - PULLBUTTONHIGHT)];
        self.flowTable.flowDelegate = self;
        [self addSubview:self.flowTable];
        
    }
    return self;
}
- (void)dealloc
{
    CGGradientRelease(_barGradient);
    
}
- (void)setSpreadedHeight:(CGFloat)spreadedHeight{

    _spreadedHeight = spreadedHeight;
    self.flowTable.spreadedHeight = _spreadedHeight - PULLBUTTONHIGHT;
}
- (void)setTagArray:(NSArray *)tagArray{


    self.flowTable.subTitleArray = tagArray;
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextDrawLinearGradient(context, _barGradient, _barStartPoint, _barEndPoint, kCGGradientDrawsAfterEndLocation);
    
    CGContextSetRGBFillColor(context, 0.25f, 0.25f, 0.25f, 1.0f);

    
    CGContextRestoreGState(context);
}
#pragma mark - touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch;
    CGPoint point;
    
    if ([touches count] > 0)
    {
        touch = [[touches allObjects] objectAtIndex:0];
        point = [touch locationInView:self];
        if ((self.frame.size.height - PULLBUTTONHIGHT) <= point.y )
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.25f];
            
            CGRect frame = [self frame];
            CGRect barFrame =[_barImageView frame];
            if (_isOpen == FALSE)
            {
                frame.size.height = _spreadedHeight;
                [_barImageView setFrame:CGRectMake(barFrame.origin.x,barFrame.origin.y + _spreadedHeight-_contractedHeight,barFrame.size.width,barFrame.size.height)];
                [_barImageView setTransform:_barImageViewRotation];
                _isOpen = TRUE;
                [self.flowTable spread];
            }
            else
            {
                frame.size.height = _contractedHeight;
                [_barImageView setFrame:CGRectMake(barFrame.origin.x,barFrame.origin.y -(_spreadedHeight-_contractedHeight),barFrame.size.width,barFrame.size.height)];
                [_barImageView setTransform:CGAffineTransformIdentity];
                _isOpen = FALSE;
                [self.flowTable compress];
            }
            
            [self setFrame:frame];
            
            [UIView commitAnimations];
        }
    }
}
#pragma mark - CCFlowTableViewDelegate

- (void) CCFlowTableView:(CCFlowTableView *)flowTableView selectedTitle:(NSString *)title{

    [self.delegate pullMenuView:self selectedSubTitle:title];
}
@end

