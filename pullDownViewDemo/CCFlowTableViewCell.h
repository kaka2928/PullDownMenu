//
//  CCFlowTableViewCell.h
//  pullDownViewDemo
//
//  Created by caochao on 15/9/9.
//  Copyright (c) 2015年 snail. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCFlowTableViewCell;

@protocol CCFlowTableViewCellDelegate <NSObject>

- (void)CCFlowTableViewCell:(CCFlowTableViewCell *)flowTableViewCell selectedTitle:(NSString *)cellTitle;

@end
@interface CCFlowTableViewCell : UIView
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,assign) BOOL enable;
@property (nonatomic, assign) id<CCFlowTableViewCellDelegate>flowDelegate;
- (instancetype)initWithTitle:(NSString *)title;

@end
