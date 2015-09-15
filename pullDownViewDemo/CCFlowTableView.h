//
//  CCFlowTableView.h
//  pullDownViewDemo
//
//  Created by caochao on 15/9/9.
//  Copyright (c) 2015年 snail. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCFlowTableView;

@protocol CCFlowTableViewDelegate <NSObject>

- (void)CCFlowTableView:(CCFlowTableView *)flowTableView selectedTitle:(NSString *)title;

@end
/**
 *  流式布局tableView，单行显示时，横向滑动，多行显示时，纵向滑动
 */
@interface CCFlowTableView : UIScrollView

@property (nonatomic,assign) CGFloat spreadedHeight;
@property (nonatomic,copy) NSArray *subTitleArray;
@property (nonatomic, assign) id<CCFlowTableViewDelegate>flowDelegate;
- (instancetype) initWithFrame:(CGRect)frame;
- (void)spread;
- (void)compress;
@end
