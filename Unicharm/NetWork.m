//
//  NetWork.m
//  Unicharm
//
//  Created by EssIOS on 16/8/5.
//  Copyright © 2016年 ljh. All rights reserved.
//
#define SERVERS_IP  @"http://pm.essenceimc.com"
#define SERVER_INTERFACES  @"%@/Service/android/User.asmx"

#define SERVERS_COMPANY @"%@/Service/appwebservice.asmx"
//#define AFAddress @"http://192.168.60.50/ynj/service/AppWebService.asmx"
//#define AFAddress @"http://unicharm.egocomm.cn/service/appwebservice.asmx"
//#define AFAddress @"http://unicharm.egocomm.cn/service/AppWebServiceDSR.asmx"
//#define AFAddress @"http://192.168.60.50/ynj/service/AppWebServicedsr.asmx"

//#define AFAddress @"http://192.168.60.50/ynj/service/AppWebService2.asmx"
#define AFAddress @"http://unicharm.egocomm.cn/service/AppWebService2.asmx"


//#define AFAddress @"http://192.168.60.50/ynj/service/AppWebServiceDSR.asmx"

//#define AFAddress @"http://192.168.60.50/ynj/service/AppWebService.asmx"

#import "AFNetworking.h"
#import "NetWork.h"
#import "XMLHelper.h"
@implementation NetWork
//上传照片
+ (void)uploadPhotoWithDic:(NSMutableDictionary *)dataDic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    UIImage *newimage=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),[dataDic objectForKey:@"base64Str"]]];
    //    NSString *path=[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),photo.imageUrl];
    NSData * Imagedata = UIImageJPEGRepresentation(newimage, 0.5f);
    
    NSString * _encodedImageStr=[Imagedata base64EncodedStringWithOptions:0];
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<UploadPic xmlns=\"http://tempuri.org/\">\n"
                          "<userid>%@</userid>\n"
                          "<storeid>%@</storeid>\n"
                          "<imgtype>%@</imgtype>\n"
                          "<lng>%@</lng>\n"
                          "<lat>%@</lat>\n"
                          "<createTime>%@</createTime>\n"
                          "<base64Str>%@</base64Str>\n"
                          "</UploadPic>\n"
                          "</soap:Body>\n"
                          "</soap:Envelope>\n",[dataDic objectForKey:@"userid"],[dataDic objectForKey:@"storeid"],[dataDic objectForKey:@"imgtype"],[dataDic objectForKey:@"lng"],[dataDic objectForKey:@"lat"],
                          [dataDic objectForKey:@"createTime"],
                          _encodedImageStr
                          ];
    
    NSString *baseApiURL = [NSString stringWithFormat:AFAddress];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/UploadPic" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"soap\n%@",soapBody);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        
        //        NSLog(@"Str-->%@",operation.responseString);
        NSString * loginResult = [XMLHelper uploadPicXmlChangeJsonStr:operation.responseString];
        //
        //        NSLog(@"Result-->>\n%@",loginResult);
        NSError *error;
        NSData *data = [loginResult   dataUsingEncoding:NSUTF8StringEncoding];
        id dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        //        NSLog(@"dic-->>%@",dic);
        //        NSLog(@"%@",[dic objectForKey:@"Data"]);
        
        
        block(dic,operation.error);
        
        //        block([dic objectForKey:@"ErrorCode"],nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failedBlock(@"上传照片失败",error);
        
    }];
    [operation start];
    [operation waitUntilFinished];
}
//获取照片类型
+ (void)getPhotoTypleWithDic:(NSDictionary *)dataDic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<GetImgTypes xmlns=\"http://tempuri.org/\">\n"
                          "</GetImgTypes>\n"
                          "</soap:Body>\n"
                          "</soap:Envelope>\n"
                          ];
    
    NSString *baseApiURL = [NSString stringWithFormat:AFAddress];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/GetImgTypes" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"soap\n%@",soapBody);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        
//        NSLog(@"Str-->%@",operation.responseString);
        NSString * loginResult = [XMLHelper photoTypeXmlChangeJsonStr:operation.responseString];
        //
//        NSLog(@"Result-->>\n%@",loginResult);
        NSError *error;
        NSData *data = [loginResult   dataUsingEncoding:NSUTF8StringEncoding];
        id dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//        NSLog(@"dic-->>%@",dic);
