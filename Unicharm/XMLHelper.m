//
//  XMLHelper.m
//  Essence
//
//  Created by EssIOS on 15/5/8.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "XMLHelper.h"
#import "JSONKit.h"
@implementation XMLHelper
+ (NSString * )uploadPicXmlChangeJsonStr:(NSString *)xmlString
{
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:xmlString error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoginResponse = [soapBody objectForKey:@"UploadPicResponse"];
    
    NSDictionary * LoginResult = [LoginResponse objectForKey:@"UploadPicResult"];
    
    NSString * textData = [LoginResult objectForKey:@"text"];
    
    return textData;
}
+ (NSString * )kpiTypeXmlChangeJsonStr:(NSString *)xmlString
{
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:xmlString error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoginResponse = [soapBody objectForKey:@"GetStoreKpiResponse"];
    
    NSDictionary * LoginResult = [LoginResponse objectForKey:@"GetStoreKpiResult"];
    
    NSString * textData = [LoginResult objectForKey:@"text"];
    
    return textData;
}

+ (NSString * )photoTypeXmlChangeJsonStr:(NSString *)xmlString
{
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:xmlString error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoginResponse = [soapBody objectForKey:@"GetImgTypesResponse"];
    
    NSDictionary * LoginResult = [LoginResponse objectForKey:@"GetImgTypesResult"];
    
    NSString * textData = [LoginResult objectForKey:@"text"];
    
    return textData;
}
+ (NSString * )signinXmlChangeJsonStr:(NSString *)xmlString
{
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:xmlString error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoginResponse = [soapBody objectForKey:@"SignInResponse"];
    
    NSDictionary * LoginResult = [LoginResponse objectForKey:@"SignInResult"];
    
    NSString * textData = [LoginResult objectForKey:@"text"];
    
    return textData;
}

+ (NSString * )signoutXmlChangeJsonStr:(NSString *)xmlString
{
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:xmlString error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoginResponse = [soapBody objectForKey:@"CheckOutResponse"];
    
    NSDictionary * LoginResult = [LoginResponse objectForKey:@"CheckOutResult"];
    
    NSString * textData = [LoginResult objectForKey:@"text"];
    
    return textData;
}
+ (NSString * )loginXmlChangeJsonStr:(NSString *)xmlString
{
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:xmlString error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoginResponse = [soapBody objectForKey:@"LoginResponse"];
    
    NSDictionary * LoginResult = [LoginResponse objectForKey:@"LoginResult"];
    
    NSString * textData = [LoginResult objectForKey:@"text"];

    return textData;
}
+ (NSString * )XmlChangeJsonStr:(NSString *)xmlString
{
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:xmlString error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoginResponse = [soapBody objectForKey:@"GetStoreListResponse"];
    
    NSDictionary * LoginResult = [LoginResponse objectForKey:@"GetStoreListResult"];
    
    NSString * textData = [LoginResult objectForKey:@"text"];
    
    return textData;
}
+ (NSString * )StoreXmlChangeJsonStr:(NSString *)xmlString
{
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:xmlString error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoginResponse = [soapBody objectForKey:@"GetStoreListResponse"];
    
    NSDictionary * LoginResult = [LoginResponse objectForKey:@"GetStoreListResult"];
    
    NSString * textData = [LoginResult objectForKey:@"text"];
    
    return textData;
}
+ (NSString * )UploadXmlChangeJsonStr:(NSString *)xmlString
{
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:xmlString error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoginResponse = [soapBody objectForKey:@"UploadDataResponse"];
    
    NSDictionary * LoginResult = [LoginResponse objectForKey:@"UploadDataResult"];
    
    NSString * textData = [LoginResult objectForKey:@"text"];
    
    return textData;
}
+ (NSString * )UploadPOPXmlChangeJsonStr:(NSString *)xmlString
{
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:xmlString error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoginResponse = [soapBody objectForKey:@"UploadPopResponse"];
    
    NSDictionary * LoginResult = [LoginResponse objectForKey:@"UploadPopResult"];
    
    NSString * textData = [LoginResult objectForKey:@"text"];
    
    return textData;
}
+ (NSString * )UploadPicXmlChangeJsonStr:(NSString *)xmlString
{
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:xmlString error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoginResponse = [soapBody objectForKey:@"UploadPicResponse"];
    
    NSDictionary * LoginResult = [LoginResponse objectForKey:@"UploadPicResult"];
    
    NSString * textData = [LoginResult objectForKey:@"text"];
    
    return textData;
}
+ (NSString * )UploadPOPPicXmlChangeJsonStr:(NSString *)xmlString
{
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:xmlString error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoginResponse = [soapBody objectForKey:@"UploadPopPicResponse"];
    
    NSDictionary * LoginResult = [LoginResponse objectForKey:@"UploadPopPicResult"];
    
    NSString * textData = [LoginResult objectForKey:@"text"];
    
    return textData;
}
+ (NSString * )getSingleXmlChangeJsonStr:(NSString *)xmlString
{
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:xmlString error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoginResponse = [soapBody objectForKey:@"GetSignInfoResponse"];
    
    NSDictionary * LoginResult = [LoginResponse objectForKey:@"GetSignInfoResult"];
    
    NSString * textData = [LoginResult objectForKey:@"text"];
    
    return textData;
}
+ (BOOL)isFirstUse{
    NSDictionary * bundle = [[NSBundle mainBundle] infoDictionary];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"currnVerson"] == nil)
    {
        NSString * currnVerson = [bundle objectForKey:@"CFBundleShortVersionString"];
        [[NSUserDefaults standardUserDefaults] setObject:currnVerson forKey:@"currnVerson"];
        return YES;
    }
    else
    {
        return NO;
    }
}

