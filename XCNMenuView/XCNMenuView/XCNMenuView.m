//
//  XCNMenuView.m
//  XCNMemuView
//
//  Created by 许春娜 on 2017/3/13.
//  Copyright © 2017年 XCN. All rights reserved.
//

#import "XCNMenuView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface XCNMenuView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, strong) NSArray *dataArray;//文本内容数组
@property (nonatomic,strong)NSArray *images;//图片数组

@end

@implementation XCNMenuView

-(instancetype)initWithDataArray:(NSArray *)dataArray images:(NSArray *)images origin:(CGPoint)origin width:(CGFloat)width height:(CGFloat)height dismissWithOperation:(DismissWithOperation)dismissWithOperation
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        //背景色为透明色
        self.backgroundColor = [UIColor clearColor];
        _origin = origin;
        _height = height;
        _width = width;
        _dataArray = dataArray;
        _images = images;
        self.dismissWithOperation = dismissWithOperation;
        [self makeUI];
    }
    return self;
}


-(void)makeUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(_origin.x, _origin.y, _width, _height*_dataArray.count) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.layer.cornerRadius = 2.0;
    _tableView.separatorColor = [UIColor colorWithWhite:0.3 alpha:1];
    _tableView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    [self addSubview:_tableView];
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:(UIEdgeInsetsMake(0, 10, 0, 10))];
    }
    
    //注册 tableView
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}



#pragma mark -- tableview delegate&dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(didSelectRowAtIndexPath:)]) {
        [self.delegate didSelectRowAtIndexPath:indexPath];
    }
    [self hiddenMenuView];
}


//画出三角
- (void)drawRect:(CGRect)rect {
    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记
    
    
    CGFloat startX = self.origin.x + 10;
    CGFloat startY = self.origin.y;
    CGContextMoveToPoint(context, startX, startY);//设置起点
    
    CGContextAddLineToPoint(context, startX + 5, startY - 5);
    
    CGContextAddLineToPoint(context, startX + 10, startY);
    
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [self.tableView.backgroundColor setFill]; //设置填充色
    
    
    [self.tableView.backgroundColor setStroke];
    
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
    
    
}


//展示菜单栏
-(void)showMenuView
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    //动画效果弹出
    self.alpha = 0;
    CGRect frame = self.tableView.frame;
    self.tableView.frame = CGRectMake(self.origin.x, self.origin.y, 0, 0);
    
    [UIView animateWithDuration:.2 // 动画时长
                          delay:0.0 // 动画延迟
         usingSpringWithDamping:0.6 // 类似弹簧振动效果 0~1
          initialSpringVelocity:1 // 初始速度
                        options:UIViewAnimationOptionCurveEaseInOut // 动画过渡效果
                     animations:^{
                         self.alpha = 1;
                         self.tableView.frame = frame;
                     } completion:^(BOOL finished) {
                         
                     }];
}

//隐藏菜单栏
-(void)hiddenMenuView
{
    //动画效果淡出
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.tableView.frame = CGRectMake(self.origin.x, self.origin.y, 0, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
            if (self.dismissWithOperation) {
                self.dismissWithOperation();
            }
        }
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:self.tableView]) {
        [self hiddenMenuView];
    }
}
@end
