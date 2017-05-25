//
//  DetailViewController.h
//  Unicharm
//
//  Created by EssIOS on 16/8/5.
//  Copyright © 2016年 ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"
#import "ProductModel.h"
#import <CoreLocation/CoreLocation.h>

@interface DetailViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate>
@property(retain,nonatomic) StoreModel *model;
@property(retain,nonatomic) NSString  *type;

//@property (strong,nonatomic)ProductModel *model;

@property(retain,nonatomic)NSString *name;
@property(retain,nonatomic)NSString *status;
@property(retain,nonatomic)NSString *KPICategory;
@end
