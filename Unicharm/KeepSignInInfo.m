//
//  KeepSignInInfo.m
//  Essence
//
//  Created by EssIOS on 15/5/12.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "KeepSignInInfo.h"
#import "FMDB.h"
#import "signInModel.h"
#import "SellModel.h"
#import "PatrolModel.h"
#import "PGRecruitModel.h"
#import "PhotoModel.h"
#import "LeaveModel.h"
#define USER_ID [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
@implementation KeepSignInInfo

#pragma mark --创建新的签到数据
//创建新的签到数据
+ (void)createNewSignInTable
{
    FMDatabase *db = [FMDatabase databaseWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/NewSignIn.sqlite"]];
    if ([db open]) {
        if (![db tableExists:@"newSignIn"])
        {
            NSString *newCheckTable = [NSString stringWithFormat:@"CREATE TABLE newSignIn (identifier text,checkInLatitude text,checkInLocationTime text,checkInLocationType text,checkInLongitude text,checkInTime text,identifier text,checkOutLatitude text,checkOutLocationTime text,checkOutLocationType text,checkOutLongitude text,checkOutTime text,companyCode text,isUpload text,itemCode text,storeCode text,uid text)"];
            BOOL res = [db executeUpdate:newCheckTable];
            if (!res) {
                NSLog(@"|**=== error when creating db table ===**|");
            } else {
                NSLog(@"|**=== success to creating db table ===**|");
            }
        }
        [db close];
    }
    
}
//+ (void)creatCheckTable
//{
//    FMDatabase *db = [self getDB];
//    if ([db open]) {
//        if (![db tableExists:@"check"]) {
//            NSString *creatString = [NSString stringWithFormat:@"CREATE TABLE check (identifier text,checkInLatitude text,checkInLocationTime text,checkInLocationType text,checkInLongitude text,checkInTime text,identifier text,checkOutLatitude text,checkOutLocationTime text,checkOutLocationType text,checkOutLongitude text,checkOutTime text,Id INTEGER,isUpload text,ProjectID text,storeCode text,userID text)"];
//            BOOL res = [db executeUpdate:creatString];
//            if (!res) {
//                NSLog(@"建表成功");
//            }else
//            {
//                NSLog(@"建表失败");
//            }
//        }
//    }
//    [db close];
//}

//创建公司table
+(void)creatCompanyTable
{
    FMDatabase *db = [self getDB];
    if ([db open]) {
        if (![db tableExists:@"company"]) {
            NSString * creatString = [NSString stringWithFormat:@"CREATE TABLE signIn (Address text,companyLatitude text,companyLongitude text,companyName text,ID text,ProjectID text,ProjectName text)"];
            [db executeUpdate:creatString];
        }
    }
    [db close];
}

// 创建签到table
+ (void)creatSignInTable
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"signIn"])
        {
            
            //            NSString * creatString = [NSString stringWithFormat:@"CREATE TABLE signIn (userID text,StoreCode text,identifier text,signLongitude text,signLatitude text,signLocationType text,signLocationTtime  text,signInType text,signCreatetime text,goOutLongitude text,goOutLatitude text,goOutLocationType text,goOutLocationTtime  text,goOutInType text,goOutCreatetime text,storeName text,projectName text,btnSelect text,companyName text)"];
            //
            //            [db executeUpdate:creatString];
            NSString *newCheckTable = [NSString stringWithFormat:@"CREATE TABLE signIn (checkInImei text,checkInLatitude text,checkInLocationTime text,checkInLocationType text,checkInLongitude text,checkInTime text,signInType text,checkOutImei text,checkOutLatitude text,checkOutLocationTime text,checkOutLocationType text,checkOutLongitude text,checkOutTime text,goOutInType text,companyCode text,itemCode text,storeCode text,userID text,storeName text,projectName text,btnSelect text,companyName text)"];
            BOOL res = [db executeUpdate:newCheckTable];
            if (!res) {
                NSLog(@"|**=== 1error when creating db table ===**|  %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|  %d",res);
            }
            
        }
    }
    [db close];
}
// 创建相关门店信息
+ (void)creatMDInfo
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"MDInfo"])
        {
            
            NSString *newCheckTable = [NSString stringWithFormat:@"CREATE TABLE MDInfo (userID text,ProjectId text,StoreId text,Code text,CreateDate text,CreateUserId text,DiDui text,Area text,Position text,POSM text,state text,ProductId text,Price text,ProductSmell text,AreaRatio text,Expand1 text,Expand2 text,Expand3 text,Expand4 text,Expand5 text,Expand6 text,Expand7 text,Expand8 text,Expand9 text,Expand10 text)"];
            BOOL res = [db executeUpdate:newCheckTable];
            if (!res) {
                NSLog(@"|**=== 1error when creating db table ===**|  %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|  %d",res);
            }
            
        }
    }
    [db close];
}
// 创建相关门店信息
+ (void)creatStoreInfo
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"storeInfo"])
        {
          
            NSString *newCheckTable = [NSString stringWithFormat:@"CREATE TABLE storeInfo (userID text,ProjectId text,StoreId text,Code text,CreateDate text,CreateUserId text,DiDui text,Area text,Position text,POSM text,state text,ProductId text,Price text,ProductSmell text,AreaRatio text,Expand1 text,Expand2 text,Expand3 text,Expand4 text,Expand5 text,Expand6 text,Expand7 text,Expand8 text,Expand9 text,Expand10 text,Expand11 text,Expand12 text,Expand13 text,Expand14 text,Expand15 text,Expand16 text,Expand17 text,Expand18 text,Expand19 text,Expand20 text,Expand21 text,Expand22 text,Expand23 text,Expand24 text,Expand25 text,Expand26 text,Expand27 text,Expand28 text,Expand29 text,Expand30 text)"];
            BOOL res = [db executeUpdate:newCheckTable];
            if (!res) {
                NSLog(@"|**=== 1error when creating db table ===**|  %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|  %d",res);
            }
            
        }
    }
    [db close];
}
// 创建巡店拍照table
+ (void)creatPhotoTable
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"photoInfo"])
        {
            [db executeUpdate:@"CREATE TABLE photoInfo (userID text,StoreCode text,selectType text,imageType text,identifier text,Longitude text,LocationTtime  text,Latitude text,Createtime text,imageUrl text,imageID text)"];
        }
    }
    [db close];
}
// 创建巡店详情table
+ (void)creatDetailTable
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"detail"])
        {
            [db executeUpdate:@"CREATE TABLE detail (userID text,StoreCode text,selectType text,imageType text,identifier text,ProductID text,ProductCount  text,ProductTest text,ProductPrice text,ProductAcreage text,text1 text,text2 text,text3 text,text4 text,text5 text,text6 text,text7 text,text8 text,text9 text,text10 text)"];
        }
    }
    [db close];
}
// 创建卖进table
+ (void)creatSellInfoTable
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"sellInfo"])
        {
            [db executeUpdate:@"CREATE TABLE sellInfo (userID text,StoreCode text,Name text,Phone text,identifier text,IdCard text,isSuccess text,Cretime text)"];
        }
    }
    [db close];
}
// 创建PG招募table
+ (void)creatPGRecruitTable
{
    FMDatabase * db = [self getDB];
    
    [db setShouldCacheStatements:YES];
    
    if ([db open])
    {
        if (![db tableExists:@"pgrecruit"])
        {
            [db executeUpdate:@"CREATE TABLE pgrecruit (userID text,StoreCode text,Name text,Phone text,identifier text,IdCard text,Qq text,Weixin text,Headimgpath text,bodyImgPath text,Createtime text)"];
            
        }
        
    }
    [db close];
}
// 创建门店定位table
+ (void)creatStoreLocationTable
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"storeLocation"])
        {
            [db executeUpdate:@"CREATE TABLE storeLocation (identifier text,StoreId text,userID text,LocationType text,LocationTtime text,Latitude text,Longitude text)"];
        }
    }
    [db close];
}
// 创建请假table
+ (void)creatLeaveInfoTable
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"leaveInfo"])
        {
            [db executeUpdate:@"CREATE TABLE leaveInfo (userID text,identifier text,time text,QjType text,TimeType text)"];
        }
    }
    [db close];
}