//        NSLog(@"%@",[dic objectForKey:@"Data"]);
        
        
        block(dic,operation.error);
        
        //        block([dic objectForKey:@"ErrorCode"],nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failedBlock(@"获取照片类型失败",error);
        
    }];
    [operation start];
    [operation waitUntilFinished];
}
//获取KPI类型
+ (void)getKPITypleWithDic:(NSDictionary *)dataDic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<GetStoreKpi xmlns=\"http://tempuri.org/\">\n"
                          "<storeid>%@</storeid>\n"
                          "<kpiid>%@</kpiid>\n"
//                          "<lng>%@</lng>\n"
//                          "<lat>%@</lat>\n"
                          "</GetStoreKpi>\n"
                          "</soap:Body>\n"
                          "</soap:Envelope>\n",[dataDic objectForKey:@"storeid"],@"0"
                          ];
    
    NSString *baseApiURL = [NSString stringWithFormat:AFAddress];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/GetStoreKpi" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"soap\n%@",soapBody);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        
//        NSLog(@"Str-->%@",operation.responseString);
        NSString * loginResult = [XMLHelper kpiTypeXmlChangeJsonStr:operation.responseString];
        //
//        NSLog(@"Result-->>\n%@",loginResult);
        NSError *error;
        NSData *data = [loginResult   dataUsingEncoding:NSUTF8StringEncoding];
        id dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//        NSLog(@"dic-->>%@",dic);
//        NSLog(@"%@",[dic objectForKey:@"Data"]);
        
        
        block(dic,operation.error);
        
        //        block([dic objectForKey:@"ErrorCode"],nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failedBlock(@"获取kpi类型失败",error);
        
    }];
    [operation start];
    [operation waitUntilFinished];
}
//上传签到信息验证
+ (void)uploadSignInwithDic:(NSMutableDictionary *)dataDic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<SignIn xmlns=\"http://tempuri.org/\">\n"
                          "<userid>%@</userid>\n"
//                          "<cfgID>%@</cfgID>\n"
                          "<lng>%@</lng>\n"
                          "<lat>%@</lat>\n"
                          "<storeid>%@</storeid>\n"
                          "<base64Str>%@</base64Str>\n"
                          "</SignIn>\n"
                          "</soap:Body>\n"
                          "</soap:Envelope>\n", [dataDic objectForKey:@"userid"],
                          
//                          @"2782",
                          [dataDic objectForKey:@"lng"],[dataDic objectForKey:@"lat"],[dataDic objectForKey:@"storeID"],[dataDic objectForKey:@"base64Str"]
                          ];
    
    NSString *baseApiURL = [NSString stringWithFormat:AFAddress];
//    NSString *baseApiURL = [NSString stringWithFormat:@"http://192.168.60.50/ynj/service/AppWebServicedsr.asmx"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/SignIn" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"soapSup\n%@",soapBody);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        NSString * loginResult = [XMLHelper signinXmlChangeJsonStr:operation.responseString];
        
//        NSLog(@"Str-->%@",operation.responseString);
//        NSLog(@"Result-->>\n%@",loginResult);
        NSError *error;
        NSData *data = [loginResult   dataUsingEncoding:NSUTF8StringEncoding];
        id dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//        NSLog(@"dic-->>%@",dic);
//        NSLog(@"%@",[dic objectForKey:@"Data"]);
        NSLog(@"1234567");
        
        block(dic,operation.error);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"签到失败%@",error);
        failedBlock(@"登录失败",error);
        
    }];
    [operation start];
    [operation waitUntilFinished];
}
//上传签出信息验证
+ (void)uploadSignOutwithDic:(NSDictionary *)dataDic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<CheckOut xmlns=\"http://tempuri.org/\">\n"
                          "<userid>%@</userid>\n"
                          "<storeid>%@</storeid>\n"
                          "<lng>%@</lng>\n"
                          "<lat>%@</lat>\n"
                          "<base64Str>%@</base64Str>\n"
                          "</CheckOut>\n"
                          "</soap:Body>\n"
                          "</soap:Envelope>\n", [dataDic objectForKey:@"userid"],[dataDic objectForKey:@"cfgID"],[dataDic objectForKey:@"lng"],[dataDic objectForKey:@"lat"],@""
                          ];
    
    NSString *baseApiURL = [NSString stringWithFormat:AFAddress];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/CheckOut" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"soap\n%@",soapBody);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        
