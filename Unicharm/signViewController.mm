//
//  signViewController.m
//  Unicharm
//
//  Created by mac on 17/1/16.
//  Copyright © 2017年 ljh. All rights reserved.
//
#define NULLString(string) ((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil) || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#if TARGET_IPHONE_SIMULATOR

#define SIMULATOR_TEST
#else
//不定义SIMULATOR_TEST这个宏

#endif

#import "signViewController.h"
#import "NewViewController.h"
#import "DetailViewController.h"
#import "StoreMD.h"
#import "KeepSignInInfo.h"
#import "keepLocationInfo.h"
#import "NetWork.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "BMapKit.h"
#import "Base64.h"
@interface signViewController ()
{
    NSMutableDictionary     * _keepInfo;
    NSMutableArray *photoArr;
    CLLocationManager *locationManager;
    UILabel *label;
    UILabel *label2;
    UIButton *imgbtn;
    
    NSMutableDictionary *baseDic;
    UIImageView *imgV;
    UIImageView *bigimgV;
    UIAlertView * _alert;
    NSURL *imageUrl;

    
}
@end

@implementation signViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    baseDic=[[NSMutableDictionary alloc]init];
    
    // Do any additional setup after loading the view.
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(50, 100, WIDTH-100, 40);
    [btn setTitle:@"签到" forState:UIControlStateNormal];
    btn.tag=101;
    btn.backgroundColor=[UIColor groupTableViewBackgroundColor];
    btn.layer.cornerRadius=20;
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    label=[[UILabel alloc]init];
    label.frame=CGRectMake(10, 150, WIDTH-20, 40);
    label.text=[NSString stringWithFormat:@"未签到"];
    label.textAlignment=NSTextAlignmentCenter;
    label.tag=1001;
    [self.view addSubview:label];
    
    imgbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    imgbtn.frame=CGRectMake(50, 200, 50, 50);
    [imgbtn setTitle:@"显示" forState:UIControlStateNormal];
    imgbtn.tag=105;
//    imgbtn.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    imgbtn.layer.cornerRadius=20;
    
    [imgbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [imgbtn addTarget:self action:@selector(imgbtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:imgbtn];
    
    imgV=[[UIImageView alloc]init];
    imgV.frame=CGRectMake(50, 200, 50, 50);
    imgV.backgroundColor=[UIColor grayColor];
    [self.view addSubview:imgV];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDetail:)];
    imgV.userInteractionEnabled=YES;
    [imgV addGestureRecognizer:tap];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame=CGRectMake(50, 270, WIDTH-100, 40);
    [btn2 setTitle:@"填报" forState:UIControlStateNormal];
    btn2.tag=102;
    btn2.backgroundColor=[UIColor groupTableViewBackgroundColor];
    btn2.layer.cornerRadius=20;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
//    [_model.ShelfSectionNumber3 isKindOfClass:[NSNull class]]
//    if ([_model.PlanType isKindOfClass:[NSNull class]]) {
    if ([_model.PlanType isEqualToString:@"00"]) {
        
        NSLog(@"PlanType--->%@",_model.PlanType);
        
//        btn2.hidden=YES;
    }
    
    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn3.frame=CGRectMake(50, 320, WIDTH-100, 40);
    [btn3 setTitle:@"签出" forState:UIControlStateNormal];
    btn3.tag=103;
    btn3.backgroundColor=[UIColor groupTableViewBackgroundColor];
    btn3.layer.cornerRadius=20;
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    
    label2=[[UILabel alloc]init];
    label2.frame=CGRectMake(10, 370, WIDTH-20, 40);
    label2.text=[NSString stringWithFormat:@"未签出"];
    label2.textAlignment=NSTextAlignmentCenter;
    label2.tag=1002;
    [self.view addSubview:label2];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
#ifndef SIMULATOR_TEST
    NSLog(@"moniqo");
