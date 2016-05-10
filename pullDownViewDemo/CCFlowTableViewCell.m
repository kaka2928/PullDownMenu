//
//  CCFlowTableViewCell.m
//  pullDownViewDemo
//
//  Created by caochao on 15/9/9.
//  Copyright (c) 2015年 snail. All rights reserved.
//

#import "CCFlowTableViewCell.h"
#import "PullMenuDefine.h"
@implementation CCFlowTableViewCell

- (instancetype)initWithTitle:(NSString *)title{
    
    int width = 14;
    for (int j =0; j<[title length]; j++) {
        int a = [title characterAtIndex:j];
        if ((a>0x4e00&&a<0x9fff)) {
            width +=SUBMENUFONTSIZE;
           
        }else{
            width +=SUBMENUFONTSIZE/2;
        }
    }
    if (self = [super initWithFrame:CGRectMake(0, 0, width+8, SUBMENUFONTSIZE+8)]) {
        
        self.layer.borderWidth =1.0;
        self.layer.cornerRadius = 3.0;
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(4, 4, width, SUBMENUFONTSIZE)];
        self.title.font = [UIFont systemFontOfSize:SUBMENUFONTSIZE];
        [self.title setTextColor:[UIColor blackColor]];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.text = title;
        [self addSubview:self.title];
        self.enable = YES;
    }
    
    return self;
}
- (void)setEnable:(BOOL)enable{
    _enable = enable;
    [self.title setTextColor:[UIColor blackColor]];
    self.layer.borderColor = [[UIColor grayColor]CGColor];
}
#pragma mark - touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.enable) {
        self.enable = NO;
        self.layer.borderColor = [[UIColor redColor]CGColor];
        [self.title setTextColor:[UIColor redColor]];
        if ([self.flowDelegate respondsToSelector:@selector(CCFlowTableViewCell:selectedTitle:)]) {
            [self.flowDelegate CCFlowTableViewCell:self selectedTitle:self.title.text];
        }

    }
}
@end