#pragma mark --新的签到信息存储
//新的签到信息存储
+ (void)insertNewSignInTableWithTheDictionary:(NSDictionary *)newSignInDic
{
    [self createNewSignInTable];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/NewSignIn.sqlite"]];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *checkInImei          = [newSignInDic objectForKey:@"identifier"];
        NSString *checkInLatitude      = [newSignInDic objectForKey:@"checkInLatitude"];
        NSString *checkInLocationTime  = [newSignInDic objectForKey:@"checkInLocationTime"];
        NSString *checkInLocationType  = [newSignInDic objectForKey:@"checkInLocationType"];
        NSString *checkInLongitude     = [newSignInDic objectForKey:@"checkInLongitude"];
        NSString *checkInTime          = [newSignInDic objectForKey:@"checkInTime"];
        
        NSString *checkOutImei         = [newSignInDic objectForKey:@"identifier"];
        NSString *checkOutLatitude     = [newSignInDic objectForKey:@"checkOutLatitude"];
        NSString *checkOutLocationTime = [newSignInDic objectForKey:@"checkOutLocationTime"];
        NSString *checkOutLocationType = [newSignInDic objectForKey:@"checkOutLocationType"];
        NSString *checkOutLongitude    = [newSignInDic objectForKey:@"checkOutLongitude"];
        NSString *checkOutTime         = [newSignInDic objectForKey:@"checkOutTime"];
        
        NSString *companyCode          = [newSignInDic objectForKey:@"Id"];
        NSString *isUpload             = [newSignInDic objectForKey:@"isUpload"];
        NSString *itemCode             = [newSignInDic objectForKey:@"itemCode"];
        NSString *storeCode            = [newSignInDic objectForKey:@"storeCode"];
        NSString *uid                  = [newSignInDic objectForKey:@"uid"];
        if ([db open])
        {
            NSString * insertString = [NSString stringWithFormat:@"insert into newSignIn (identifier,checkInLatitude,checkInLocationTime,checkInLocationType,checkInLongitude,identifier,checkOutImei,checkOutLatitude,checkOutLocationTime,checkOutLocationType,checkOutLongitude,checkOutTime,Id,isUpload,itemCode,storeCode,uid) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",checkInImei,checkInLatitude,checkInLocationTime,checkInLocationType,checkInLongitude,checkInTime,checkOutImei,checkOutLatitude,checkOutLocationTime,checkOutLocationType,checkOutLongitude,checkOutTime,companyCode,isUpload,itemCode,storeCode,uid,@"null"];
            [db executeUpdate:insertString];
            NSLog(@"数据  %@",insertString);
        }
        [db close];
    }];
}
//+ (void)insertCheckTableWithTheDictionary:(NSDictionary *)ceShiDic
//{
//    [self creatCheckTable];
//
//    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
//
//    [queue inDatabase:^(FMDatabase *db) {
//        NSString *checkInImei          = [ceShiDic objectForKey:@"identifier"];
//        NSString *checkInLatitude      = [ceShiDic objectForKey:@"checkInLatitude"];
//        NSString *checkInLocationTime  = [ceShiDic objectForKey:@"checkInLocationTime"];
//        NSString *checkInLocationType  = [ceShiDic objectForKey:@"checkInLocationType"];
//        NSString *checkInLongitude     = [ceShiDic objectForKey:@"checkInLongitude"];
//        NSString *checkInTime          = [ceShiDic objectForKey:@"checkInTime"];
//
//        NSString *checkOutImei         = [ceShiDic objectForKey:@"identifier"];
//        NSString *checkOutLatitude     = [ceShiDic objectForKey:@"checkOutLatitude"];
//        NSString *checkOutLocationTime = [ceShiDic objectForKey:@"checkOutLocationTime"];
//        NSString *checkOutLocationType = [ceShiDic objectForKey:@"checkOutLocationType"];
//        NSString *checkOutLongitude    = [ceShiDic objectForKey:@"checkOutLongitude"];
//        NSString *checkOutTime         = [ceShiDic objectForKey:@"checkOutTime"];
//
//        NSString *Id                   = [ceShiDic objectForKey:@"Id"];
//        NSString *isUpload             = [ceShiDic objectForKey:@"isUpload"];
//        NSString *ProjectID            = [ceShiDic objectForKey:@"ProjectID"];
//        NSString *storeCode            = [ceShiDic objectForKey:@"storeCode"];
//        NSString *userID               = [ceShiDic objectForKey:@"userID"];
//
//        if ([db open]) {
//            NSString *insertString = [NSString stringWithFormat:@"insert into check (identifier,checkInLatitude,checkInLocationTime,checkInLocationType,checkInLongitude,checkInTime,identifier,checkOutLatitude,checkOutLocationTime,checkOutLocationType,checkOutLongitude,checkOutTime,Id,isUpload,ProjectID,storeCode,userID) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",checkInImei,checkInLatitude,checkInLocationTime,checkInLocationType,checkInLongitude,checkInTime,checkOutImei,checkOutLatitude,checkOutLocationTime,checkOutLocationType,checkOutLongitude,checkOutTime,Id,isUpload,ProjectID,storeCode,userID,@"null"];
//
//            [db executeUpdate:insertString];
//        }
//        [db close];
//    }];
//
//}
#pragma mark --查询签到信息
// 查询签到信息
+ (NSMutableArray *)selectCheckTable
{
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    
    NSMutableArray *array = [NSMutableArray array];
    
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            NSString *selectCeShi = [NSString stringWithFormat:@"select * from NewSignIn where userID like '%@'",USER_ID];
            FMResultSet *set = [db executeQuery:selectCeShi];
            while ([set next]) {
                signInModel *signIn = [[signInModel alloc]init];
                
                signIn.checkInImei = [set stringForColumn:@"identifier"];
                if ([[set stringForColumn:@"checkInLatitude"]isEqualToString:@"(null)"]) {
                    signIn.checkInLatitude = @"0.0";
                }else
                {
                    signIn.checkInLatitude = [set stringForColumn:@"checkInLatitude"];
                }
                if ([[set stringForColumn:@"checkInLocationTime"]isEqualToString:@"(null)"]) {
                    signIn.checkInLocationTime = @"0";
                }else
                {
                    signIn.checkInLocationTime = [set stringForColumn:@"checkInLocationTime"];
                }
                if ([[set stringForColumn:@"checkInLocationType"]isEqualToString:@"(null)"]) {
                    signIn.checkInLocationType = @"0";
                }else
                {
                    signIn.checkInLocationType = [set stringForColumn:@"checkInLocationType"];
                }
                if ([[set stringForColumn:@"checkInLongitude"]isEqualToString:@"(null)"]) {
                    signIn.checkInLongitude = @"0.0";
                }
                else
                {
                    signIn.checkInLongitude = [set stringForColumn:@"checkInLongitude"];
                }
                if ([[set stringForColumn:@"checkInTime"]isEqualToString:@"(null)"]) {
                    signIn.checkInTime = @"0";
                }
                else{
                    signIn.checkInTime = [set stringForColumn:@"checkInTime"];
                }
                
                signIn.checkOutImei = [set stringForColumn:@"identifier"];
                if ([[set stringForColumn:@"checkOutLatitude"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLatitude = @"0.0";
                }else
                {
                    signIn.checkOutLatitude = [set stringForColumn:@"checkOutLatitude"];
                }
                if ([[set stringForColumn:@"checkOutLocationTime"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLocationTime = @"0";
                }else
                {
                    signIn.checkOutLocationTime = [set stringForColumn:@"checkOutLocationTime"];
                }
                if ([[set stringForColumn:@"checkOutLocationType"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLocationType = @"0";
                }else
                {
                    signIn.checkOutLocationType = [set stringForColumn:@"checkOutLocationType"];
                }
                if ([[set stringForColumn:@"checkOutLongitude"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLongitude = @"0.0";
                }else
                {
                    signIn.checkOutLongitude = [set stringForColumn:@"checkOutLongitude"];
                }
                signIn.checkOutTime = [set stringForColumn:@"checkOutTime"];
                
                signIn.Id = [set stringForColumn:@"Id"];
                
                if ([[set stringForColumn:@"isUpload"]isEqualToString:@"(null)"]) {
                    signIn.isUpload = @"0";
                }else
                {
                    signIn.isUpload = [set stringForColumn:@"isUpload"];
                }
                signIn.ProjectID = [set  stringForColumn:@"ProjectID"];
                signIn.StoreCode = [set stringForColumn:@"StoreCode"];
                signIn.userID = [set stringForColumn:@"userID"];
                
                [array addObject:signIn];
            };
        }
    }];
    return array;
}
// 插入签到信息
+ (void)insertSignInTableWithTheDictionary:(NSDictionary *)signInDic
{
    [self creatSignInTable];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    // 使用
    [queue inDatabase:^(FMDatabase *db) {
        
        
        NSString *userID        =[signInDic objectForKey:@"userID"];
        NSString *StoreCode     =[signInDic objectForKey:@"StoreCode"];
        NSString *Longitude     =[signInDic objectForKey:@"Longitude"];
        NSString *Latitude      =[signInDic objectForKey:@"Latitude"];
        NSString *LocationType  =[signInDic objectForKey:@"LocationType"];
        NSString *LocationTtime =[signInDic objectForKey:@"LocationTtime"];
        NSString *signInType    =[signInDic objectForKey:@"signInType"];
        NSString *identifier    =[signInDic objectForKey:@"identifier"];
        NSString *Createtime    =[signInDic objectForKey:@"Createtime"];
        NSString *storeName     =[signInDic objectForKey:@"storeName"];
        NSString *projectName   =[signInDic objectForKey:@"projectName"];
        NSString *btnSelect     =[signInDic objectForKey:@"btnSelect"];
        NSString *companyName  = [signInDic objectForKey:@"companyName"];
        NSString *Id           = [signInDic objectForKey:@"Id"];
        NSString *ProjectID    = [signInDic objectForKey:@"ProjectID"];
        
        if ([db open])
        {
            
            NSString * insertString = [NSString stringWithFormat:@"insert into signIn (userID,StoreCode,checkInImei,checkInLongitude,checkInLatitude,checkInLocationType,checkInLocationTime,signInType,checkInTime,storeName,projectName,btnSelect,companyName,companyCode,itemCode,checkOutImei,checkOutTime) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",userID,StoreCode,identifier,Longitude,Latitude,LocationType,LocationTtime,signInType,Createtime,storeName,projectName,btnSelect,companyName,Id,ProjectID,identifier,@"null"];
            BOOL res = [db executeUpdate:insertString];
            //            [db executeUpdate:insertString];
            if (!res) {
                NSLog(@"|**=== 2error when creating db table ===**|   %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|   %d",res);
            }
            NSLog(@"数据  %@",insertString);
        }
        
        [db close];
    }];
}

//更新门店信息
+ (void)updataMDWithTheDictionary:(ProductModel *)model
{
    [self creatMDInfo];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    // 使用
    [queue inDatabase:^(FMDatabase *db) {
        
        
        NSString *userID        =model.userID;
        NSString *StoreCode     =model.ProjectId;
        NSString *Longitude     =model.StoreId;
        NSString *Latitude      =model.Code;
        NSString *LocationType  =model.CreateDate;
        NSString *LocationTtime =model.CreateUserId;
        //        NSString *signInType    =model.DiDui;
        //        NSString *identifier    =model.Area;
        //        NSString *Createtime    =model.Position;
        //        NSString *storeName     =model.POSM;
        //        NSString *productId     =model.ProductId;
        //        NSString *price            =model.Price;
        //        NSString *productSmell   =model.ProductSmell;
        //        NSString *areaRatio=   model.AreaRatio;
        //        NSString *state=   model.MDstate;
        NSString *Expand1   =model.Expand1;
        NSString *Expand2    =model.Expand2;
        NSString *Expand3  = model.Expand3;
        NSString *Expand4           = model.Expand4;
        NSString *Expand5    = model.Expand5;
        NSString *Expand6    = model.Expand6;
                NSString *Expand7   = model.Expand7;
        
                        NSString *Expand8   = model.Expand8;
                        NSString *Expand9   = model.Expand9;
                        NSString *Expand10   = model.Expand10;
        
        NSString *Expand11   =model.Expand11;
        NSString *Expand12    =model.Expand12;
        NSString *Expand13  = model.Expand13;
        NSString *Expand14           = model.Expand14;
        NSString *Expand15    = model.Expand15;
        NSString *Expand16    = model.Expand16;
        NSString *Expand17    = model.Expand17;
        NSString *Expand18    = model.Expand18;
        NSString *Expand19    = model.Expand19;
        NSString *Expand20    = model.Expand20;
        
        NSString *Expand21   =model.Expand21;
        NSString *Expand22    =model.Expand22;
        NSString *Expand23  = model.Expand23;
        NSString *Expand24           = model.Expand24;
        NSString *Expand25    = model.Expand25;
        NSString *Expand26    = model.Expand26;
        NSString *Expand27    = model.Expand27;
        NSString *Expand28    = model.Expand28;
        NSString *Expand29    = model.Expand29;
        NSString *Expand30    = model.Expand30;

        
        
        if ([db open])
        {
            //            NSString * insertString = [NSString stringWithFormat:@"update MDInfo (userID,ProjectId,StoreId,Code,CreateDate,CreateUserId,DiDui,Area,Position,POSM,state,ProductId,Price,ProductSmell,AreaRatio,Expand1,Expand2,Expand3,Expand4,Expand5,Expand6,Expand7,Expand8,Expand9,Expand10) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@' where Code like '%@')",userID,StoreCode,Longitude,Latitude,LocationType,LocationTtime,signInType,identifier,Createtime,storeName,state,productId,price,productSmell,areaRatio,projectName,@"YES",companyName,Id,ProjectID,@"",@"",@"",@"",@"",Latitude];
            //            insertString=[NSString stringWithFormat:@"update MDInfo set userID='%@' and ProjectId='%@' and StoreId,Code,CreateDate,CreateUserId,DiDui,Area,Position,POSM,state,ProductId,Price,ProductSmell,AreaRatio,Expand1,Expand2,Expand3,Expand4,Expand5,Expand6,Expand7,Expand8,Expand9,Expand10 where Code like '%@'",Latitude];
            NSString *  insertString=[NSString stringWithFormat:@"update storeInfo set userID='%@',ProjectId='%@',StoreId='%@',Code='%@',CreateDate='%@',CreateUserId='%@',Expand1='%@',Expand2='%@',Expand3='%@',Expand4='%@',Expand5='%@',Expand6='%@',Expand7='%@',Expand8='%@',Expand9='%@',Expand10='%@',Expand11='%@',Expand12='%@',Expand13='%@',Expand14='%@',Expand15='%@',Expand16='%@',Expand17='%@',Expand18='%@',Expand19='%@',Expand20='%@',Expand21='%@',Expand22='%@',Expand23='%@',Expand24='%@',Expand25='%@',Expand26='%@',Expand27='%@',Expand28='%@',Expand29='%@',Expand30='%@' where Code like '%@'",userID,StoreCode,Longitude,Latitude,LocationType,LocationTtime,Expand1,Expand2,Expand3,Expand4,Expand5,Expand6,Expand7,Expand8,Expand9,Expand10,Expand11,Expand12,Expand13,Expand14,Expand15,Expand16,Expand17,Expand18,Expand19,Expand20,Expand21,Expand22,Expand23,Expand24,Expand25,Expand26,Expand27,Expand28,Expand29,Expand30,model.Code];
            BOOL res = [db executeUpdate:insertString];
            //            [db executeUpdate:insertString];
            if (!res) {
                NSLog(@"|**=== 2error when creating db table ===**|   %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|   %d",res);
            }
            NSLog(@"数据  %@",insertString);
        }
        
        [db close];
    }];
    
}
//存储门店信息
+ (void)keepMDWithTheDictionary:(ProductModel *)model
{
    [self creatMDInfo];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    // 使用
    [queue inDatabase:^(FMDatabase *db) {
        
        
        NSString *userID        =model.userID;
        NSString *StoreCode     =model.ProjectId;
        NSString *Longitude     =model.StoreId;
        NSString *Latitude      =model.Code;
        NSString *LocationType  =model.CreateDate;
        NSString *LocationTtime =model.CreateUserId;
        NSString *signInType    =model.DiDui;
        NSString *identifier    =model.Area;
        NSString *Createtime    =model.Position;
        NSString *storeName     =model.POSM;
        NSString *productId     =model.ProductId;
        NSString *price            =model.Price;
        NSString *productSmell   =model.ProductSmell;
        NSString *areaRatio=   model.AreaRatio;
        NSString *state=   model.MDstate;
        NSString *btnSelect   =model.Expand1;
        NSString *projectName    =model.Expand2;
        NSString *companyName  = model.Expand3;
        NSString *Id           = model.Expand4;
        NSString *ProjectID    = model.Expand5;
        
        if ([db open])
        {
            NSString * insertString = [NSString stringWithFormat:@"insert into MDInfo (userID,ProjectId,StoreId,Code,CreateDate,CreateUserId,DiDui,Area,Position,POSM,state,ProductId,Price,ProductSmell,AreaRatio,Expand1,Expand2,Expand3,Expand4,Expand5,Expand6,Expand7,Expand8,Expand9,Expand10) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",userID,StoreCode,Longitude,Latitude,LocationType,LocationTtime,signInType,identifier,Createtime,storeName,state,productId,price,productSmell,areaRatio,projectName,@"YES",companyName,Id,ProjectID,@"",@"",@"",@"",@""];
            BOOL res = [db executeUpdate:insertString];
            //            [db executeUpdate:insertString];
            if (!res) {
                NSLog(@"|**=== 2error when creating db table ===**|   %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|   %d",res);
            }
            NSLog(@"数据  %@",insertString);
        }
        
        [db close];
    }];
    
}

+ (void)keepStoreWithTheDictionary:(ProductModel *)model
{
    [self creatStoreInfo];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    // 使用
    [queue inDatabase:^(FMDatabase *db) {

        NSString *userID        =model.userID;
        NSString *StoreCode     =model.ProjectId;
        NSString *Longitude     =model.StoreId;
        NSString *Latitude      =model.Code;
        NSString *LocationType  =model.CreateDate;
        NSString *LocationTtime =model.CreateUserId;
        NSString *signInType    =model.DiDui;
        NSString *identifier    =model.Area;
        NSString *Createtime    =model.Position;
        NSString *storeName     =model.POSM;
        NSString *productId     =model.ProductId;
        NSString *price            =model.Price;
        NSString *productSmell   =model.ProductSmell;
        NSString *areaRatio=   model.AreaRatio;
        NSString *state=   model.MDstate;
        
        NSString *Expand1   =model.Expand1;
        NSString *Expand2    =model.Expand2;
        NSString *Expand3  = model.Expand3;
        NSString *Expand4           = model.Expand4;
        NSString *Expand5    = model.Expand5;
                NSString *Expand6    = model.Expand6;
                NSString *Expand7    = model.Expand7;
                NSString *Expand8    = model.Expand8;
                NSString *Expand9    = model.Expand9;
                NSString *Expand10    = model.Expand10;
        
        
        NSString *Expand11   =model.Expand11;
        NSString *Expand12    =model.Expand12;
        NSString *Expand13  = model.Expand13;
        NSString *Expand14           = model.Expand14;
        NSString *Expand15    = model.Expand15;
        NSString *Expand16    = model.Expand16;
        NSString *Expand17    = model.Expand17;
        NSString *Expand18    = model.Expand18;
        NSString *Expand19    = model.Expand19;
        NSString *Expand20    = model.Expand20;
        
        NSString *Expand21   =model.Expand21;
        NSString *Expand22    =model.Expand22;
        NSString *Expand23  = model.Expand23;
        NSString *Expand24           = model.Expand24;
        NSString *Expand25    = model.Expand25;
        NSString *Expand26    = model.Expand26;
        NSString *Expand27    = model.Expand27;
        NSString *Expand28    = model.Expand28;
        NSString *Expand29    = model.Expand29;
        NSString *Expand30    = model.Expand30;
        
        
        if ([db open])
        {
            NSString * insertString = [NSString stringWithFormat:@"insert into storeInfo (userID,ProjectId,StoreId,Code,CreateDate,CreateUserId,DiDui,Area,Position,POSM,state,ProductId,Price,ProductSmell,AreaRatio,Expand1,Expand2,Expand3,Expand4,Expand5,Expand6,Expand7,Expand8,Expand9,Expand10,Expand11,Expand12,Expand13,Expand14,Expand15,Expand16,Expand17,Expand18,Expand19,Expand20,Expand21,Expand22,Expand23,Expand24,Expand25,Expand26,Expand27,Expand28,Expand29,Expand30) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",userID,StoreCode,Longitude,Latitude,LocationType,LocationTtime,signInType,identifier,Createtime,storeName,state,productId,price,productSmell,areaRatio,Expand1,Expand2,Expand3,Expand4,Expand5,Expand6,Expand7,Expand8,Expand9,Expand10,Expand11,Expand12,Expand13,Expand14,Expand15,Expand16,Expand17,Expand18,Expand19,Expand20,Expand21,Expand22,Expand23,Expand24,Expand25,Expand26,Expand27,Expand28,Expand29,Expand30];
            BOOL res = [db executeUpdate:insertString];
            //            [db executeUpdate:insertString];
            if (!res) {
                NSLog(@"|**=== 2error when creating db table ===**|   %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|   %d",res);
            }
            NSLog(@"数据  %@",insertString);
        }
        
        [db close];
    }];

}
// 更改签到信息
+ (void)upLoadDataWithTheDictionary:(NSDictionary *)goOutDic
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    
    [queue inDatabase:^(FMDatabase *db) {
        NSString *Longitude =[goOutDic objectForKey:@"Longitude"];
        NSString *Latitude =[goOutDic objectForKey:@"Latitude"];
        NSString *LocationType =[goOutDic objectForKey:@"LocationType"];
        NSString *LocationTtime =[goOutDic objectForKey:@"LocationTtime"];
        NSString *signInType =[goOutDic objectForKey:@"signInType"];
        NSString *Createtime =[goOutDic objectForKey:@"Createtime"];
        //NSString *identifier    =[goOutDic objectForKey:@"identifier"];
        NSString *StoreCode  =[goOutDic objectForKey:@"StoreCode"];
        //        NSString *Id           = [goOutDic objectForKey:@"Id"];
        //        NSString *ProjectID    = [goOutDic objectForKey:@"ProjectID"];
        //        NSString *storeName =[goOutDic objectForKey:@"storeName"];
        //        NSString *projectName=[goOutDic objectForKey:@"projectName"];
        if ([db open])
        {
            //            NSString * insertString = [NSString stringWithFormat:@"update  signIn set checkOutLongitude='%@',checkOutLatitude='%@',checkOutLocationType='%@',checkOutLocationTime='%@',goOutInType='%@',checkOutTime='%@' where StoreCode like'%@' and companyCode like '%@' and itemCode like '%@' and userID like '%@'",Longitude,Latitude,LocationType,LocationTtime,signInType,Createtime,StoreCode,Id,ProjectID,USER_ID];
            NSString * insertString = [NSString stringWithFormat:@"update  signIn set checkOutLongitude='%@',checkOutLatitude='%@',checkOutLocationType='%@',checkOutLocationTime='%@',goOutInType='%@',checkOutTime='%@' where StoreCode like'%@' and userID like '%@'",Longitude,Latitude,LocationType,LocationTtime,signInType,Createtime,StoreCode,USER_ID];
            // [db executeUpdate:insertString];
            NSLog(@" insertString1---- %@",insertString);
            BOOL res = [db executeUpdate:insertString];
            if (!res) {
                NSLog(@"|**=== error when creating db table ===**|   %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|   %d",res);
            }
            
        }
        [db close];
        
    }];
}
+ (void)upLoadSignInWithTheDictionary:(NSDictionary *)goOutDic
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    
    [queue inDatabase:^(FMDatabase *db) {
        //        NSString *Longitude =[goOutDic objectForKey:@"Longitude"];
        //        NSString *Latitude =[goOutDic objectForKey:@"Latitude"];
        //        NSString *LocationType =[goOutDic objectForKey:@"LocationType"];
        //        NSString *LocationTtime =[goOutDic objectForKey:@"LocationTtime"];
        //        NSString *signInType =[goOutDic objectForKey:@"signInType"];
        //        NSString *Createtime =[goOutDic objectForKey:@"Createtime"];
        //NSString *identifier    =[goOutDic objectForKey:@"identifier"];
        NSString *StoreCode  =[goOutDic objectForKey:@"storeCode"];
        NSString *companyName  =[goOutDic objectForKey:@"companyName"];
        NSString *storeName  =[goOutDic objectForKey:@"storeName"];
        NSString *str=@"NO";
        if ([db open])
        {
            if (![StoreCode isEqualToString:@""]) {
                //            NSString * insertString = [NSString stringWithFormat:@"update  signIn set checkOutLongitude='%@',checkOutLatitude='%@',checkOutLocationType='%@',checkOutLocationTime='%@',goOutInType='%@',checkOutTime='%@' where StoreCode like'%@' and companyCode like '%@' and itemCode like '%@' and userID like '%@'",Longitude,Latitude,LocationType,LocationTtime,signInType,Createtime,StoreCode,Id,ProjectID,USER_ID];
                NSString * insertString = [NSString stringWithFormat:@"update  signIn set btnSelect='%@' where StoreCode like'%@' and userID like '%@'",str,StoreCode,USER_ID];
                // [db executeUpdate:insertString];
                NSLog(@" insertString1---- %@",insertString);
                BOOL res = [db executeUpdate:insertString];
                if (!res) {
                    NSLog(@"|**=== error when creating db table ===**|   %d",res);
                } else {
                    NSLog(@"|**=== success to creating db table ===**|   %d",res);
                }
            }
            else if (companyName)
            {
                NSString * insertString = [NSString stringWithFormat:@"update  signIn set btnSelect='%@' where companyName like'%@' and userID like '%@'",str,companyName,USER_ID];
                // [db executeUpdate:insertString];
                NSLog(@" insertString1---- %@",insertString);
                BOOL res = [db executeUpdate:insertString];
                if (!res) {
                    NSLog(@"|**=== error when creating db table ===**|   %d",res);
                } else {
                    NSLog(@"|**=== success to creating db table ===**|   %d",res);
                }
                
            }
            else
            {
                NSString * insertString = [NSString stringWithFormat:@"update  signIn set btnSelect='%@' where storeName like'%@' and userID like '%@'",str,storeName,USER_ID];
                // [db executeUpdate:insertString];
                NSLog(@" insertString1---- %@",insertString);
                BOOL res = [db executeUpdate:insertString];
                if (!res) {
                    NSLog(@"|**=== error when creating db table ===**|   %d",res);
                } else {
                    NSLog(@"|**=== success to creating db table ===**|   %d",res);
                }
                
                
            }
            
            
        }
        [db close];
        
    }];
}
// 更改签到信息 2
+ (void)upLoadDataWithTheDictionary2:(NSDictionary *)goOutDic
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    
    [queue inDatabase:^(FMDatabase *db) {
        NSString *Longitude =[goOutDic objectForKey:@"Longitude"];
        NSString *Latitude =[goOutDic objectForKey:@"Latitude"];
        NSString *LocationType =[goOutDic objectForKey:@"LocationType"];
        NSString *LocationTtime =[goOutDic objectForKey:@"LocationTtime"];
        NSString *signInType =[goOutDic objectForKey:@"signInType"];
        NSString *Createtime =[goOutDic objectForKey:@"Createtime"];
        //NSString *identifier    =[goOutDic objectForKey:@"identifier"];
        NSString *StoreCode  =[goOutDic objectForKey:@"StoreCode"];
        NSString *Id           = [goOutDic objectForKey:@"Id"];
        NSString *ProjectID    = [goOutDic objectForKey:@"ProjectID"];
        NSLog(@"Createtime-->%@",Createtime);
        if ([db open])
        {
            NSString * insertString = [NSString stringWithFormat:@"update  signIn set checkOutLongitude='%@',checkOutLatitude='%@',checkOutLocationType='%@',checkOutLocationTime='%@',goOutInType='%@',checkOutTime='%@',StoreCode='%@' where companyCode like '%@' and userID like '%@'",Longitude,Latitude,LocationType,LocationTtime,signInType,Createtime,StoreCode,Id,USER_ID];
            // [db executeUpdate:insertString];
            NSLog(@"insertString2   %@",insertString);
            BOOL res = [db executeUpdate:insertString];
            if (!res) {
                NSLog(@"|**=== error when creating db table ===**|   %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|   %d",res);
            }
            
        }
        [db close];
        
    }];
}
//搜索门店信息
+ (ProductModel *)selectMDDetailTable:(NSString *)code
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
//    NSMutableArray * arr = [NSMutableArray array];
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
      ProductModel *model=[[ProductModel alloc]init];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            //            NSString * selectSignIn = [NSString stringWithFormat:@"select * from signIn where btnSelect like 'YES' and userID like '%@'",USER_ID];
            //                        NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where btnSelect like 'NO' and userID like '%@'",USER_ID];
            NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where Code like '%@' and userID like '%@'",code,USER_ID];
            FMResultSet * set = [db executeQuery:selectSignIn];
            
            while ([set next])
            {

                model.userID=[set stringForColumn:@"userID"];
                model.ProjectId=[set stringForColumn:@"ProjectId"];
                model.StoreId=[set stringForColumn:@"StoreId"];
                model.Code=[set stringForColumn:@"Code"];
                model.CreateDate=[set stringForColumn:@"CreateDate"];
                model.CreateUserId=[set stringForColumn:@"CreateUserId"];
                model.DiDui=[set stringForColumn:@"DiDui"];
                model.Area=[set stringForColumn:@"Area"];
                model.Position=[set stringForColumn:@"Position"];
                model.POSM=[set stringForColumn:@"POSM"];
                model.MDstate=[set stringForColumn:@"state"];
                model.ProductId=[set stringForColumn:@"ProductId"];
                model.Price=[set stringForColumn:@"Price"];
                model.ProductSmell=[set stringForColumn:@"ProductSmell"];
                
                model.AreaRatio=[set stringForColumn:@"AreaRatio"];
                model.Expand1=[set stringForColumn:@"Expand1"];
                model.Expand2=[set stringForColumn:@"Expand2"];
                model.Expand3=[set stringForColumn:@"Expand3"];
                model.Expand4=[set stringForColumn:@"Expand4"];
                model.Expand5=[set stringForColumn:@"Expand5"];
                model.Expand6=[set stringForColumn:@"Expand6"];
                model.Expand7=[set stringForColumn:@"Expand7"];
                model.Expand8=[set stringForColumn:@"Expand8"];
                //                model.Expand9=[set stringForColumn:@"Expand9"];
                //                model.Expand10=[set stringForColumn:@"Expand10"];
                
                
                
//                [arr addObject:model];
                
            }
        }
    }];