#endif

    [self location];
    _alert=[[UIAlertView alloc]init];

    self.title=_model.Name;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getSignInfo];

}
-(void)toDetail:(UITapGestureRecognizer *)tap
{
    
    bigimgV=[[UIImageView alloc]init];
    bigimgV.frame=CGRectMake(0, 100, WIDTH  , WIDTH);
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];

    bigimgV.image=image;
    
    [self.view addSubview:bigimgV];
    
    UITapGestureRecognizer *newtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
    bigimgV.userInteractionEnabled=YES;
    [bigimgV addGestureRecognizer:newtap];
}
-(void)dismiss:(UITapGestureRecognizer *)tap
{
    [bigimgV removeFromSuperview];
    
}
-(void)getSignInfo
{
    
//    [NetWork getSingleProDataWithDic:_model.ID withBlock:^(NSDictionary *result, NSError *error) {
//        _model.SignIn=[result objectForKey:@"SignIn"];
//        _model.SignOut=[result objectForKey:@"SignOut"];
//        _model.SignInImg=[result objectForKey:@"SignInImg"];
//        _model.IsVerify=[result objectForKey:@"IsVerify"];
//        
//        _model.Expand1=[result objectForKey:@"Expand1"];
//        _model.Expand2=[result objectForKey:@"Expand2"];
//        _model.ShelfSectionNumber1=[result objectForKey:@"ShelfSectionNumber1"];
//        _model.ShelfSectionNumber2=[result objectForKey:@"ShelfSectionNumber2"];
//        _model.ShelfSectionNumber3=[result objectForKey:@"ShelfSectionNumber3"];
//        NSLog(@"3333--->>>%@",[result objectForKey:@"ShelfSectionNumber3"]);
//        if (!NULLString(_model.SignIn)) {
//            label.text=[NSString stringWithFormat:@"签到时间:%@",_model.SignIn];
//
//        }
//        if (!NULLString(_model.SignOut)) {
//            label2.text=[NSString stringWithFormat:@"签出时间:%@",_model.SignOut];
// 
//        }
//
//        NSLog(@"%@",[NSString stringWithFormat:@"http://unicharm.egocomm.cn/%@",_model.SignInImg]);
//        
//
//        imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://unicharm.egocomm.cn/%@",_model.SignInImg]];
//
//        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(showImg) object:nil];
//        
//        // 启动
//        [thread start];
//      
//        
//        
////        NSLog(@"%@",_model.SignInImg);
//    } withBlock:^(NSString *result, NSError *error) {
//        
//        
//    }];
    

}
-(void)showImg
{
    NSLog(@"111");
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    
    imgV.image=image;
}
-(void)imgbtnClick:(UIButton *)btn
{

}
-(void)btnClick:(UIButton *)btn
{

    
    NewViewController *newVC=[[NewViewController alloc]init];
    //    newVC.name=[dataArr[indexPath.row] ID];
    newVC.model=_model;
    DetailViewController *detailVC=[[DetailViewController alloc]init];
    
    detailVC.model=_model;
    detailVC.KPICategory=[_model KPICategory];
    
    if ([[NSString stringWithFormat:@"%@",[_model IsVerify]] isEqualToString:@"0"]) {
        
        detailVC.status=@"change";
        
    }
    else  if ([[NSString stringWithFormat:@"%@",[_model IsVerify]] isEqualToString:@"1"]) {
        detailVC.status=@"unchange";
        
    }
    else   if ([[NSString stringWithFormat:@"%@",[_model IsVerify]] isEqualToString:@"2"]) {
        
        detailVC.status=@"unchange";
        
    }
    else
    {
        detailVC.status=@"change";
        
    }
    
    if (btn.tag==102) {
        if ([label.text isEqualToString:@"未签到"]) {
            [_alert setTitle:[NSString stringWithFormat:@"请先签到！"]];
            [_alert show];
            [UIView animateWithDuration:4 animations:^{
                [_alert dismissWithClickedButtonIndex:0 animated:YES];
            }];
            return;
        }
    }
    

    
    switch (btn.tag) {
        case 101:
            [self signIn];
            break;
        case 102:
            [self.navigationController pushViewController:detailVC animated:YES];
            break;
        case 103:
            [self signOut];
            break;
            
        default:
            break;
    }
    
}
-(void)signIn
{
//    [self getSignInfo];
    
    _name=@"imgDoor";
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
 
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
#pragma MARK 前置摄像头
    //    imagePicker.cameraDevice=UIImagePickerControllerCameraDeviceFront;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)signOut
{
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    [baseDic setValue:userid forKey:@"userid"];
    [baseDic setValue:_model.ID forKey:@"cfgID"];
    _alert=[[UIAlertView alloc]init];

    [NetWork uploadSignOutwithDic:baseDic withBlock:^(NSDictionary *result, NSError *error) {
        NSLog(@"上传签出成功");
        if ([[result objectForKey:@"ErrorCode"] intValue]!=0) {
            [_alert setTitle:[NSString stringWithFormat:@"%@",[result objectForKey:@"ErrorMsg"]]];
            [_alert show];
            [UIView animateWithDuration:4 animations:^{
                [_alert dismissWithClickedButtonIndex:0 animated:YES];
            }];
        }
        else{
            _model.ID=[result objectForKey:@"Data"];
        [self getSignInfo];
        }

    } withBlock:^(NSString *result, NSError *error) {
        [_alert setTitle:@"上传失败!请重试"];
        [_alert show];
        [UIView animateWithDuration:4 animations:^{
            [_alert dismissWithClickedButtonIndex:0 animated:YES];
        }];
        
    }];
}
-(void)location
{
    locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    //定位精度
    CLLocationDistance distance=100.0;//十米定位一次
    locationManager.distanceFilter=distance;
    
    //    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] > 8)
    {
        /** 请求用户权限：分为：只在前台开启定位  /在后台也可定位， */
        
        /** 只在前台开启定位 */
        //        [self.locationManager requestWhenInUseAuthorization];
        
        /** 后台也可以定位 */
        [locationManager requestAlwaysAuthorization];
    }
    
    if ([[UIDevice currentDevice].systemVersion floatValue] > 9)
    {
        /** iOS9新特性：将允许出现这种场景：同一app中多个location manager：一些只能在前台定位，另一些可在后台定位（并可随时禁止其后台定位）。 */
        [locationManager setAllowsBackgroundLocationUpdates:YES];
    }
    
    /** 开始定位 */
    
    [locationManager startUpdatingLocation];
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        //        NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
        
        NSString * userID =  [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
        UIImage * image = [editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        
        NSData *data = UIImageJPEGRepresentation(image, 1);
        //        NSString *resultStr = [NSString stringWithFormat:@"%ld",(unsigned long)data.length];
        
        NSDictionary *  dic = [[editingInfo objectForKey:@"UIImagePickerControllerMediaMetadata"] objectForKey:@"{Exif}"];
        NSString * time = [dic objectForKey:@"DateTimeOriginal"];
        //        time = resultStr;
        NSString * imageUrl  =[NSString stringWithFormat:@"%@%@.jpg",time,userID];
        //        [_loMar stopUpdatingLocation];
        
        NSDictionary * imageDic = @{@"image":image,@"imageurl":imageUrl};
        
        //        [NSThread detachNewThreadSelector:@selector(useImage:) toTarget:self withObject:imageDic];
//        [self useImage:imageDic];
        
        
        NSString * identifier   = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSString * imageType = @"JPG";
        
        NSDate * date = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString * Createtime = [formatter stringFromDate:date];
        _keepInfo=[[NSMutableDictionary alloc]init];
        
        [_keepInfo setValue:_name forKey:@"selectType"];
        [_keepInfo setValue:_model.ID   forKey:@"storeCode"];
        [_keepInfo setValue:userID      forKey:@"userID"];
        [_keepInfo setValue:identifier  forKey:@"identifier"];
        [_keepInfo setValue:imageType   forKey:@"imageType"];
        [_keepInfo setValue:Createtime  forKey:@"Createtime"];
        [_keepInfo setValue:imageUrl    forKey:@"imageUrl"];
        
        
        
        
        StoreMD * store = [keepLocationInfo selectLocationLastData];
        //        [_keepInfo setValue:store.Latitude forKey:@"Latitude"];
        [_keepInfo setValue:store.Latitude forKey:@"Longitude"];
        [_keepInfo setValue:store.Longitude forKey:@"Latitude"];
        [_keepInfo setValue:store.timeStamo forKey:@"LocationTtime"];
        //        }
        //        if ([_keepInfo valueForKey:@"Longitude"]) {
        [KeepSignInInfo keepPhotoWithDictionary:_keepInfo];
        [self useImage:imageDic];
        
    }];
    
    
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
//    NSString *msg = nil ;
//    if(error != NULL){
//        msg = @"保存到相册失败" ;
//    }else{
//        msg = @"保存到相册成功" ;
//    }
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
//                                                    message:msg
//                                                   delegate:self
//                                          cancelButtonTitle:nil
//                                          otherButtonTitles:nil];
//    [alert show];
//    
//    [UIView animateWithDuration:8 animations:^{
//        [alert dismissWithClickedButtonIndex:0 animated:YES];
//    }];
}
- (void)useImage:(NSDictionary *)imageDic
{
    UIImage * image = [imageDic objectForKey:@"image"];
    NSString * imageUrl = [imageDic objectForKey:@"imageurl"];
    NSString * writePath = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),imageUrl];
    //对图片进行压缩
    CGSize newSize = CGSizeMake(768, 1024);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //照片写入本地存储
    NSData * photoData = UIImageJPEGRepresentation(newImage,1);
    [photoData writeToFile:writePath atomically:NO];
    
    //    dataArr=[KeepSignInInfo selectPhotoWithType:_name andId:_model.Code];
    photoArr=[KeepSignInInfo selectPhotoWithType:@"imgDoor" andId:_model.ID];