//        NSLog(@"Str-->%@",operation.responseString);
        NSString * loginResult = [XMLHelper signoutXmlChangeJsonStr:operation.responseString];
        //
//                NSLog(@"Result-->>\n%@",loginResult);
                NSError *error;
                NSData *data = [loginResult   dataUsingEncoding:NSUTF8StringEncoding];
                id dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//                NSLog(@"dic-->>%@",dic);
//                NSLog(@"%@",[dic objectForKey:@"Data"]);

                
                block(dic,operation.error);

//        block([dic objectForKey:@"ErrorCode"],nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failedBlock(@"签出失败",error);
        
    }];
    [operation start];
    [operation waitUntilFinished];
}

//登陆验证
+ (void)loginWithLoginName:(NSString *)loginName password:(NSString *)password
                 withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<Login xmlns=\"http://tempuri.org/\">\n"
                          "<username>%@</username>\n"
                          "<password>%@</password>\n"
                          "</Login>\n"
                          "</soap:Body>\n"
                          "</soap:Envelope>\n", loginName  ,password
                          ];
//    NSString *baseApiURL = [NSString stringWithFormat:AFAddress];
        //NSString *baseApiURL = [NSString stringWithFormat:@"http://192.168.60.50/ynj/service/AppWebServicedsr.asmx"];
    NSString *baseApiURL = [NSString stringWithFormat:@"http://unicharm.egocomm.cn/service/AppWebServicedsr.asmx"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/Login" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"soap\n%@",soapBody);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        
//        NSLog(@"Str-->%@",operation.responseString);
        NSString * loginResult = [XMLHelper loginXmlChangeJsonStr:operation.responseString];
        
//        NSLog(@"Result-->>\n%@",loginResult);
        NSError *error;
        NSData *data = [loginResult   dataUsingEncoding:NSUTF8StringEncoding];
        id dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//        NSLog(@"dic-->>%@",dic);
//        NSLog(@"%@",[dic objectForKey:@"Data"]);
        
        [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"Data"] objectForKey:@"UserId"] forKey:@"userID"];

        NSLog(@"id-->>%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"]);
//        NSLog(@"Data-->>%@",[loginResult objectForKey:@"ErrorCode"]);
        
        block(dic,operation.error);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failedBlock(@"登录失败",error);
        
    }];
    [operation start];
    [operation waitUntilFinished];
}
//获取门店基础信息

+ (void)getBaseDataWithDic:(NSDictionary *)dic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock
{

    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<GetStoreList xmlns=\"http://tempuri.org/\">\n"
//                          "<month>%@</month>\n"
                          "<userid>%@</userid>\n"
//                          "<userType>%@</userType>\n"
                          "</GetStoreList>\n"
                          "</soap:Body>\n"
                          "</soap:Envelope>\n", [dic objectForKey:@"userid"]
                          ];
    NSString *baseApiURL = [NSString stringWithFormat:AFAddress];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/GetStoreList" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"soap\n%@",soapBody);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        
        // xml转换json
        //        NSLog(@"登陆成功");
        //        NSDictionary * loginResult = [XMLHelper loginXmlChangeJsonStr:operation.responseString];
        //        NSLog(@"Result-->>\n%@",loginResult);
        //        block(loginResult,operation.error);
        NSString * Result = [XMLHelper XmlChangeJsonStr:operation.responseString];

//        NSLog(@"Result-->>\n%@",Result);
        NSError *error;
        NSData *data = [Result   dataUsingEncoding:NSUTF8StringEncoding];
        id dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//        NSLog(@"dic-->>%@",dic);
//        NSLog(@"%@",[dic objectForKey:@"Data"]);
        block(dic,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failedBlock(@"获取门店失败",error);
        
    }];
    [operation start];
    [operation waitUntilFinished];

}
//获取门店信息

+ (void)getStoreDataWithDic:(NSDictionary *)dic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<GetStoreList xmlns=\"http://tempuri.org/\">\n"
//                          "<userid>%@</month>\n"
                          "<userid>%@</userid>\n"
