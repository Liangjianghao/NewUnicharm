//
//  tiaozhuanViewController.m
//  Unicharm
//
//  Created by abc on 2017/3/23.
//  Copyright © 2017年 ljh. All rights reserved.
//
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#define NULLString(string) ((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil) || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)

#import "tiaozhuanViewController.h"
#import "NewSignViewController.h"
#import "KPIListViewController.h"
#import "NetWork.h"
#import "BMapKit.h"
#import "KeepSignInInfo.h"
#import "Base64.h"
#import "MBProgressHUD.h"
@interface tiaozhuanViewController ()
{
    UIButton *signbtn;
    UIButton *btn3;

    UIImageView *imgV;
    UIAlertView *_alert;
    NSURL *imageUrl;
    UIImageView *bigimgV;
    CLLocationManager *locationManager;
    NSString *_name;
    NSMutableDictionary     * _keepInfo;
    NSMutableDictionary *baseDic;
    NSArray *photoArr;
    MBProgressHUD *hud;


}
@end

@implementation tiaozhuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    baseDic=[[NSMutableDictionary alloc]init];
    
    [self location];

    
    _alert=[[UIAlertView alloc]init];

    signbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    signbtn.frame=CGRectMake(10, 10+64, WIDTH/2-20, 40);
    [signbtn setTitle:@"签到" forState:UIControlStateNormal];
    signbtn.tag=101;
    signbtn.backgroundColor=[UIColor groupTableViewBackgroundColor];
    signbtn.layer.cornerRadius=20;
    [signbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [signbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signbtn];
    
    imgV=[[UIImageView alloc]init];
    imgV.frame=CGRectMake(50, 60+64, 50, 50);
    imgV.backgroundColor=[UIColor grayColor];
    [self.view addSubview:imgV];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDetail:)];
    imgV.userInteractionEnabled=YES;
    imgV.tag=1000;
    [imgV addGestureRecognizer:tap];
    