//    photoArr2=[KeepSignInInfo selectPhotoWithType:@"照片" andId:_model.ID];
    
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    [baseDic setValue:userid forKey:@"userid"];
    [baseDic setValue:_model.ID forKey:@"cfgID"];
    
    [baseDic setValue:_model.Id forKey:@"storeID"];

    
    NSData * Imagedata = UIImageJPEGRepresentation(image, 0.5f);
    
    NSString * _encodedImageStr=[Imagedata base64EncodedStringWithOptions:0];
    
    [baseDic setValue:_encodedImageStr forKey:@"base64Str"];
    
    [NetWork uploadSignInwithDic:baseDic withBlock:^(NSDictionary *result, NSError *error) {
        
        if ([[result objectForKey:@"ErrorCode"] intValue]!=0) {
            [_alert setTitle:[NSString stringWithFormat:@"%@",[result objectForKey:@"ErrorMsg"]]];
            [_alert show];
            [UIView animateWithDuration:4 animations:^{
                [_alert dismissWithClickedButtonIndex:0 animated:YES];
            }];
        }
        else{
            _model.ID=[result objectForKey:@"Data"];
            
            [self getSignInfo];
        }

    } withBlock:^(NSString *result, NSError *error) {
        [_alert setTitle:@"上传失败!请重试"];
        [_alert show];
        [UIView animateWithDuration:4 animations:^{
            [_alert dismissWithClickedButtonIndex:0 animated:YES];
        }];
    }];
    
