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

#import "NewSignViewController.h"
#import "NewViewController.h"
#import "DetailViewController.h"
#import "StoreMD.h"
#import "KeepSignInInfo.h"
#import "keepLocationInfo.h"
#import "NetWork.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "BMapKit.h"
#import "Base64.h"
#import "MBProgressHUD.h"
#import "QueViewController.h"
@interface NewSignViewController ()<UITableViewDelegate,UITableViewDataSource>
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
    
    UIScrollView *baseScroll;
    
    NSMutableArray *baseArr;
    
    NSMutableArray *allModelArr;
    NSMutableArray *dataArr;
    NSMutableArray *imgArr;
    NSMutableArray *imgCountArr;
    NSMutableArray *scrolls;
    BOOL takephotoBtn;
    UITableView *mytable;
    UIButton *btn;
    UIButton *btn3;
      MBProgressHUD *hud;
    NSString *imgID;
    UIScrollView *otherScrollVC;

}
@end

@implementation NewSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    baseDic=[[NSMutableDictionary alloc]init];
    
    [self baseUI];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    baseArr=[[NSMutableArray alloc]init];
    scrolls=[[NSMutableArray alloc]init];
    
    allModelArr=[[NSMutableArray alloc]init];

#ifndef SIMULATOR_TEST
    NSLog(@"moniqi");
#endif
    
    [self location];
    _alert=[[UIAlertView alloc]init];
    
    self.title=_model.Name;
    
//    [self tableviewUI];
    
//    [self imgUI];
    
}
-(void)baseUI
{
    baseScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT)];
    //baseScroll.contentSize=CGSizeMake(WIDTH, HEIGHT*2);
    
    [self.view addSubview:baseScroll];
    
//    btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn.frame=CGRectMake(10, 10, WIDTH/2-20, 40);
//    [btn setTitle:@"签到" forState:UIControlStateNormal];
//    btn.tag=101;
//    btn.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    btn.layer.cornerRadius=20;
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [baseScroll addSubview:btn];
//    
//    imgV=[[UIImageView alloc]init];
//    imgV.frame=CGRectMake(50, 60, 50, 50);
//    imgV.backgroundColor=[UIColor grayColor];
//    [baseScroll addSubview:imgV];
//    
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDetail:)];
//    imgV.userInteractionEnabled=YES;
//    imgV.tag=1000;
//    [imgV addGestureRecognizer:tap];
//    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame=CGRectMake(10, 20, WIDTH-20, 40);
    [btn2 setTitle:@"问卷调查" forState:UIControlStateNormal];
    btn2.tag=102;
    btn2.backgroundColor=[UIColor groupTableViewBackgroundColor];
    btn2.layer.cornerRadius=20;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [baseScroll addSubview:btn2];
