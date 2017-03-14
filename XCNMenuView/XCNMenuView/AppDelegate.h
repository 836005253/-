//
//  AppDelegate.h
//  XCNMenuView
//
//  Created by 许春娜 on 2017/3/14.
//  Copyright © 2017年 XCN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