//    [self uiConfig];
}
#pragma mark --CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //CLLocation *loc = [locations firstObject];
    CLLocation *loc = [locations lastObject];
    //NSLog(@"%@",loc);
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString * timestamo = [formatter stringFromDate:loc.timestamp];
    // 2.取出经纬度
    CLLocationCoordinate2D coordinate = loc.coordinate;
    CLLocationCoordinate2D test = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    
    NSLog(@"lng %f lat %f",coordinate.longitude,coordinate.latitude);
    
    NSDictionary *testdic   = BMKConvertBaiduCoorFrom(test, BMK_COORDTYPE_GPS);
    NSString * latitude     = [NSString stringWithBase64EncodedString:[testdic objectForKey:@"y"]];
    NSString * longitude    = [NSString stringWithBase64EncodedString:[testdic objectForKey:@"x"]];
    
    [baseDic setValue:latitude forKey:@"lat"];
    [baseDic setValue:longitude forKey:@"lng"];
//
//    NSLog(@"lai:%f,long:%f",coordinate.latitude,coordinate.longitude);
//    lat=latitude;
//    lng=longitude;
//    if (tag>100) {
//        UILabel *label=[self.view viewWithTag:tag+200];
//        label.text=[NSString stringWithFormat:@"lai:%f\nlong:%f",coordinate.latitude,coordinate.longitude];
//    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