//                          "<userType>%@</userType>\n"
                          "</GetStoreList>\n"
                          "</soap:Body>\n"
                          "</soap:Envelope>\n",[dic objectForKey:@"userid"]
                          ];
    NSString *baseApiURL = [NSString stringWithFormat:AFAddress];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/GetStoreList" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"soap\n%@",soapBody);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        
        // xml转换json
        //        NSLog(@"登陆成功");
        //        NSDictionary * loginResult = [XMLHelper loginXmlChangeJsonStr:operation.responseString];
        //        NSLog(@"Result-->>\n%@",loginResult);
        //        block(loginResult,operation.error);
        NSString * Result = [XMLHelper StoreXmlChangeJsonStr:operation.responseString];
        
//        NSLog(@"Result-->>\n%@",Result);
        NSError *error;
        NSData *data = [Result   dataUsingEncoding:NSUTF8StringEncoding];
        id dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//        NSLog(@"dic-->>%@",dic);
        //        NSLog(@"%@",[dic objectForKey:@"Data"]);
        block(dic,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failedBlock(@"获取门店失败",error);
        
    }];
    [operation start];
    [operation waitUntilFinished];
    
}
//上传填报信息
+ (void)UploadDataDataWithDic:(NSMutableArray *)dataArr withAddress:(NSString *)str withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<UploadData xmlns=\"http://tempuri.org/\">\n"
                          "<jsonArray>%@</jsonArray>\n"
                          "</UploadData>\n"
                          "</soap:Body>\n"
                          "</soap:Envelope>\n",  dataArr
                          ];
    NSString *baseApiURL = [NSString stringWithFormat:@"%@", str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/UploadData" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"soap\n%@",soapBody);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        
        NSLog(@"上传成功");

        NSString * Result = [XMLHelper UploadXmlChangeJsonStr:operation.responseString];
        

        NSError *error;
        NSData *data = [Result   dataUsingEncoding:NSUTF8StringEncoding];
        id dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        //        NSLog(@"%@",[dic objectForKey:@"Data"]);
        block(dic,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"上传失败");
        failedBlock(@"上传失败",error);
        
    }];
    [operation start];
    [operation waitUntilFinished];
    
}
//上传POP填报信息
+ (void)UploadPOPDataDataWithDic:(NSDictionary *)dic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<UploadPop xmlns=\"http://tempuri.org/\">\n"
//                          "<jsonArray>%@</jsonArray>\n"
                          "<userId>%@</userId>\n"
                          "<usertype>%@</usertype>\n"
                          "<storeid>%@</storeid>\n"
                          "<date>%@</date>\n"
                          "<note>%@</note>\n"
                          "</UploadPop>\n"
                          "</soap:Body>\n"
                          "</soap:Envelope>\n",[dic objectForKey:@"userId"],[dic objectForKey:@"usertype"],[dic objectForKey:@"storeid"],[dic objectForKey:@"date"],[dic objectForKey:@"note"]
                          ];
    NSString *baseApiURL = [NSString stringWithFormat:AFAddress];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/UploadPop" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"soap\n%@",soapBody);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        
        NSLog(@"成功");
        
        NSString * Result = [XMLHelper UploadPOPXmlChangeJsonStr:operation.responseString];
        
//        NSLog(@"Result-->>\n%@",Result);
        NSError *error;
        NSData *data = [Result   dataUsingEncoding:NSUTF8StringEncoding];
        id dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"dic-->>%@",dic);
        //        NSLog(@"%@",[dic objectForKey:@"Data"]);
        block(dic,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"上传失败");
        failedBlock(@"上传失败",error);
        
    }];
    [operation start];
    [operation waitUntilFinished];
    
}
//上传照片