//    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn2.frame=CGRectMake(10, 120+64, WIDTH-20, 40);
//    [btn2 setTitle:@"问卷调查" forState:UIControlStateNormal];
//    btn2.tag=102;
//    btn2.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    btn2.layer.cornerRadius=20;
//    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
////    [self.view addSubview:btn2];
//    
//    if ([_model.PlanType isEqualToString:@"00"]) {
//        NSLog(@"PlanType--->%@",_model.PlanType);
//    }
    
    btn3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn3.frame=CGRectMake(WIDTH/2+10, 10+64, WIDTH/2-20, 40);
    [btn3 setTitle:@"签出" forState:UIControlStateNormal];
    btn3.tag=102;
    btn3.backgroundColor=[UIColor groupTableViewBackgroundColor];
    btn3.layer.cornerRadius=20;
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    
    UIButton *btnxun=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnxun.frame=CGRectMake(10, 220, WIDTH-20, 40);
    [btnxun setTitle:@"日常巡店" forState:UIControlStateNormal];
    btnxun.tag=103;
    btnxun.backgroundColor=[UIColor groupTableViewBackgroundColor];
    btnxun.layer.cornerRadius=20;
    [btnxun setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnxun addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnxun];
    
    UIButton *btn2qi=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2qi.frame=CGRectMake(10, 320, WIDTH-20, 40);
    [btn2qi setTitle:@"企划KPI任务" forState:UIControlStateNormal];
    btn2qi.tag=104;
    btn2qi.backgroundColor=[UIColor groupTableViewBackgroundColor];
    btn2qi.layer.cornerRadius=20;
    [btn2qi setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2qi addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2qi];
    self.view.backgroundColor=[UIColor whiteColor];
}
-(void)btnClick:(UIButton *)btn
{
    
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    
    NewSignViewController *signVC=[[NewSignViewController alloc]init];
    //    newVC.name=[dataArr[indexPath.row] ID];
   // signVC.model=dataArr[indexPath.row];
    signVC.model=_model;
    
    KPIListViewController *kpiListVC=[[KPIListViewController alloc]init];
    //    newVC.name=[dataArr[indexPath.row] ID];
    // signVC.model=dataArr[indexPath.row];
    kpiListVC.model=_model;
    
    
    if (btn.tag==103||btn.tag==104) {
        [hud hideAnimated:YES];

        if ([signbtn.titleLabel.text isEqualToString:@"签到"]) {
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
            [self signOut];
            break;
        case 103:
            [self.navigationController pushViewController:signVC animated:YES];
            break;
        case 104:
            
            [self.navigationController pushViewController:kpiListVC animated:YES];
            break;
            
        default:
            break;
    }
    

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getSignInfo];
    
}
-(void)getSignInfo
{
    NSLog(@"id-->>%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"]);
    
    NSDateFormatter *dateFormer=[[NSDateFormatter alloc]init];
    [dateFormer setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormer stringFromDate:[NSDate date]];
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:_model.ID,@"storeid",[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"],@"userid" ,currentDateStr,@"date",nil];
    [NetWork getSingleProDataWithDic:dic withBlock:^(NSDictionary *result, NSError *error) {
        _model.SignIn=[[result objectForKey:@"Data"] objectForKey:@"SigninTime"];
        _model.SignOut=[[result objectForKey:@"Data"]objectForKey:@"CheckOutTime"];
        _model.SignInImg=[[result objectForKey:@"Data"] objectForKey:@"SigninImg"];
        
        if (!NULLString(_model.SignIn)) {
            [signbtn setTitle:[NSString stringWithFormat:@"签到%@",_model.SignIn] forState:UIControlStateNormal];
            
        }
        if (!NULLString(_model.SignOut)) {
            //            label2.text=[NSString stringWithFormat:@"签出时间:%@",_model.SignOut];
            [btn3 setTitle:[NSString stringWithFormat:@"签出%@",_model.SignOut] forState:UIControlStateNormal];
            
        }
        NSLog(@"%@",_model.SignInImg);
        
        NSLog(@"%@",[NSString stringWithFormat:@"http://unicharm.egocomm.cn/%@",_model.SignInImg]);
        
        imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://unicharm.egocomm.cn/%@",_model.SignInImg]];
        //imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.60.50/ynj//%@",_model.SignInImg]];
        
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(showImg) object:nil];
        
        // 启动
        [thread start];
        
        
        
        //        NSLog(@"%@",_model.SignInImg);
    } withBlock:^(NSString *result, NSError *error) {
        
        
    }];
    
    
}

-(void)showImg
{
    NSLog(@"111");
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    
    imgV.image=image;
}

-(void)toDetail:(UITapGestureRecognizer *)tap
{
    
    bigimgV=[[UIImageView alloc]init];
    bigimgV.frame=CGRectMake(0, 100, WIDTH , WIDTH);
    
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
    
    //hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Set the label text.
    //hud.label.text = @"签出中,请稍候...";
    
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
            //            _model.ID=[result objectForKey:@"Data"];
            hud.label.text=@"签出成功";
            [hud hideAnimated:YES afterDelay:1];
            
            [self getSignInfo];
        }
        
    } withBlock:^(NSString *result, NSError *error) {
        [_alert setTitle:@"签出失败!请重试"];
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
        
        
        NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
        [baseDic setValue:userid forKey:@"userid"];
        
        [baseDic setValue:_model.ID forKey:@"storeID"];
        
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
                //            _model.ID=[result objectForKey:@"Data"];
                hud.label.text=@"签到成功";
                [hud hideAnimated:YES afterDelay:1];
                //if (hud) {
                //   [hud removeFromSuperview];
                //}
                //                [KeepSignInInfo deletePatrolPictureWithImageUrl:[picArr[i] objectForKey:@"imageurl"]];
                //
                //                NSString * imageUrl = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),[picArr[i] objectForKey:@"imageurl"]];
                //                [[NSFileManager defaultManager] removeItemAtPath:imageUrl error:nil];
                
                [self getSignInfo];
            }
            
        } withBlock:^(NSString *result, NSError *error) {
            [_alert setTitle:@"签到失败!请重试"];
            [_alert show];
            [UIView animateWithDuration:4 animations:^{
                [_alert dismissWithClickedButtonIndex:0 animated:YES];
            }];
        }];
        