//    return  arr;
    return model;
    
}
//搜索所有门店信息
+ (NSMutableArray *)selectAllMDDetailTable
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    NSMutableArray * arr = [NSMutableArray array];
    
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            //            NSString * selectSignIn = [NSString stringWithFormat:@"select * from signIn where btnSelect like 'YES' and userID like '%@'",USER_ID];
            //                        NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where btnSelect like 'NO' and userID like '%@'",USER_ID];
            NSString * selectSignIn = [NSString stringWithFormat:@"select * from MDInfo where userID like '%@'",USER_ID];
            FMResultSet * set = [db executeQuery:selectSignIn];
            while ([set next])
            {
                ProductModel *model=[[ProductModel alloc]init];
                model.userID=[set stringForColumn:@"userID"];
                model.ProjectId=[set stringForColumn:@"ProjectId"];
                model.StoreId=[set stringForColumn:@"StoreId"];
                model.Code=[set stringForColumn:@"Code"];
                model.CreateDate=[set stringForColumn:@"CreateDate"];
                model.CreateUserId=[set stringForColumn:@"CreateUserId"];
                model.DiDui=[set stringForColumn:@"DiDui"];
                model.Area=[set stringForColumn:@"Area"];
                model.Position=[set stringForColumn:@"Position"];
                model.POSM=[set stringForColumn:@"POSM"];
                model.MDstate=[set stringForColumn:@"state"];
                model.ProductId=[set stringForColumn:@"ProductId"];
                model.Price=[set stringForColumn:@"Price"];
                model.ProductSmell=[set stringForColumn:@"ProductSmell"];
                
                model.AreaRatio=[set stringForColumn:@"AreaRatio"];
                model.Expand1=[set stringForColumn:@"Expand1"];
                model.Expand2=[set stringForColumn:@"Expand2"];
                model.Expand3=[set stringForColumn:@"Expand3"];
                model.Expand4=[set stringForColumn:@"Expand4"];
                model.Expand5=[set stringForColumn:@"Expand5"];
                model.Expand6=[set stringForColumn:@"Expand6"];
                model.Expand7=[set stringForColumn:@"Expand7"];
                model.Expand8=[set stringForColumn:@"Expand8"];
                //                model.Expand9=[set stringForColumn:@"Expand9"];
                //                model.Expand10=[set stringForColumn:@"Expand10"];
                
                
                
                [arr addObject:model];
                
            }
        }
    }];
    return  arr;
    
}
//搜索单一产品信息
+ (ProductModel *)selectOneProductDetailTable:(NSString *)code andProCode:(NSString *)productCode;
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
//    NSMutableArray * arr = [NSMutableArray array];
    ProductModel *model=[[ProductModel alloc]init];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            //            NSString * selectSignIn = [NSString stringWithFormat:@"select * from signIn where btnSelect like 'YES' and userID like '%@'",USER_ID];
            //                        NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where btnSelect like 'NO' and userID like '%@'",USER_ID];
            NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where Code like '%@' and ProductId like '%@' and userID like '%@'",code,productCode,USER_ID];
            FMResultSet * set = [db executeQuery:selectSignIn];
            while ([set next])
            {
//                ProductModel *model=[[ProductModel alloc]init];
                model.userID=[set stringForColumn:@"userID"];
                model.ProjectId=[set stringForColumn:@"ProjectId"];
                model.StoreId=[set stringForColumn:@"StoreId"];
                model.Code=[set stringForColumn:@"Code"];
                model.CreateDate=[set stringForColumn:@"CreateDate"];
                model.CreateUserId=[set stringForColumn:@"CreateUserId"];
                model.DiDui=[set stringForColumn:@"DiDui"];
                model.Area=[set stringForColumn:@"Area"];
                model.Position=[set stringForColumn:@"Position"];
                model.POSM=[set stringForColumn:@"POSM"];
                model.MDstate=[set stringForColumn:@"state"];
                model.ProductId=[set stringForColumn:@"ProductId"];
                model.Price=[set stringForColumn:@"Price"];
                model.ProductSmell=[set stringForColumn:@"ProductSmell"];
                
                model.AreaRatio=[set stringForColumn:@"AreaRatio"];
                model.Expand1=[set stringForColumn:@"Expand1"];
                model.Expand2=[set stringForColumn:@"Expand2"];
                model.Expand3=[set stringForColumn:@"Expand3"];
                model.Expand4=[set stringForColumn:@"Expand4"];
                model.Expand5=[set stringForColumn:@"Expand5"];
                model.Expand6=[set stringForColumn:@"Expand6"];
                model.Expand7=[set stringForColumn:@"Expand7"];
                model.Expand8=[set stringForColumn:@"Expand8"];
                model.Expand9=[set stringForColumn:@"Expand9"];
                model.Expand10=[set stringForColumn:@"Expand10"];
                model.Expand11=[set stringForColumn:@"Expand11"];
                model.Expand12=[set stringForColumn:@"Expand12"];
                model.Expand13=[set stringForColumn:@"Expand13"];
                model.Expand14=[set stringForColumn:@"Expand14"];
                model.Expand15=[set stringForColumn:@"Expand15"];
                model.Expand16=[set stringForColumn:@"Expand16"];
                model.Expand17=[set stringForColumn:@"Expand17"];
                model.Expand18=[set stringForColumn:@"Expand18"];
                model.Expand19=[set stringForColumn:@"Expand19"];
                model.Expand20=[set stringForColumn:@"Expand20"];
                model.Expand21=[set stringForColumn:@"Expand21"];
                model.Expand22=[set stringForColumn:@"Expand22"];
                model.Expand23=[set stringForColumn:@"Expand23"];
                model.Expand24=[set stringForColumn:@"Expand24"];
                model.Expand25=[set stringForColumn:@"Expand25"];
                model.Expand26=[set stringForColumn:@"Expand26"];
                model.Expand27=[set stringForColumn:@"Expand27"];
                model.Expand28=[set stringForColumn:@"Expand28"];
                model.Expand29=[set stringForColumn:@"Expand29"];
                model.Expand30=[set stringForColumn:@"Expand30"];
                
                
//                [arr addObject:model];
                
            }
        }
    }];
