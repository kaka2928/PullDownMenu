//
//  CCFlowTableView.m
//  pullDownViewDemo
//
//  Created by caochao on 15/9/9.
//  Copyright (c) 2015年 snail. All rights reserved.
//

#import "CCFlowTableView.h"
#import "CCFlowTableViewCell.h"
#import "PullMenuDefine.h"

@interface CCFlowTableView()<CCFlowTableViewCellDelegate>{

    NSInteger _compressHeight;

    float _contentWidth;
    float _contentHeight;
    CCFlowTableViewCell *currentSelectedCell;
}
@property (nonatomic,copy) NSMutableArray *cells;
@end

@implementation CCFlowTableView

- (instancetype) initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        _contentWidth = 5;
        _contentHeight = frame.size.height;
        
        
        _compressHeight = frame.size.height;

        self.bounces = YES;
        
        self.scrollEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}
#pragma mark - CCFlowTableViewCellDelegate
- (void)CCFlowTableViewCell:(CCFlowTableViewCell *)flowTableViewCell selectedTitle:(NSString *)cellTitle{
    if (currentSelectedCell!=NULL) {
        currentSelectedCell.enable = YES;
    }
    currentSelectedCell = flowTableViewCell;
    
    if ([self.flowDelegate respondsToSelector:@selector(CCFlowTableView:selectedTitle:)]) {
            [self.flowDelegate CCFlowTableView:self selectedTitle:cellTitle];
    }

    
}

- (void)setSubTitleArray:(NSArray *)subTitleArray{

    _subTitleArray = subTitleArray;
    _cells = [NSMutableArray arrayWithCapacity:[_subTitleArray count]];
    for (int i = 0; i<[_subTitleArray count]; i++) {
        CCFlowTableViewCell *cell = [[CCFlowTableViewCell alloc]initWithTitle:[_subTitleArray objectAtIndex:i]];
        cell.flowDelegate = self;
        [_cells addObject:cell];
        [cell setFrame:CGRectMake(_contentWidth, 5, cell.frame.size.width, cell.frame.size.height)];
       
        [self addSubview:cell];
        _contentWidth +=(cell.frame.size.width + 5);
    }

    [self setContentSize:CGSizeMake(_contentWidth, 0)];
}

- (void)spread{

    CGFloat currentWidth = 0;
    CGFloat currentHeight = 5;
    CGFloat priorCellWidth = 0;
    CGFloat cellHeight = 0;


    for (int i = 0; i<[_cells count]; i++) {
        
        CCFlowTableViewCell *cell =[_cells objectAtIndex:i];
        cellHeight = cell.frame.size.height;
        currentWidth += (priorCellWidth + 5);
        if ( self.frame.size.width <= currentWidth + cell.frame.size.width + 5 ) {
            currentWidth = 5;
            currentHeight += (cellHeight +5);
            //换行
        }
        [cell setFrame:CGRectMake(currentWidth , currentHeight, cell.frame.size.width, cell.frame.size.height)];
        priorCellWidth = cell.frame.size.width;
    }
//    for (int i = (int)([_cells count] - 1);i>=0; ) {
//        CCFlowTableViewCell *currentRowLastCell =[_cells objectAtIndex:i];
//        CGFloat surplusWidth = self.frame.size.width - ( currentRowLastCell.frame.origin.x + currentRowLastCell.frame.size.width +5);
//        int currentCellCount = 0;
//        for (int j = i; j>=0;j--) {
//            CCFlowTableViewCell *tempCell =[_cells objectAtIndex:j];
//            if (tempCell.frame.origin.y ==currentRowLastCell.frame.origin.y) {
//                currentCellCount +=1;
//            }else{
//                break;
//            }
//        }
//        surplusWidth += (currentCellCount -1) *5;
//        NSLog(@"%f,%f,%d",surplusWidth,surplusWidth/(currentCellCount -1),currentCellCount);
//        for (int j = 0; j<=currentCellCount-1;j++) {
//            NSLog(@"%d,%d",j,i-j);
//            CCFlowTableViewCell *tempCell =[_cells objectAtIndex:i-j];
//           [tempCell setFrame:CGRectMake(tempCell.frame.origin.x + (surplusWidth/(currentCellCount-1) + 5) , tempCell.frame.origin.y, tempCell.frame.size.width, tempCell.frame.size.height)];
//        }
//        i-=currentCellCount;
//        
//    }
    [self setContentSize:CGSizeMake(self.frame.size.width, currentHeight + cellHeight + 5)];
    if (_spreadedHeight ==0) {
        _spreadedHeight = self.contentSize.height;
    }
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.x, self.frame.size.width, _spreadedHeight)];
}
- (void)compress{
    _contentWidth = 5;
    _contentHeight = self.frame.size.height;
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.x, self.frame.size.width, _compressHeight)];
    for (int i = 0; i<[_subTitleArray count]; i++) {
        CCFlowTableViewCell *cell =[_cells objectAtIndex:i];
        [cell setFrame:CGRectMake(_contentWidth, 5, cell.frame.size.width, cell.frame.size.height)];
        _contentWidth +=(cell.frame.size.width + 5);
    }
    
    [self setContentSize:CGSizeMake(_contentWidth, 0)];
}


@end
