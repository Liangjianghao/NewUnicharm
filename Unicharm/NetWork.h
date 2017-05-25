//
//  NetWork.h
//  Unicharm
//
//  Created by EssIOS on 16/8/5.
//  Copyright © 2016年 ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWork : NSObject
+ (void)loginWithLoginName:(NSString *)loginName password:(NSString *)password
                 withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock;
+ (void)getBaseDataWithDic:(NSDictionary *)dic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock;

+ (void)UploadDataDataWithDic:(NSMutableArray *)dataArr withAddress:(NSString *)str withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock;

+ (void)UploadPOPDataDataWithDic:(NSDictionary *)dic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock;

//+ (void)UploadPicWithDic:(NSMutableDictionary *)dic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock;

+ (void)UploadPOPPicWithDic:(NSMutableDictionary *)dic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock;

+ (void)getSingleProDataWithDic:(NSDictionary *)dic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock;
+ (void)getStoreDataWithDic:(NSDictionary *)dic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock;

+ (void)uploadSignOutwithDic:(NSDictionary *)dataDic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock;

+ (void)uploadSignInwithDic:(NSDictionary *)dataDic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock;
+ (void)getPhotoTypleWithDic:(NSDictionary *)dataDic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock;
+ (void)getKPITypleWithDic:(NSDictionary *)dataDic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock;
+ (void)uploadPhotoWithDic:(NSMutableDictionary *)dataDic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock;

+ (void)UploadPicWithDic:(NSMutableDictionary *)dic withAddress:(NSString *)str withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock;
@end