+ (void)UploadPicWithDic:(NSMutableDictionary *)dic withAddress:(NSString *)str withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    
    
    NSString * writePath = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),[dic objectForKey:@"base64Str"]];
    UIImage * image = [UIImage imageWithContentsOfFile:writePath];
    NSLog(@"%@",writePath);
    
    NSData * Imagedata = UIImageJPEGRepresentation(image, 0.5f);
    
    NSString * _encodedImageStr=[Imagedata base64EncodedStringWithOptions:0];
    
    
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<UploadPic xmlns=\"http://tempuri.org/\">\n"
                          "<base64Str>%@</base64Str>\n"
                          "<cfgId>%@</cfgId>\n"
                          "<userid>%@</userid>\n"
                          "<lng>%@</lng>\n"
                          "<lat>%@</lat>\n"
                          "<Createtime>%@</Createtime>\n"
                          "</UploadPic>\n"
                          "</soap:Body>\n"
                          "</soap:Envelope>\n", _encodedImageStr,[dic objectForKey:@"cfgId"],[dic objectForKey:@"userid"],[dic objectForKey:@"lng"],[dic objectForKey:@"lat"],
                          [dic objectForKey:@"Createtime"]
                          ];
    NSString *baseApiURL = [NSString stringWithFormat:@"%@", str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/UploadPic" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"soap\n%@",soapBody);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        
        NSLog(@"照片上传成功");
        
        NSString * Result = [XMLHelper UploadPicXmlChangeJsonStr:operation.responseString];
        
        NSLog(@"%@",Result);
        
        NSError *error;
        NSData *data = [Result   dataUsingEncoding:NSUTF8StringEncoding];
        id dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        //        NSLog(@"%@",[dic objectForKey:@"Data"]);
        block(dic,nil);

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"上传照片失败");
        failedBlock(@"上传照片失败",error);
        
    }];
    [operation start];
    [operation waitUntilFinished];
    
}

//上传POP照片

+ (void)UploadPOPPicWithDic:(NSMutableDictionary *)dic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    
    
    NSString * writePath = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),[dic objectForKey:@"base64Str"]];
    UIImage * image = [UIImage imageWithContentsOfFile:writePath];
    NSLog(@"%@",writePath);
    
    NSData * Imagedata = UIImageJPEGRepresentation(image, 0.5f);
    
    NSString * _encodedImageStr=[Imagedata base64EncodedStringWithOptions:0];
    
    
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<UploadPopPic xmlns=\"http://tempuri.org/\">\n"
                          "<base64Str>%@</base64Str>\n"
                          "<storeid>%@</storeid>\n"
                          "<date>%@</date>\n"
                          "<userId>%@</userId>\n"
                          "<usertype>%@</usertype>\n"
                          "</UploadPopPic>\n"
                          "</soap:Body>\n"
                          "</soap:Envelope>\n", _encodedImageStr,[dic objectForKey:@"storeid"],[dic objectForKey:@"date"],[dic objectForKey:@"userId"],[dic objectForKey:@"usertype"]
                          ];
    NSString *baseApiURL = [NSString stringWithFormat:AFAddress];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/UploadPopPic" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"soap\n%@",soapBody);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        
        NSLog(@"成功");
        
        NSString * Result = [XMLHelper UploadPOPPicXmlChangeJsonStr:operation.responseString];
        
        
        NSError *error;
        NSData *data = [Result   dataUsingEncoding:NSUTF8StringEncoding];
        id dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"上传POP照片成功");
        //        NSLog(@"%@",[dic objectForKey:@"Data"]);
        block(dic,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"上传照片失败");
        failedBlock(@"上传照片失败",error);
        
    }];
    [operation start];
    [operation waitUntilFinished];
    
}
//获取单一产品信息
+ (void)getSingleProDataWithDic:(NSDictionary *)dic withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<GetSignInfo xmlns=\"http://tempuri.org/\">\n"
                          "<userid>%@</userid>\n"
                          "<storeid>%@</storeid>\n"
                          "<date>%@</date>\n"
                          "</GetSignInfo>\n"
                          "</soap:Body>\n"
                          "</soap:Envelope>\n", [dic objectForKey:@"userid"],[dic objectForKey:@"storeid"],[dic objectForKey:@"date"]
                          ];
    NSString *baseApiURL = [NSString stringWithFormat:AFAddress];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/GetSignInfo" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"soap\n%@",soapBody);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        
        NSLog(@"成功");
        
        NSString * Result = [XMLHelper getSingleXmlChangeJsonStr:operation.responseString];
        
        
        NSError *error;
        NSData *data = [Result   dataUsingEncoding:NSUTF8StringEncoding];
        id dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        //        NSLog(@"%@",[dic objectForKey:@"Data"]);
        block(dic,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"获取信息失败");
        failedBlock(@"获取信息失败",error);
        
    }];
    [operation start];
    [operation waitUntilFinished];
    
}
@end