//        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//        
//        NSData *data = UIImageJPEGRepresentation(image, 1);
//        //        NSString *resultStr = [NSString stringWithFormat:@"%ld",(unsigned long)data.length];
//        
//        NSDictionary *  dic = [[editingInfo objectForKey:@"UIImagePickerControllerMediaMetadata"] objectForKey:@"{Exif}"];
//        NSString * time = [NSString stringWithFormat:@"%@",[NSDate date]];
//        //        time = resultStr;
//        NSString * imageUrl  =[NSString stringWithFormat:@"%@%@.jpg",time,userID];
//        //        [_loMar stopUpdatingLocation];
//        
//        NSDictionary * imageDic = @{@"image":image,@"imageurl":imageUrl};
//        
//        //        [NSThread detachNewThreadSelector:@selector(useImage:) toTarget:self withObject:imageDic];
//        //        [self useImage:imageDic];
//        
//        
//        NSString * identifier   = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//        NSString * imageType = @"JPG";
//        
//        NSDate * date = [NSDate date];
//        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        
//        NSString * Createtime = [formatter stringFromDate:date];
//        _keepInfo=[[NSMutableDictionary alloc]init];
//        
//        [_keepInfo setValue:_name forKey:@"selectType"];
////        [_keepInfo setValue:imgID forKey:@"imgID"];
//        [_keepInfo setValue:_model.ID   forKey:@"storeCode"];
//        [_keepInfo setValue:userID      forKey:@"userID"];
//        [_keepInfo setValue:identifier  forKey:@"identifier"];
//        [_keepInfo setValue:imageType   forKey:@"imageType"];
//        [_keepInfo setValue:Createtime  forKey:@"Createtime"];
//        [_keepInfo setValue:imageUrl    forKey:@"imageUrl"];
//        
//        
//        [_keepInfo setValue:[baseDic valueForKey:@"lng"] forKey:@"Longitude"];
//        [_keepInfo setValue:[baseDic valueForKey:@"lat"] forKey:@"Latitude"];
//        //        }
//        //        if ([_keepInfo valueForKey:@"Longitude"]) {
//        [KeepSignInInfo keepPhotoWithDictionary:_keepInfo];
//        NSLog(@"home-->\n%@",NSHomeDirectory());
//        [self useImage:imageDic];
        
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
        
        NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
        [baseDic setValue:userid forKey:@"userid"];
        
        [baseDic setValue:_model.ID forKey:@"storeID"];
    
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
                //            _model.ID=[result objectForKey:@"Data"];
                hud.label.text=@"签到成功";
                [hud hideAnimated:YES afterDelay:1];
                //if (hud) {
                //   [hud removeFromSuperview];
                //}
//                [KeepSignInInfo deletePatrolPictureWithImageUrl:[picArr[i] objectForKey:@"imageurl"]];
//                
//                NSString * imageUrl = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),[picArr[i] objectForKey:@"imageurl"]];
//                [[NSFileManager defaultManager] removeItemAtPath:imageUrl error:nil];
                
                [self getSignInfo];
            }
            
        } withBlock:^(NSString *result, NSError *error) {
            [_alert setTitle:@"签到失败!请重试"];
            [_alert show];
            [UIView animateWithDuration:4 animations:^{
                [_alert dismissWithClickedButtonIndex:0 animated:YES];
            }];
        }];
    
    
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
    
}
@end