//    return  arr;
    return model;
    
}
//搜索所有产品信息
+ (NSMutableArray *)selectProductDetailTable
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    NSMutableArray * arr = [NSMutableArray array];
    
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
//            NSString * selectSignIn = [NSString stringWithFormat:@"select * from signIn where btnSelect like 'YES' and userID like '%@'",USER_ID];
//                        NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where btnSelect like 'NO' and userID like '%@'",USER_ID];
                                    NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where userID like '%@'",USER_ID];
            FMResultSet * set = [db executeQuery:selectSignIn];
            while ([set next])
            {
                ProductModel *model=[[ProductModel alloc]init];
                model.userID=[set stringForColumn:@"userID"];
                model.ProjectId=[set stringForColumn:@"ProjectId"];
                model.StoreId=[set stringForColumn:@"StoreId"];
                model.Code=[set stringForColumn:@"Code"];
                model.CreateDate=[set stringForColumn:@"CreateDate"];
                model.CreateUserId=[set stringForColumn:@"CreateUserId"];
                model.DiDui=[set stringForColumn:@"DiDui"];
                model.Area=[set stringForColumn:@"Area"];
                model.Position=[set stringForColumn:@"Position"];
                model.POSM=[set stringForColumn:@"POSM"];
                model.MDstate=[set stringForColumn:@"state"];
                model.ProductId=[set stringForColumn:@"ProductId"];
                model.Price=[set stringForColumn:@"Price"];
                model.ProductSmell=[set stringForColumn:@"ProductSmell"];
                
                model.AreaRatio=[set stringForColumn:@"AreaRatio"];
                
                model.Expand1=[set stringForColumn:@"Expand1"];
                model.Expand2=[set stringForColumn:@"Expand2"];
                model.Expand3=[set stringForColumn:@"Expand3"];
                model.Expand4=[set stringForColumn:@"Expand4"];
                model.Expand5=[set stringForColumn:@"Expand5"];
                model.Expand6=[set stringForColumn:@"Expand6"];
                model.Expand7=[set stringForColumn:@"Expand7"];
                model.Expand8=[set stringForColumn:@"Expand8"];
                model.Expand9=[set stringForColumn:@"Expand9"];
                model.Expand10=[set stringForColumn:@"Expand10"];
                model.Expand11=[set stringForColumn:@"Expand11"];
                model.Expand12=[set stringForColumn:@"Expand12"];
                model.Expand13=[set stringForColumn:@"Expand13"];
                model.Expand14=[set stringForColumn:@"Expand14"];
                model.Expand15=[set stringForColumn:@"Expand15"];
                model.Expand16=[set stringForColumn:@"Expand16"];
                model.Expand17=[set stringForColumn:@"Expand17"];
                model.Expand18=[set stringForColumn:@"Expand18"];
                model.Expand19=[set stringForColumn:@"Expand19"];
                model.Expand20=[set stringForColumn:@"Expand20"];
                model.Expand21=[set stringForColumn:@"Expand21"];
                model.Expand22=[set stringForColumn:@"Expand22"];
                model.Expand23=[set stringForColumn:@"Expand23"];
                model.Expand24=[set stringForColumn:@"Expand24"];
                model.Expand25=[set stringForColumn:@"Expand25"];
                model.Expand26=[set stringForColumn:@"Expand26"];
                model.Expand27=[set stringForColumn:@"Expand27"];
                model.Expand28=[set stringForColumn:@"Expand28"];



                
                
                [arr addObject:model];
  
            }
        }
    }];
    return  arr;

}
// 搜索签到信息
+ (NSMutableArray *)selectSginInTable
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    NSMutableArray * arr = [NSMutableArray array];
    
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            NSString * selectSignIn = [NSString stringWithFormat:@"select * from signIn where btnSelect like 'YES' and userID like '%@'",USER_ID];
            FMResultSet * set = [db executeQuery:selectSignIn];
            while ([set next])
            {
                signInModel * signIn        = [[signInModel alloc]init];
                //                signIn.userID               = [set stringForColumn:@"userID"];
                //                signIn.StoreCode            = [set stringForColumn:@"StoreCode"];
                //                signIn.identifier           = [set stringForColumn:@"identifier"];
                //                if ([[set stringForColumn:@"signLongitude"] isEqualToString:@"(null)"]) {
                //                    signIn.signLongitude = @"0.0";
                //                }else
                //                {
                //                    signIn.signLongitude = [set stringForColumn:@"signLongitude"];
                //                }
                //                signIn.signLatitude         = [set stringForColumn:@"signLatitude"];
                //                if ([[set stringForColumn:@"signLatitude"] isEqualToString:@"(null)"]) {
                //                    signIn.signLatitude = @"0.0";
                //                }else
                //                {
                //                    signIn.signLatitude = [set stringForColumn:@"signLatitude"];
                //                }
                //                if ([[set stringForColumn:@"signLocationType"] isEqualToString:@"(null)"]) {
                //                    signIn.signLocationType = @"0";
                //                }else
                //                {
                //                    signIn.signLocationType = [set stringForColumn:@"signLocationType"];
                //                }
                //
                //                if ([[set stringForColumn:@"signLocationTtime"] isEqualToString:@"(null)"]) {
                //                    signIn.signLocationTtime = @"0";
                //                }else
                //                {
                //                    signIn.signLocationTtime = [set stringForColumn:@"signLocationTtime"];
                //                }
                //                signIn.signInType           = [set stringForColumn:@"signInType"];
                //                signIn.signCreatetime       = [set stringForColumn:@"signCreatetime"];
                //
                //                if ([[set stringForColumn:@"signLongitude"] isEqualToString:@"(null)"]) {
                //                    signIn.signLongitude = @"0.0";
                //                }else
                //                {
                //                    signIn.signLongitude = [set stringForColumn:@"signLongitude"];
                //                }
                //                if ([[set stringForColumn:@"goOutLongitude"] isEqualToString:@"(null)"]) {
                //                    signIn.goOutLongitude = @"0.0";
                //                }else
                //                {
                //                    signIn.goOutLongitude = [set stringForColumn:@"goOutLongitude"];
                //                }
                //                if ([[set stringForColumn:@"goOutLatitude"] isEqualToString:@"(null)"]) {
                //                    signIn.goOutLatitude = @"0.0";
                //                }else
                //                {
                //                    signIn.goOutLatitude = [set stringForColumn:@"goOutLatitude"];
                //                }
                //
                //                if ([[set stringForColumn:@"goOutLocationType"] isEqualToString:@"(null)"]) {
                //                    signIn.goOutLocationType = @"0";
                //                }else
                //                {
                //                    signIn.goOutLocationType = [set stringForColumn:@"goOutLocationType"];
                //                }
                //                signIn.goOutLocationTtime   = [set stringForColumn:@"goOutLocationTtime"];
                //                signIn.goOutInType          = [set stringForColumn:@"goOutInType"];
                //                signIn.goOutCreatetime      = [set stringForColumn:@"goOutCreatetime"];
                //                signIn.storeName            = [set stringForColumn:@"storeName"];
                //                signIn.projectName          = [set stringForColumn:@"projectName"];
                //                signIn.btnSelect            = [set stringForColumn:@"btnSelect"];
                //                signIn.companyName          = [set stringForColumn:@"companyName"];
                //                [arr addObject:signIn];
                signIn.checkInImei = [set stringForColumn:@"checkInImei"];
                if ([[set stringForColumn:@"checkInLatitude"]isEqualToString:@"(null)"]) {
                    signIn.checkInLatitude = @"0.0";
                }else
                {
                    signIn.checkInLatitude = [set stringForColumn:@"checkInLatitude"];
                }
                if ([[set stringForColumn:@"checkInLocationTime"]isEqualToString:@"(null)"]) {
                    signIn.checkInLocationTime = @"0";
                }else
                {
                    signIn.checkInLocationTime = [set stringForColumn:@"checkInLocationTime"];
                }
                if ([[set stringForColumn:@"checkInLocationType"]isEqualToString:@"(null)"]) {
                    signIn.checkInLocationType = @"0";
                }else
                {
                    signIn.checkInLocationType = [set stringForColumn:@"checkInLocationType"];
                }
                if ([[set stringForColumn:@"checkInLongitude"]isEqualToString:@"(null)"]) {
                    signIn.checkInLongitude = @"0.0";
                }else
                {
                    signIn.checkInLongitude = [set stringForColumn:@"checkInLongitude"];
                }
                if ([[set stringForColumn:@"checkInTime"]isEqualToString:@"(null)"])
                {
                    signIn.checkInTime = @"0";
                }else
                {
                    signIn.checkInTime = [set stringForColumn:@"checkInTime"];
                }
                signIn.signInType = [set stringForColumn:@"signInType"];
                signIn.checkOutImei = [set stringForColumn:@"checkOutImei"];
                if ([[set stringForColumn:@"checkOutLatitude"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLatitude = @"0.0";
                }else
                {
                    signIn.checkOutLatitude = [set stringForColumn:@"checkOutLatitude"];
                }
                if ([[set stringForColumn:@"checkOutLocationTime"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLocationTime = @"0";
                }else
                {
                    signIn.checkOutLocationTime = [set stringForColumn:@"checkOutLocationTime"];
                }
                if ([[set stringForColumn:@"checkOutLocationType"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLocationType = @"0";
                }else
                {
                    signIn.checkOutLocationType = [set stringForColumn:@"checkOutLocationType"];
                }
                if ([[set stringForColumn:@"checkOutLongitude"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLongitude = @"0.0";
                }else
                {
                    signIn.checkOutLongitude = [set stringForColumn:@"checkOutLongitude"];
                }
                if ([[set stringForColumn:@"checkOutTime"]isEqualToString:@"(null)"]) {
                    signIn.checkOutTime = @"0";
                }else
                {
                    signIn.checkOutTime = [set stringForColumn:@"checkOutTime"];
                }
                signIn.goOutInType = [set stringForColumn:@"goOutInType"];
                if ([[set stringForColumn:@"companyCode"]isEqualToString:@"(null)"]) {
                    signIn.companyCode = @"";
                }else
                {
                    signIn.companyCode = [set stringForColumn:@"companyCode"];
                }
                if ([[set stringForColumn:@"itemCode"]isEqualToString:@"(null)"]) {
                    signIn.itemCode = @"";
                }else
                {
                    signIn.itemCode = [set stringForColumn:@"itemCode"];
                }
                if ([[set stringForColumn:@"storeCode"]isEqualToString:@"(null)"]) {
                    signIn.StoreCode = @"";
                }else
                {
                    signIn.StoreCode = [set stringForColumn:@"storeCode"];
                }
                signIn.userID = [set stringForColumn:@"userID"];
                signIn.storeName = [set stringForColumn:@"storeName"];
                signIn.projectName = [set stringForColumn:@"projectName"];
                signIn.btnSelect = [set stringForColumn:@"btnSelect"];
                signIn.companyName = [set stringForColumn:@"companyName"];
                [arr addObject:signIn];
                
            }
        }
    }];
    return arr;
}
// 存储照片信息
+ (void)keepPhotoWithDictionary:(NSDictionary *)photoInfo
{
    [self creatPhotoTable];
    NSString *userID = [photoInfo objectForKey:@"userID"];
    NSString *storeCode = [photoInfo objectForKey:@"storeCode"];
    NSString *selectType = [photoInfo objectForKey:@"selectType"];
    NSString *imageType = [photoInfo objectForKey:@"imageType"];
    NSString *identifier = [photoInfo objectForKey:@"identifier"];
    NSString *Longitude = [photoInfo objectForKey:@"Longitude"];
    NSString *Latitude = [photoInfo objectForKey:@"Latitude"];
    NSString *LocationTtime = [photoInfo objectForKey:@"LocationTtime"];
    NSString *Createtime = [photoInfo objectForKey:@"Createtime"];
    NSString *imageUrl = [photoInfo objectForKey:@"imageUrl"];
    NSString *imageID = [photoInfo objectForKey:@"imgID"];
    NSLog(@"%@",photoInfo);
    
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        
        if ([db open]) {
            
            NSString * insertPhotoStr = [NSString stringWithFormat:@"insert into photoInfo(userID,storeCode,identifier,selectType,imageType,Longitude,Latitude,LocationTtime,Createtime,imageUrl,imageID) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",userID,storeCode,identifier,selectType,imageType,Longitude,Latitude,LocationTtime,Createtime,imageUrl,imageID];
//            if ([db executeUpdate:insertPhotoStr]) {
//                NSLog(@"success");
//            }
//            else
//            {
//                NSLog(@"faiel");
//            }
            [db executeUpdate:insertPhotoStr];
        }
    }];
}
//存储详情
+ (void)keepDetailWithDictionary:(NSDictionary *)photoInfo
{
    [self creatDetailTable];
    NSString *userID = [photoInfo objectForKey:@"userID"];
    NSString *storeCode = [photoInfo objectForKey:@"storeCode"];
    NSString *selectType = [photoInfo objectForKey:@"selectType"];
    NSString *imageType = [photoInfo objectForKey:@"imageType"];
    NSString *identifier = [photoInfo objectForKey:@"identifier"];
    NSString *Longitude = [photoInfo objectForKey:@"Longitude"];
    NSString *Latitude = [photoInfo objectForKey:@"Latitude"];
    NSString *LocationTtime = [photoInfo objectForKey:@"LocationTtime"];
    NSString *Createtime = [photoInfo objectForKey:@"Createtime"];
    NSString *imageUrl = [photoInfo objectForKey:@"imageUrl"];
    
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        
        if ([db open]) {
            
            NSString * insertPhotoStr = [NSString stringWithFormat:@"insert into detail(userID,storeCode,identifier,selectType,imageType) values('%@','%@','%@','%@','%@')",userID,storeCode,identifier,selectType,imageType];
            [db executeUpdate:insertPhotoStr];
            if ([db executeUpdate:insertPhotoStr]) {
                NSLog(@"success");
            }
            else
            {
                NSLog(@"fail");
            }
            
        }
    }];
}
// 根据选的照片类型查询门店照片
+ (NSMutableArray *)selectPhotoWithType:(NSString *)selectType
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
//            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and userID like '%@'",selectType,USER_ID];
                        NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and userID like '%@'",selectType,USER_ID];
            FMResultSet * set = [db executeQuery:selectStr];
            while ([set next])
            {
                NSString * imageUrl = [set stringForColumn:@"imageurl"];
                [arr addObject:imageUrl];
            }
        }
        [db close];
    }];
    return arr;
}
// 根据选的照片类型查询产品照片
+ (NSMutableArray *)NewselectPhotoWithType:(NSString *)selectType andId:(NSString *)storecode
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            //            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and userID like '%@'",selectType,USER_ID];
            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType != '%@' and selectType != '%@' and userID like '%@'",@"dsr",@"qihua",USER_ID];
            FMResultSet * set = [db executeQuery:selectStr];
            while ([set next])
            {
                NSMutableDictionary *mydic=[[NSMutableDictionary alloc]init];
                //                NSString * imageUrl = [set stringForColumn:@"imageurl"];
                [mydic setValue:[set stringForColumn:@"userID"] forKey:@"userID"];
                [mydic setValue:[set stringForColumn:@"storeCode"] forKey:@"storeCode"];
                [mydic setValue:[set stringForColumn:@"selectType"] forKey:@"selectType"];
                [mydic setValue:[set stringForColumn:@"Longitude"] forKey:@"Longitude"];
                [mydic setValue:[set stringForColumn:@"Latitude"] forKey:@"Latitude"];
                [mydic setValue:[set stringForColumn:@"imageurl"] forKey:@"imageurl"];
                [mydic setValue:[set stringForColumn:@"imageID"] forKey:@"imgID"];
                [mydic setValue:[set stringForColumn:@"createTime"] forKey:@"createTime"];
                
                [arr addObject:mydic];
            }
        }
        [db close];
    }];
    return arr;
}
// 根据选的照片类型查询产品照片
+ (NSMutableArray *)selectPhotoWithType:(NSString *)selectType andId:(NSString *)storecode andCfgID:(NSString *)cfg
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            //            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and userID like '%@'",selectType,USER_ID];
            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and storecode = '%@' and imageID='%@' and userID like '%@'",selectType,storecode,cfg,USER_ID];
            FMResultSet * set = [db executeQuery:selectStr];
            while ([set next])
            {
                NSMutableDictionary *mydic=[[NSMutableDictionary alloc]init];
                //                NSString * imageUrl = [set stringForColumn:@"imageurl"];
                [mydic setValue:[set stringForColumn:@"userID"] forKey:@"userID"];
                [mydic setValue:[set stringForColumn:@"storeCode"] forKey:@"storeCode"];
                [mydic setValue:[set stringForColumn:@"selectType"] forKey:@"selectType"];
                [mydic setValue:[set stringForColumn:@"Longitude"] forKey:@"Longitude"];
                [mydic setValue:[set stringForColumn:@"Latitude"] forKey:@"Latitude"];
                [mydic setValue:[set stringForColumn:@"imageurl"] forKey:@"imageurl"];
                [mydic setValue:[set stringForColumn:@"imageID"] forKey:@"imgID"];
                [mydic setValue:[set stringForColumn:@"createTime"] forKey:@"createTime"];
                
                [arr addObject:mydic];
            }
        }
        [db close];
    }];
    return arr;
}
// 根据选的照片类型查询产品照片
+ (NSMutableArray *)selectPhotoWithType:(NSString *)selectType andId:(NSString *)storecode
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            //            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and userID like '%@'",selectType,USER_ID];
            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and storecode = '%@' and userID like '%@'",selectType,storecode,USER_ID];
            FMResultSet * set = [db executeQuery:selectStr];
            while ([set next])
            {
                NSMutableDictionary *mydic=[[NSMutableDictionary alloc]init];
                //                NSString * imageUrl = [set stringForColumn:@"imageurl"];
                [mydic setValue:[set stringForColumn:@"userID"] forKey:@"userID"];
                [mydic setValue:[set stringForColumn:@"storeCode"] forKey:@"storeCode"];
                [mydic setValue:[set stringForColumn:@"selectType"] forKey:@"selectType"];
                [mydic setValue:[set stringForColumn:@"Longitude"] forKey:@"Longitude"];
                [mydic setValue:[set stringForColumn:@"Latitude"] forKey:@"Latitude"];
                [mydic setValue:[set stringForColumn:@"imageurl"] forKey:@"imageurl"];
                [mydic setValue:[set stringForColumn:@"imageID"] forKey:@"imgID"];
                [mydic setValue:[set stringForColumn:@"createTime"] forKey:@"createTime"];
                
                [arr addObject:mydic];
            }
        }
        [db close];
    }];
    return arr;
}

