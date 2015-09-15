//
//  PullMenuView.h
//  pullDownViewDemo
//
//  Created by caochao on 15/9/9.
//  Copyright (c) 2015年 snail. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PullMenuView;

@protocol  PullMenuViewDelegate<NSObject>

- (void) pullMenuView:(PullMenuView *)pullMenuView selectedSubTitle:(NSString *)title;

@end
/**
 *  下拉展开菜单栏
 */
@interface PullMenuView : UIView
@property (nonatomic,assign) CGFloat spreadedHeight;
@property (nonatomic,copy) NSArray *tagArray;
@property (nonatomic, assign) id<PullMenuViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame;

@end