//+ (NSString *)XMLBaseDataWithTheXML:(NSString *)baseDataXML
//{
//    
//    NSError * error = nil;
//    
//    NSDictionary * dic = [XMLReader dictionaryForXMLString:baseDataXML error:&error];
//    
//    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
//    
//    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
//    
//    NSDictionary * LoadProjectDataResponse = [soapBody objectForKey:@"LoadProjectData3Response"];
//    
//    NSDictionary * LoadProjectDataResult = [LoadProjectDataResponse objectForKey:@"LoadProjectData3Result"];
//    
//    NSString * textData = [LoadProjectDataResult objectForKey:@"text"];
//    
//    NSDictionary * textDic = [XMLReader dictionaryForXMLString:textData error:&error];
//    NSData * data = [NSJSONSerialization dataWithJSONObject:textDic options:NSJSONWritingPrettyPrinted error:&error];
//    
//    NSString * json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//   
//
//    return json;
//}
+ (NSString *)XMLBaseDataWithTheXML:(NSString *)baseDataXML
{
    
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:baseDataXML error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoadProjectDataResponse = [soapBody objectForKey:@"LoadProjectData5Response"];
    
    NSDictionary * LoadProjectDataResult = [LoadProjectDataResponse objectForKey:@"LoadProjectData5Result"];
    
    NSString * textData = [LoadProjectDataResult objectForKey:@"text"];
    
//    NSDictionary * textDic = [XMLReader dictionaryForXMLString:textData error:&error];
//    NSData * data = [NSJSONSerialization dataWithJSONObject:textDic options:NSJSONWritingPrettyPrinted error:&error];
//    
//    NSString * json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    
//    
//    return json;
    if ([textData isEqualToString:@"0"]) {
        return @"0";
    }
    else
    {
        //        NSDictionary * textDic = [XMLReader dictionaryForXMLString:textData error:&error];
        //        NSData * data = [NSJSONSerialization dataWithJSONObject:textDic options:NSJSONWritingPrettyPrinted error:&error];
        //
        //        NSString * json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //
        //
        //        return json;
        return textData;
    }
}
+ (NSString *)XMLUpDataWithTheXML:(NSString *)upDataXML
{
    NSError * error = nil;
    NSDictionary * dic = [XMLReader dictionaryForXMLString:upDataXML error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoadProjectDataResponse = [soapBody objectForKey:@"LoadProjectDataResponse"];
    
    NSDictionary * LoadProjectDataResult = [LoadProjectDataResponse objectForKey:@"LoadProjectDataResult"];
    
    NSString * textData = [LoadProjectDataResult objectForKey:@"text"];
    if (![textData isEqualToString:@"0"])
    {
        NSDictionary * textDic = [XMLReader dictionaryForXMLString:textData error:&error];
        NSData * data = [NSJSONSerialization dataWithJSONObject:textDic options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString * json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        return json;
    }
    else
    {
        return textData;
    }
}


//+ (NSString *)XMLBasecompanyWithTheXML:(NSString *)companyXML
//{
//    NSError * error = nil;
//    
//    NSDictionary *dic = [XMLReader dictionaryForXMLString:companyXML error:&error];
//    
//    NSDictionary *soapEnvelope = [dic  objectForKey:@"soap:Envelope"];
//    
//    NSDictionary *soapBody = [soapEnvelope objectForKey:@"soap:Body"];
//    
//    NSDictionary *getCompanysResponse = [soapBody objectForKey:@"GetCompanysResponse"];
//    
//    NSDictionary *getCompanysResult = [getCompanysResponse objectForKey:@"GetCompanysResult"];
//    
//    NSString *textData = [getCompanysResult objectForKey:@"text"];
//    
//    NSDictionary *textDic = [XMLReader dictionaryForXMLString:textData error:&error];
//    
//    NSLog(@"%@",textDic);
//    
//    
//    NSData *data = [NSJSONSerialization dataWithJSONObject:textDic options:NSJSONWritingPrettyPrinted error:&error];
//    
//    NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    
//    return json;
//
//}
+ (NSString *)XMLBasecompanyWithTheXML:(NSString *)companyXML
{
    NSError * error = nil;
    
    NSDictionary *dic = [XMLReader dictionaryForXMLString:companyXML error:&error];
    
    NSDictionary *soapEnvelope = [dic  objectForKey:@"soap:Envelope"];
    
    NSDictionary *soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary *getCompanysResponse = [soapBody objectForKey:@"GetCompanysResponse"];
    
    NSDictionary *getCompanysResult = [getCompanysResponse objectForKey:@"GetCompanysResult"];
    
    NSString *textData = [getCompanysResult objectForKey:@"text"];
    
    NSDictionary *textDic = [XMLReader dictionaryForXMLString:textData error:&error];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:textDic options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return json;
    
}
+(NSDictionary *)XMLUpCompanyWithTheXML:(NSString *)UpcompanyXML
{
    NSError *error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:UpcompanyXML error:&error];
    
    NSDictionary * soapEnveloope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnveloope objectForKey:@"soap:Body"];
    
    NSDictionary * getCompanyResponse = [soapBody objectForKey:@"GetCompanysResponse"];
    
    NSDictionary * getCompanyResult = [getCompanyResponse objectForKey:@"GetCompanysResult"];
    
    NSString * textData = [getCompanyResult objectForKey:@"text"];
    NSLog(@"%@",textData);
    NSLog(@"%@",[textData class]);

    NSError *err;
    NSData *jsonData = [textData dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];

        return dic1;

}
//处理用户是否制定计划 xml转json
+(NSString *)CanEditWorkPlanWithXML:(NSString *)UpcompanyXML
{
    NSError *error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:UpcompanyXML error:&error];
    
    NSDictionary * soapEnveloope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnveloope objectForKey:@"soap:Body"];
    
    NSDictionary * getCompanyResponse = [soapBody objectForKey:@"CanEditWorkPlanResponse"];
    
    NSDictionary * getCompanyResult = [getCompanyResponse objectForKey:@"CanEditWorkPlanResult"];
    
    NSString * textData = [getCompanyResult objectForKey:@"text"];
    NSLog(@"%@",textData);
    NSLog(@"%@",[textData class]);
    
    return  textData;

    
}
//获取用户管辖的门店
+(NSString *)GetUserStore:(NSString *)UpcompanyXML
{
    NSError *error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:UpcompanyXML error:&error];
    
    NSDictionary * soapEnveloope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnveloope objectForKey:@"soap:Body"];
    
    NSDictionary * getCompanyResponse = [soapBody objectForKey:@"GetUserStoreResponse"];
    
    NSDictionary * getCompanyResult = [getCompanyResponse objectForKey:@"GetUserStoreResult"];
    
    NSString * textData = [getCompanyResult objectForKey:@"text"];
//    NSLog(@"textData-->%@",textData);
    NSLog(@"%@",[textData class]);
    
    return  textData;
    
    
}
//获取工作计划
+(NSString *)GetWorkPlan:(NSString *)UpcompanyXML
{
    NSError *error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:UpcompanyXML error:&error];
    
    NSDictionary * soapEnveloope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnveloope objectForKey:@"soap:Body"];
    
    NSDictionary * getCompanyResponse = [soapBody objectForKey:@"GetWorkPlanResponse"];
    
    NSDictionary * getCompanyResult = [getCompanyResponse objectForKey:@"GetWorkPlanResult"];
    
    NSString * textData = [getCompanyResult objectForKey:@"text"];
    NSLog(@"%@",textData);
    NSLog(@"%@",[textData class]);
    
    return  textData;
    
    
}

@end
