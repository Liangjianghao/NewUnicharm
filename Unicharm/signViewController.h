//
//  signViewController.h
//  Unicharm
//
//  Created by mac on 17/1/16.
//  Copyright © 2017年 ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"
#import <CoreLocation/CoreLocation.h>
@interface signViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate>

@property(retain,nonatomic) StoreModel *model;
@property(retain,nonatomic)NSString *name;
@property (nonatomic,strong)CLLocationManager   * locMgr;

@property(retain,nonatomic)NSString *content;

@end
