//
//  ViewController.m
//  XCNMenuView
//
//  Created by 许春娜 on 2017/3/14.
//  Copyright © 2017年 XCN. All rights reserved.
//

#import "ViewController.h"
#import "XCNMenuView.h"
@interface ViewController ()<XCNMenuViewDelegate>
{
    XCNMenuView * _menuView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //创建 button
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setFrame:CGRectMake(50, 50, 100, 30)];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
}



//点击事件
-(void)buttonClick:(UIButton *)sender
{
    //文本内容
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5"];
    //图片
    NSArray *images = @[@"item_battle",@"item_chat",@"item_list",@"item_school",@"item_share"];
    //创建 view
    _menuView = [[XCNMenuView alloc]initWithDataArray:array images:images origin:CGPointMake(sender.center.x, CGRectGetMaxY(sender.frame)+10) width:sender.frame.size.width height:35 dismissWithOperation:^{
        _menuView = nil;
    }];
    _menuView.delegate = self;
    [_menuView showMenuView];
}

//点击事件
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
