//
//  XCNMenuView.h
//  XCNMemuView
//
//  Created by 许春娜 on 2017/3/13.
//  Copyright © 2017年 XCN. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XCNMenuViewDelegate <NSObject>

@required
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


typedef void(^DismissWithOperation)();

@interface XCNMenuView : UIView
@property (nonatomic,weak) id<XCNMenuViewDelegate> delegate;
@property (nonatomic,copy) DismissWithOperation dismissWithOperation;
//初始化方法
//传入参数：模型数组，弹出原点，宽度，高度（每个cell的高度）
- (instancetype)initWithDataArray:(NSArray *)dataArray
                           images:(NSArray *)images
                           origin:(CGPoint)origin
                            width:(CGFloat)width
                           height:(CGFloat)height
                           dismissWithOperation:(DismissWithOperation)dismissWithOperation;
//显示菜单
-(void)showMenuView;
//隐藏菜单
-(void)hiddenMenuView;
@end