//
//    if ([_model.PlanType isEqualToString:@"00"]) {
//        NSLog(@"PlanType--->%@",_model.PlanType);
//    }
//    
//    btn3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn3.frame=CGRectMake(WIDTH/2+10, 10, WIDTH/2-20, 40);
//    [btn3 setTitle:@"签出" forState:UIControlStateNormal];
//    btn3.tag=103;
//    btn3.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    btn3.layer.cornerRadius=20;
//    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [baseScroll addSubview:btn3];

    self.view.backgroundColor=[UIColor whiteColor];
}
//-(void)tableviewUI
//{
//    if (mytable) {
//        [mytable removeFromSuperview];
//    }
//    baseScroll.contentSize=CGSizeMake(WIDTH, 230+imgArr.count*100+dataArr.count*60);
//
//    mytable=[[UITableView alloc]initWithFrame:CGRectMake(0, 230+imgArr.count*100, WIDTH, dataArr.count*60)];
//    mytable.delegate=self;
//    mytable.dataSource=self;
//    [baseScroll addSubview:mytable];
//   
//}
-(void)imgUI
{
    for (int i=0; i<scrolls.count; i++) {
        [scrolls[i] removeFromSuperview];
    }
    [scrolls removeAllObjects];
    for (int m=0; m<imgArr.count; m++) {
        NSString *name;
        name=imgArr[m];

        photoArr=[KeepSignInInfo selectPhotoWithType:name andId:_model.ID];
        UIScrollView *smallScr=[[UIScrollView alloc]init];
        smallScr.frame=CGRectMake(0,80+100*m,WIDTH,90);
        smallScr.tag=500+m;
        UILabel *namelabel=[[UILabel alloc]init];
        namelabel.frame=CGRectMake(0, 0, 100, 40);
        namelabel.text=[NSString stringWithFormat:@"%@:",imgArr[m]];
        namelabel.textAlignment=NSTextAlignmentCenter;
        namelabel.font=[UIFont systemFontOfSize:16];
        namelabel.numberOfLines=0;
        [smallScr addSubview:namelabel];
        smallScr.contentSize=CGSizeMake(90 *photoArr.count+80+115, 90);
        [baseScroll addSubview:smallScr];
        
        UIButton *Photobtn=[UIButton buttonWithType:UIButtonTypeCustom];
        Photobtn.frame=CGRectMake(115, 0, 60, 60);
        [Photobtn setBackgroundImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
        Photobtn.tag=300+m;
        [Photobtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [smallScr addSubview:Photobtn];
        if (photoArr.count>0) {
            for (int j=0; j<photoArr.count; j++) {
                UIImageView *imgView=[[UIImageView alloc]init];
                imgView.frame=CGRectMake(115+80+90*j, 0, 80, 80);
                [imgView setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),[photoArr[j] objectForKey:@"imageurl"]]]];
                    imgView.tag=2000+m;
                NSLog(@"%ld",(long)imgView.tag);
                UITapGestureRecognizer *longPress=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDetailT:)];
                [imgView addGestureRecognizer:longPress];
                imgView.userInteractionEnabled=YES;
            
                [smallScr addSubview:imgView];
            }
        }
        [scrolls addObject:smallScr];
        
    }

    

}
-(void)viewWillDisappear:(BOOL)animated
{
 
}
-(void)viewWillAppear:(BOOL)animated
{
//    [self getSignInfo];
 
    [self loadData];
    
}
-(void)loadData
{
    imgArr=nil;
    dataArr=nil;
    dataArr=[[NSMutableArray alloc]init];
    imgArr=[[NSMutableArray alloc]init];
    imgCountArr=[[NSMutableArray alloc]init];
    
    [NetWork getPhotoTypleWithDic:nil withBlock:^(NSDictionary *result, NSError *error) {
//        NSLog(@"%@",[result objectForKey:@"ErrorCode"]);
        if ([[result objectForKey:@"ErrorCode"] intValue]==0) {
          NSArray  *nameArr=[result objectForKey:@"Data"];
            for (int i=0; i<nameArr.count; i++) {
                NSString *name=[nameArr[i] objectForKey:@"Name"];
                [imgArr addObject:name];
                [imgCountArr addObject:[nameArr[i] objectForKey:@"Id"]];
            }
              baseScroll.contentSize=CGSizeMake(WIDTH, 130+imgArr.count*100+60);

            [self imgUI];
          //  [self tableviewUI];

            UIButton *btn4=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn4.frame=CGRectMake(10, 80+imgArr.count*100, WIDTH-20, 40);
            [btn4 setTitle:@"上传照片" forState:UIControlStateNormal];
            btn4.tag=104;
            btn4.backgroundColor=[UIColor groupTableViewBackgroundColor];
            btn4.layer.cornerRadius=20;
            [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//            [baseScroll addSubview:btn4];
        }
    } withBlock:^(NSString *result, NSError *error) {
        
    }];
    
   }

-(void)toDetailT:(UITapGestureRecognizer *)tap
{
    NSLog(@"%ld",tap.view.tag);
    NSLog(@"%ld",tap.view.superview.tag);
    
    NSString *name=imgArr[tap.view.tag-2000];
    
  NSArray *  myphotoArr=[KeepSignInInfo selectPhotoWithType:name andId:_model.ID];

    
        self.tabBarController.tabBar.hidden = YES;
        otherScrollVC=[[UIScrollView alloc]init];
        otherScrollVC.frame=CGRectMake(0, 104, WIDTH, 464);
        otherScrollVC.contentSize=CGSizeMake(WIDTH*myphotoArr.count, 400);
        NSLog(@"count-->>%lu",(unsigned long)myphotoArr.count);
        otherScrollVC.pagingEnabled=YES;
        for (int i=0; i<myphotoArr.count; i++) {
            UIImageView *imgVv=[[UIImageView alloc]init];
            imgVv.frame=CGRectMake(10+WIDTH*i, 0, WIDTH-20, 400);
            [otherScrollVC addSubview:imgVv];
            imgVv.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),[myphotoArr[i] objectForKey:@"imageurl"]]];
            imgVv.userInteractionEnabled=YES;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
            [imgVv addGestureRecognizer:tap];
            
        }
        
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.view addSubview:otherScrollVC];
            
        }];
    
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
    [otherScrollVC removeFromSuperview];

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
            [btn setTitle:[NSString stringWithFormat:@"签到%@",_model.SignIn] forState:UIControlStateNormal];
            
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
-(void)imgbtnClick:(UIButton *)btn
{
    
}
-(void)btnClick:(UIButton *)btn
{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.label.text = @"上传照片中,请稍候...";
    
    takephotoBtn=NO;
    
    QueViewController *queVC=[[QueViewController alloc]init];
    queVC.storeID=_model.ID;
    
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
            [hud hideAnimated:YES];
            [self.navigationController pushViewController:queVC animated:YES];
            
            break;
        case 103:
            [self signOut];
            break;
        case 104:
//            [hud hideAnimated:YES];

            [self uploadPic];
            break;
        default:
            break;
    }
    
}
-(void)uploadPic
{

    
//    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
//    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",_model.ID,@"storeid",_name,@"imgtype",,, nil];
//    [NetWork uploadPhotoWithDic:dic withBlock:^(NSDictionary *result, NSError *error) {
//        
//    } withBlock:^(NSString *result, NSError *error) {
//        
//    }];
//    
//[dataDic objectForKey:@"userid"],[dataDic objectForKey:@"storeid"],[dataDic objectForKey:@"imgtype"],[dataDic objectForKey:@"lng"],[dataDic objectForKey:@"lat"],[dataDic objectForKey:@"base64Str"]
    for (int i=0; i<imgArr.count; i++) {
        
        NSMutableArray * picArr = [KeepSignInInfo selectPhotoWithType:imgArr[i] andId:_model.ID];

            for (int i=0; i<picArr.count; i++) {
        
//                if (picArr.count>0) {
//                    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                    hud.label.text = @"上传照片中,请稍候...";
//                }
                NSMutableDictionary *picDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:[picArr[i] objectForKey:@"userID"],@"userid",[picArr[i] objectForKey:@"storeCode"],@"storeid",[picArr[i] objectForKey:@"imgID"],@"imgtype",[picArr[i] objectForKey:@"Longitude"],@"lng",[picArr[i] objectForKey:@"Latitude"],@"lat",[picArr[i] objectForKey:@"imageurl"],@"base64Str",[picArr[i] objectForKey:@"createTime"],@"createTime",nil];
        
        
                [NetWork uploadPhotoWithDic:picDic withBlock:^(NSDictionary *result, NSError *error) {
                    if ([[result objectForKey:@"ErrorCode"] intValue]==0) {
                        NSLog(@"shanchu%@",[picArr[i] objectForKey:@"imageurl"]);
                        
                    [KeepSignInInfo deletePatrolPictureWithImageUrl:[picArr[i] objectForKey:@"imageurl"]];
        
                    NSString * imageUrl = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),[picArr[i] objectForKey:@"imageurl"]];
                    [[NSFileManager defaultManager] removeItemAtPath:imageUrl error:nil];
                        
                        [self imgUI];
                        
//                    photoArr=[KeepSignInInfo selectPhotoWithType:@"照片" andId:_model.ID];
//                    [self uiConfig];
        
                    hud.label.text=@"上传成功";
                    [hud hideAnimated:YES afterDelay:1];
         
                    }
        
         
                } withBlock:^(NSString *result, NSError *error) {
                    hud.label.text=@"上传失败,请重试";
                    [hud hideAnimated:YES afterDelay:2];
                }];
            }
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
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        //        NSString *resultStr = [NSString stringWithFormat:@"%ld",(unsigned long)data.length];
        
        NSDictionary *  dic = [[editingInfo objectForKey:@"UIImagePickerControllerMediaMetadata"] objectForKey:@"{Exif}"];
        NSString * time = [NSString stringWithFormat:@"%@",[NSDate date]];
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
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
        NSString * Createtime = [formatter stringFromDate:date];
        Createtime=[Createtime stringByReplacingOccurrencesOfString:@" " withString:@"T"];
        NSLog(@"Createtime->%@",Createtime);
        _keepInfo=[[NSMutableDictionary alloc]init];
        
        [_keepInfo setValue:_name forKey:@"selectType"];
        [_keepInfo setValue:imgID forKey:@"imgID"];
        [_keepInfo setValue:_model.ID   forKey:@"storeCode"];
        [_keepInfo setValue:userID      forKey:@"userID"];
        [_keepInfo setValue:identifier  forKey:@"identifier"];
        [_keepInfo setValue:imageType   forKey:@"imageType"];
        [_keepInfo setValue:Createtime  forKey:@"Createtime"];
        [_keepInfo setValue:imageUrl    forKey:@"imageUrl"];
        
        
        [_keepInfo setValue:[baseDic valueForKey:@"lng"] forKey:@"Longitude"];
        [_keepInfo setValue:[baseDic valueForKey:@"lat"] forKey:@"Latitude"];
        //        }
        //        if ([_keepInfo valueForKey:@"Longitude"]) {
        [KeepSignInInfo keepPhotoWithDictionary:_keepInfo];
        NSLog(@"home-->\n%@",NSHomeDirectory());
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
    NSData * photoData = UIImageJPEGRepresentation(newImage,0.5);
    [photoData writeToFile:writePath atomically:NO];
    
    
    if (takephotoBtn) {
        [self imgUI];
    }
    else{
    //    dataArr=[KeepSignInInfo selectPhotoWithType:_name andId:_model.Code];
    photoArr=[KeepSignInInfo selectPhotoWithType:@"imgDoor" andId:_model.ID];
    
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    [baseDic setValue:userid forKey:@"userid"];
//    [baseDic setValue:_model.ID forKey:@"cfgID"];
    
    [baseDic setValue:_model.ID forKey:@"storeID"];
    
      //  hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set the label text.
     //   hud.label.text = @"签到中,请稍候...";
        
    
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

-(void)takePhoto:(UIButton *)btns
{
    takephotoBtn=YES;
    _name=[NSString stringWithFormat:@"%@",imgArr[btns.tag-300]];
    imgID=[NSString stringWithFormat:@"%@",imgCountArr[btns.tag-300]];
    
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    //imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.delegate=self;
    imagePicker.allowsEditing=YES;
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
