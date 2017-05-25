//
//  NewViewController.h
//  Unicharm
//
//  Created by EssIOS on 16/8/18.
//  Copyright © 2016年 ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"
@interface NewViewController : UIViewController
@property(retain,nonatomic) StoreModel *model;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property(retain,nonatomic)NSString *name;

@end