//查询详情
+ (NSMutableArray *)selectDetailWithType:(NSString *)selectType
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            //            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and userID like '%@'",selectType,USER_ID];
            NSString * selectStr = [NSString stringWithFormat:@"select * from detail"];
            FMResultSet * set = [db executeQuery:selectStr];
            while ([set next])
            {
                NSString * imageUrl = [set stringForColumn:@"selectType"];
                [arr addObject:imageUrl];
            }
        }
        [db close];
    }];
    return arr;
}
// 保存卖进信息
+ (void)keepSellInfo:(NSMutableDictionary *)sellInfo withBlock:(void (^)(NSString *result))block;
{
    [self creatSellInfoTable];
    
    NSString *userID     = [sellInfo objectForKey:@"userID"];
    NSString *Name       = [sellInfo objectForKey:@"Name"];
    NSString *Phone      = [sellInfo objectForKey:@"Phone"];
    NSString *IdCard     = [sellInfo objectForKey:@"IdCard"];
    NSString *storeCode  = [sellInfo objectForKey:@"storeCode"];
    NSString *isSuccess  = [sellInfo objectForKey:@"isSuccess"];
    NSString *identifier = [sellInfo objectForKey:@"identifier"];
    NSString *Cretime    = [sellInfo objectForKey:@"Cretime"];
    FMDatabaseQueue * queue = [[FMDatabaseQueue alloc]initWithPath:[self getPath]];
    
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open]){
            NSString * insertPhotoStr = [NSString stringWithFormat:@"insert into sellInfo(userID,Name,Phone,IdCard,StoreCode,isSuccess,identifier,Cretime) values('%@','%@','%@','%@','%@','%@','%@','%@')",userID,Name,Phone,IdCard,storeCode,isSuccess,identifier,Cretime];
            if ([db executeUpdate:insertPhotoStr] == YES) {
                block(@"保存数据成功");
            }
        }
    }];
}
// 保存请假信息
+ (void)keepLeaveInfo:(NSMutableDictionary *)leaveInfo
{
    [self creatLeaveInfoTable];
    NSString * userID = [leaveInfo objectForKey:@"userID"];
    NSString * identifier = [leaveInfo objectForKey:@"identifier"];
    NSString * time     = [leaveInfo objectForKey:@"time"];
    NSString * QjType   = [leaveInfo objectForKey:@"QjType"];
    NSString * TimeType = [leaveInfo objectForKey:@"TimeType"];
    
    
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * insertStr = [NSString stringWithFormat:@"insert into leaveInfo(userID,identifier,time,QjType,TimeType) values('%@','%@','%@','%@','%@')",userID,identifier,time,QjType,TimeType];
        [db executeUpdate:insertStr];
    }
    [db close];
}
// 搜索请假信息
+ (NSMutableArray *)selectLeaveInfo
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabase * db = [self getDB];
    if ([db open]) {
        
        NSString * selectStr = [NSString stringWithFormat:@"select * from leaveInfo where userID like '%@'",USER_ID];
        FMResultSet * set = [db executeQuery:selectStr];
        while ([set next]) {
            LeaveModel * leave = [[LeaveModel alloc]init];
            leave.date = [set stringForColumn:@"time"];
            leave.time = [set stringForColumn:@"TimeType"];
            leave.reason = [set stringForColumn:@"QjType"];
            leave.identifier = [set stringForColumn:@"identifier"];
            leave.userID     = [set stringForColumn:@"userID"];
            [arr addObject:leave];
        }
    }
    [db close];
    
    return arr;
}
// 搜索卖进信息
+ (NSMutableArray *)selectSellTable
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabaseQueue * queue = [[FMDatabaseQueue alloc]initWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            NSString * selectSell = [NSString stringWithFormat:@"select * from sellInfo where userID like '%@'",USER_ID];
            FMResultSet * resultSet = [db executeQuery:selectSell];
            while ([resultSet next]) {
                SellModel * sell = [[SellModel alloc]init];
                sell.userID = [resultSet stringForColumn:@"userID"];
                sell.Name = [resultSet stringForColumn:@"Name"];
                sell.Phone = [resultSet stringForColumn:@"Phone"];
                sell.IdCard = [resultSet stringForColumn:@"IdCard"];
                sell.isSuccess = [resultSet stringForColumn:@"isSuccess"];
                sell.identifier = [resultSet stringForColumn:@"identifier"];
                sell.Cretime = [resultSet stringForColumn:@"Cretime"];
                sell.storeCode = [resultSet stringForColumn:@"StoreCode"];
                [arr addObject:sell];
            }
        }
        [db close];
    }];
    return arr;
}
// 删除卖进信息
+ (void)deleteSellTable
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * deleteStr = [NSString stringWithFormat:@"delete from sellInfo where userID like '%@'",USER_ID];
        [db executeUpdate:deleteStr];
    }
    [db close];
}
// 保存PG招募信息
+ (void)keepPGRecruit:(NSMutableDictionary *)PGInfo withBlock:(void (^)(NSString *result))block;
{
    [self creatPGRecruitTable];
    
    NSString *Headimgpath   = [PGInfo objectForKey:@"Headimgpath"];
    NSString *bodyImgPath   = [PGInfo objectForKey:@"bodyImgPath"];
    NSString *userID        = [PGInfo objectForKey:@"userID"];
    NSString *Name          = [PGInfo objectForKey:@"Name"];
    NSString *Phone         = [PGInfo objectForKey:@"Phone"];
    NSString *IdCard        = [PGInfo objectForKey:@"IdCard"];
    NSString *storeCode  = [PGInfo objectForKey:@"storeCode"];
    NSString *Weixin        = [PGInfo objectForKey:@"Weixin"];
    NSString *Qq            = [PGInfo objectForKey:@"Qq"];
    NSString *identifier    = [PGInfo objectForKey:@"identifier"];
    NSString *Createtime    = [PGInfo objectForKey:@"Createtime"];
    FMDatabaseQueue * queue = [[FMDatabaseQueue alloc]initWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open]){
            NSString * insertPhotoStr = [NSString stringWithFormat:@"insert into pgrecruit(userID,Name,Phone,IdCard,StoreCode,Weixin,Qq,identifier,Createtime,Headimgpath,bodyImgPath) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",userID,Name,Phone,IdCard,storeCode,Weixin,Qq,identifier,Createtime,Headimgpath,bodyImgPath];
            if ([db executeUpdate:insertPhotoStr] == YES) {
                block(@"已保存,请稍后尽量在WiFi状态下进行上传操作~");
            }
        }
    }];
}
// 搜索招募信息
+ (NSMutableArray *)selectPGRecruit
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabaseQueue * queue = [[FMDatabaseQueue alloc]initWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            NSString * selectStr = [NSString stringWithFormat:@"select * from pgrecruit where userID like '%@'",USER_ID];
            FMResultSet * resultSet = [db executeQuery:selectStr];
            while ([resultSet next]) {
                PGRecruitModel * PGRecruit = [[PGRecruitModel alloc]init];
                PGRecruit.Headimgpath = [resultSet stringForColumn:@"Headimgpath"];
                PGRecruit.bodyImgPath = [resultSet stringForColumn:@"bodyImgPath"];
                PGRecruit.userID = [resultSet stringForColumn:@"userID"];
                PGRecruit.Name = [resultSet stringForColumn:@"Name"];
                PGRecruit.Phone = [resultSet stringForColumn:@"Phone"];
                PGRecruit.IdCard = [resultSet stringForColumn:@"IdCard"];
                PGRecruit.Weixin = [resultSet stringForColumn:@"Weixin"];
                PGRecruit.Qq = [resultSet stringForColumn:@"Qq"];
                PGRecruit.identifier = [resultSet stringForColumn:@"identifier"];
                PGRecruit.Createtime = [resultSet stringForColumn:@"Createtime"];
                PGRecruit.storeCode=[resultSet stringForColumn:@"StoreCode"];
                PGRecruit.Latitude = @"0.0";
                PGRecruit.Longitude = @"0.0";
                PGRecruit.locationType = @"0";
                [arr addObject:PGRecruit];
            }
            [resultSet close];
        }
        [db close];
    }];
    return arr;
}
// 删除PG招募表
+ (void)deletePGRecruit
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        
        NSString * delete = [NSString stringWithFormat:@"delete from pgrecruit where userID like '%@'",USER_ID];
        [db executeUpdate:delete];
    }
    [db close];
}
// 删除产品信息
+ (void) deleteMDWithImageUrl:(NSString *)url
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        
        NSString * delete = [NSString stringWithFormat:@"delete from MDInfo where userID like '%@'",USER_ID];
        [db executeUpdate:delete];
    }
    [db close];
}
// 删除产品信息
+ (void) deleteProductWithImageUrl:(NSString *)url
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        
        NSString * delete = [NSString stringWithFormat:@"delete from storeInfo where userID like '%@'",USER_ID];
        [db executeUpdate:delete];
    }
    [db close];
}
// 删除巡店拍照信息
+ (void) deletePatrolPictureWithImageUrl:(NSString *)url
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        
        NSString * delete = [NSString stringWithFormat:@"delete from photoInfo where userID like '%@' and imageUrl like '%@'",USER_ID,url];
        [db executeUpdate:delete];
    }
    [db close];
}
+ (void)deletePhotoWithUrl:(NSString *)url successBlock:(void (^)(NSString * result))successBlock
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        
        NSString * delete = [NSString stringWithFormat:@"delete from photoInfo where imageUrl like '%@' and userID like'%@'",url,USER_ID];
        if ([db executeUpdate:delete] == YES ) {
            successBlock(@"OK");
        }
    }
    [db close];
}
// 查询巡店拍照信息
+ (NSMutableArray *)NewselectlPictureWithtype:(NSString *)type andWithID:(NSString *)code
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType ='%@' or selecttype='%@' and userID like '%@'",@"dsr",@"qihua",USER_ID];
        FMResultSet * resultSrt = [db executeQuery:selectStr];
        while ([resultSrt next]) {
            PhotoModel  * photo = [[PhotoModel alloc]init];
            photo.userID        = [resultSrt stringForColumn:@"userID"];
            if ([[resultSrt stringForColumn:@"Longitude"] isEqualToString:@"(null)"]) {
                photo.Longitude          = @"0.0";
            }else
            {
                photo.Longitude          = [resultSrt stringForColumn:@"Longitude"];
            }
            if ([[resultSrt stringForColumn:@"Latitude"] isEqualToString:@"(null)"]) {
                photo.Latitude          = @"0.0";
            }else
            {
                photo.Latitude          = [resultSrt stringForColumn:@"Latitude"];
            }
            if ([[resultSrt stringForColumn:@"LocationTtime"] isEqualToString:@"(null)"]) {
                NSDate * date = [NSDate date];
                NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                NSString *timestamo = [formatter stringFromDate:date];
                photo.LocationTtime          = timestamo;
            }
            else
            {
                photo.LocationTtime          =[resultSrt stringForColumn:@"LocationTtime"];
            }
            photo.imageUrl              = [resultSrt stringForColumn:@"imageUrl"];
            photo.selectType            = [resultSrt stringForColumn:@"selectType"];
            photo.storeCode             = [resultSrt stringForColumn:@"storeCode"];
            photo.identifier            = [resultSrt stringForColumn:@"identifier"];
            photo.Createtime            = [resultSrt stringForColumn:@"Createtime"];
            photo.imgID            = [resultSrt stringForColumn:@"imageID"];
            [arr addObject:photo];
        }
    }
    [db close];
    return arr;
}
// 查询巡店拍照信息
+ (NSMutableArray *)selectlPictureWithtype:(NSString *)type andWithID:(NSString *)code
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType ='%@' and storecode = '%@' and userID like '%@'",type,code,USER_ID];
        FMResultSet * resultSrt = [db executeQuery:selectStr];
        while ([resultSrt next]) {
            PhotoModel  * photo = [[PhotoModel alloc]init];
            photo.userID        = [resultSrt stringForColumn:@"userID"];
            if ([[resultSrt stringForColumn:@"Longitude"] isEqualToString:@"(null)"]) {
                photo.Longitude          = @"0.0";
            }else
            {
                photo.Longitude          = [resultSrt stringForColumn:@"Longitude"];
            }
            if ([[resultSrt stringForColumn:@"Latitude"] isEqualToString:@"(null)"]) {
                photo.Latitude          = @"0.0";
            }else
            {
                photo.Latitude          = [resultSrt stringForColumn:@"Latitude"];
            }
            if ([[resultSrt stringForColumn:@"LocationTtime"] isEqualToString:@"(null)"]) {
                NSDate * date = [NSDate date];
                NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                NSString *timestamo = [formatter stringFromDate:date];
                photo.LocationTtime          = timestamo;
            }
            else
            {
                photo.LocationTtime          =[resultSrt stringForColumn:@"LocationTtime"];
            }
            photo.imageUrl              = [resultSrt stringForColumn:@"imageUrl"];
            photo.selectType            = [resultSrt stringForColumn:@"selectType"];
            photo.storeCode             = [resultSrt stringForColumn:@"storeCode"];
            photo.identifier            = [resultSrt stringForColumn:@"identifier"];
            photo.Createtime            = [resultSrt stringForColumn:@"Createtime"];
            [arr addObject:photo];
        }
    }
    [db close];
    return arr;
}
// 查询填报拍照信息
+ (NSMutableArray *)selectPatrolPictureWithID:(NSString *)code
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where storecode = '%@' and userID like '%@'",code,USER_ID];
        FMResultSet * resultSrt = [db executeQuery:selectStr];
        while ([resultSrt next]) {
            PhotoModel  * photo = [[PhotoModel alloc]init];
            photo.userID        = [resultSrt stringForColumn:@"userID"];
            if ([[resultSrt stringForColumn:@"Longitude"] isEqualToString:@"(null)"]) {
                photo.Longitude          = @"0.0";
            }else
            {
                photo.Longitude          = [resultSrt stringForColumn:@"Longitude"];
            }
            if ([[resultSrt stringForColumn:@"Latitude"] isEqualToString:@"(null)"]) {
                photo.Latitude          = @"0.0";
            }else
            {
                photo.Latitude          = [resultSrt stringForColumn:@"Latitude"];
            }
            if ([[resultSrt stringForColumn:@"LocationTtime"] isEqualToString:@"(null)"]) {
                NSDate * date = [NSDate date];
                NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                NSString *timestamo = [formatter stringFromDate:date];
                photo.LocationTtime          = timestamo;
            }
            else
            {
                photo.LocationTtime          =[resultSrt stringForColumn:@"LocationTtime"];
            }
            photo.imageUrl              = [resultSrt stringForColumn:@"imageUrl"];
            photo.selectType            = [resultSrt stringForColumn:@"selectType"];
            photo.storeCode             = [resultSrt stringForColumn:@"storeCode"];
            photo.identifier            = [resultSrt stringForColumn:@"identifier"];
            photo.Createtime            = [resultSrt stringForColumn:@"Createtime"];
            [arr addObject:photo];
        }
    }
    [db close];
    return arr;
}
// 保存门店定位信息
+ (void)keepStoreLocationInfo:(NSMutableDictionary *)dic
{
    [self creatStoreLocationTable];
    
    NSString *identifier            = [dic objectForKey:@"identifier"];
    NSString *StoreId               = [dic objectForKey:@"StoreId"];
    NSString *userID                = [dic objectForKey:@"userID"];
    NSString *LocationType          = [dic objectForKey:@"LocationType"];
    NSString *LocationTtime         = [dic objectForKey:@"LocationTtime"];
    NSString *Latitude              = [dic objectForKey:@"Latitude"];
    NSString *Longitude             = [dic objectForKey:@"Longitude"];
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * insertStoreLocationStr = [NSString stringWithFormat:@"insert into storeLocation(identifier,StoreId,userID,LocationType,LocationTtime,Latitude,Longitude) values('%@','%@','%@','%@','%@','%@','%@')",identifier,StoreId,userID,LocationType,LocationTtime,Latitude,Longitude];
        [db executeUpdate:insertStoreLocationStr];
    }
    [db close];
}
// 删除签到信息
+ (void)deleteSignInTable
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * deleteStr = [NSString stringWithFormat:@"delete from signIn where userID like '%@'",USER_ID];
        [db executeUpdate:deleteStr];
    }
    [db close];
}
// 删除请假信息
+ (void)deleteLeaveWithTime:(NSString *)time timeType:(NSString *)timeType QjType:(NSString *)QjType
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * deleteStr = [NSString stringWithFormat:@"delete from leaveInfo where userID like '%@' and time like '%@' and timeType like '%@' and QjType like '%@'",USER_ID,time,timeType,QjType];
        [db executeUpdate:deleteStr];
    }
    [db close];
}
// 上传成功后删除请假表
+ (void)deleteLeaveTable
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * deleteStr = [NSString stringWithFormat:@"delete from leaveInfo where userID like '%@'",USER_ID];
        [db executeUpdate:deleteStr];
    }
    [db close];
    
}

