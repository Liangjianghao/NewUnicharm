//
//  tiaozhuanViewController.h
//  Unicharm
//
//  Created by abc on 2017/3/23.
//  Copyright © 2017年 ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"
#import <CoreLocation/CoreLocation.h>
@interface tiaozhuanViewController : UIViewController<CLLocationManagerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(retain,nonatomic) StoreModel *model;
@property (nonatomic,strong)CLLocationManager   * locMgr;

@end
