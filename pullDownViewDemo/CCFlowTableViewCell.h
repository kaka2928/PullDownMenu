//
//  CCFlowTableViewCell.h
//  pullDownViewDemo
//
//  Created by caochao on 15/9/9.
//  Copyright (c) 2015年 snail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCFlowTableViewCell : UIView
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,assign) BOOL enable;
- (instancetype)initWithTitle:(NSString *)title;

@end