+(FMDatabase * )getDB
{
    FMDatabase *  db = [[FMDatabase alloc]initWithPath:[self getPath]];
    return db ;
}

+(NSString *)getPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/SignIn.sqlite"];
}



//存储公司信息
+ (void)insertCompanyTableWithTheDictionary:(NSDictionary *)CompanyDic
{
    [self creatCompanyTable];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    
    //使用
    [queue inDatabase:^(FMDatabase *db){
        
        NSString *Address = [CompanyDic objectForKey:@"Address"];
        NSString *Latitude = [CompanyDic objectForKey:@"Latitude"];
        NSString *Longitude = [CompanyDic objectForKey:@"Longitude"];
        NSString *companyName = [CompanyDic objectForKey:@"companyName"];
        NSString *ID = [CompanyDic objectForKey:@"ID"];
        NSString *ProjectID = [CompanyDic objectForKey:@"ProjectID"];
        NSString *ProjectName = [CompanyDic objectForKey:@"ProjectName"];
        
        if ([db open]) {
            NSString * insertString = [NSString stringWithFormat:@"insert into Company (Address,companyLatitude,companyLongitude,companyName,ID,ProjectID,ProjectName)valuse('%@','%@','%@','%@','%@','%@','%@')",Address,Latitude,Longitude,companyName,ID,ProjectID,ProjectName];
            [db executeUpdate:insertString];
        }
        [db close];
    }];
}

//上传成功后删除公司信息
+ (void)deleteCompanyTable
{
    FMDatabase *db = [self getDB];
    if ([db open]) {
        NSString *deleteStr = [NSString stringWithFormat:@"dete from company where userId like '%@'",USER_ID];
        [db executeUpdate:deleteStr];
    }
    [db close];
}


@end
