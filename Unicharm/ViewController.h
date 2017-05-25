//
//  ViewController.h
//  Unicharm
//
//  Created by EssIOS on 16/8/5.
//  Copyright © 2016年 ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface ViewController : UIViewController
@property (strong,nonatomic)ProductModel *model;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *passWTF;
@property (weak, nonatomic) IBOutlet UIButton *MMPSWbtn;
@property (weak, nonatomic) IBOutlet UIButton *autoLogBtn;

@property(retain,nonatomic)NSString *name;
@end

