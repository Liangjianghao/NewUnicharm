//
//  XMLHelper.h
//  Essence
//
//  Created by EssIOS on 15/5/8.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLReader.h"
#import "JSONKit.h"
@interface XMLHelper : NSObject
// 解析登陆返回的xml
+ (NSString *)loginXmlChangeJsonStr:(NSString *)xmlString;
// 解析获取基础数据返回的xml
+ (NSString *)XMLBaseDataWithTheXML:(NSString *)baseDataXML;
// 解析更新基础数据返回的xml
+ (NSString *)XMLUpDataWithTheXML:(NSString *)upDataXML;
//用户是否制定计划
+(NSString *)CanEditWorkPlanWithXML:(NSString *)UpcompanyXML;
//获取用户管辖的门店
+(NSString *)GetUserStore:(NSString *)UpcompanyXML;
//获取工作计划
+(NSString *)GetWorkPlan:(NSString *)UpcompanyXML;
// 是否是第一次登陆
+ (BOOL)isFirstUse;



+ (NSString *)XMLBasecompanyWithTheXML:(NSString *)companyXML;

+ (NSDictionary *)XMLUpCompanyWithTheXML:(NSString *)UpcompanyXML;

+ (NSString * )XmlChangeJsonStr:(NSString *)xmlString;
+ (NSString * )UploadXmlChangeJsonStr:(NSString *)xmlString;
+ (NSString * )UploadPicXmlChangeJsonStr:(NSString *)xmlString;
+ (NSString * )getSingleXmlChangeJsonStr:(NSString *)xmlString;
+ (NSString * )StoreXmlChangeJsonStr:(NSString *)xmlString;
+ (NSString * )UploadPOPXmlChangeJsonStr:(NSString *)xmlString;
+ (NSString * )UploadPOPPicXmlChangeJsonStr:(NSString *)xmlString;
+ (NSString * )signoutXmlChangeJsonStr:(NSString *)xmlString;

+ (NSString * )signinXmlChangeJsonStr:(NSString *)xmlString;

+ (NSString * )kpiTypeXmlChangeJsonStr:(NSString *)xmlString;
+ (NSString * )photoTypeXmlChangeJsonStr:(NSString *)xmlString;

+ (NSString * )uploadPicXmlChangeJsonStr:(NSString *)xmlString;

@end
