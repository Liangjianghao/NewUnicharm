//
//  StoreModel.h
//  Unicharm
//
//  Created by EssIOS on 16/8/5.
//  Copyright © 2016年 ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject


@property (nonatomic,strong)NSString * userID;
@property (nonatomic,strong)NSString * NameCn;
@property (nonatomic,strong)NSString * month;
@property (nonatomic,strong)NSString * userType;

@property (nonatomic,strong)NSString * ID;
@property (nonatomic,strong)NSString * StoreNo;
@property (nonatomic,strong)NSString * PlanNo;
@property (nonatomic,strong)NSString * PlanItem;
@property (nonatomic,strong)NSString * PlanType;
@property (nonatomic,strong)NSString * PlanStartDate;
@property (nonatomic,strong)NSString * PlanEndDate;
@property (nonatomic,strong)NSString * PlanMonth;
@property (nonatomic,strong)NSString * ShelfSectionNumber1;
@property (nonatomic,strong)NSString * ShelfSectionNumber2;
@property (nonatomic,strong)NSString * ShelfSectionNumber3;
@property (nonatomic,strong)NSString * TG;
@property (nonatomic,strong)NSString * ShopBuiltForm;
@property (nonatomic,strong)NSString * Coaming;
@property (nonatomic,strong)NSString * IsVerify;
@property (nonatomic,strong)NSString * IsUpload;

@property (nonatomic,strong)NSString * KPICategory;


@property (nonatomic,strong)NSString * Expand1;
@property (nonatomic,strong)NSString * Expand2;


@property (nonatomic,strong)NSString * Name;
@property (nonatomic,strong)NSString * Id;
@property (nonatomic,strong)NSString * Address;

@property (nonatomic,strong)NSString * Code;

@property (nonatomic,strong)NSString * storeID;


@property (nonatomic,strong)NSString * SignIn;
@property (nonatomic,strong)NSString * SignOut;
@property (nonatomic,strong)NSString * SignInImg;

@property (nonatomic,strong)NSString * SignInLng;
@property (nonatomic,strong)NSString * SignInLat;
@property (nonatomic,strong)NSString * SignOutLng;
@property (nonatomic,strong)NSString * SignOutLat;
@property (nonatomic,strong)NSString * imgUrl;

@property (nonatomic,strong)NSString * kpiCount;
@property (nonatomic,strong)NSString * kpiDsrCount;

@property (nonatomic,assign)BOOL  isdsr
;




@end
