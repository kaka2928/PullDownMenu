//
//  ViewController.m
//  pullDownViewDemo
//
//  Created by caochao on 15/9/9.
//  Copyright (c) 2015年 snail. All rights reserved.
//

#import "ViewController.h"
#import "PullMenuView.h"
@interface ViewController ()<PullMenuViewDelegate>
@property (nonatomic,strong) PullMenuView *pullMenu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pullMenu = [[PullMenuView alloc]initWithFrame:CGRectMake(0, 20, [[UIScreen mainScreen]bounds].size.width, 50)];
//    self.pullMenu.spreadedHeight = 170;
    self.pullMenu.delegate = self;
    self.pullMenu.tagArray =@[@"BBC",@"流式table",@"github",@"code4app",@"约束",@"九月好天气",@"notification",@"仗义",@"朋友",@"OpenGL ES",@"非常复杂",@"好好想想怎么回事",@"patience",@"weakend project",@"自定义流式标签",@"github",@"code4app",@"god"];
     [self.view addSubview:self.pullMenu];
    
    
    PullMenuView *tempPullMenu = [[PullMenuView alloc]initWithFrame:CGRectMake(0, 200, [[UIScreen mainScreen]bounds].size.width, 50)];
    //    self.pullMenu.spreadedHeight = 170;
    tempPullMenu.delegate = self;
    tempPullMenu.tagArray =@[@"CCCCCC"];
    [self.view addSubview:tempPullMenu];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pullMenuView:(PullMenuView *)pullMenuView selectedSubTitle:(NSString *)title{

    NSLog(@"tilte :%@",title);
}
@end
