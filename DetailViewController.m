//
//  DetailViewController.m
//  Unicharm
//
//  Created by EssIOS on 16/8/5.
//  Copyright © 2016年 ljh. All rights reserved.
//

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define NULLString(string) ((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil) || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)

#define startHeight 100

#import "DetailViewController.h"
#import "NetWork.h"

#import "KeepSignInInfo.h"
#import "StoreMD.h"
#import "keepLocationInfo.h"

#import "PhotoModel.h"
#import "ListViewController.h"
#import "MBProgressHUD.h"
#import "BMapKit.h"
#import "Base64.h"
@interface DetailViewController ()
{
    UILabel *lab1;
    UILabel *lab2;
    UILabel *lab3;
    UILabel *lab4;
    UILabel *lab5;
    UILabel *lab6;
    
    UITextField *tf1;
    UITextField *tf2;
    UITextField *tf3;
    UITextField *tf4;
    UITextField *tf5;
    UITextField *tf6;
    
    NSMutableDictionary *dataDic;
    
    UIScrollView *smallScr;
    UIScrollView *smallScr1;
    
    NSMutableArray *dataArr;
    NSMutableArray *photoArr;
    NSMutableArray *photoArr2;
    
    NSMutableDictionary     * _keepInfo;
    
    
    UIScrollView *otherScrollVC;
    
    UISegmentedControl *segmentCtr;
    
    bool isSaved;
    UIAlertController *alertC;
    MBProgressHUD *hud;
    
    UISegmentedControl *seg1;
    UISegmentedControl *seg2;
    CLLocationManager *locationManager;

    NSMutableDictionary *locationDic;
}

@end

@implementation DetailViewController
-(void)viewDidAppear:(BOOL)animated
{

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    locationDic=[[NSMutableDictionary alloc]init];
    
    if (_model.isdsr) {
        _name=@"dsr";
    }
    else
    {
        _name=@"qihua";
    }
    
    [self location];

    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
    if ([_model.PlanType isEqualToString:@"03"]) {
        
        [self initTG];
        _type=@"tg";

    }
    else if([_model.PlanType isEqualToString:@"01"])
    {
        [self initList];
        _type=@"list";
    }
    else if([_model.PlanType isEqualToString:@"04"])
    {
        [self initDoor];
        _type=@"door";
    }
    else if([_model.PlanType isEqualToString:@"00"])
    {
        [self initOther];
        _type=@"other";
    }
    NSLog(@"_KPICategory %@",_KPICategory);
    
    NSLog(@"_KPICategory %@",_model.KPICategory);
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(10, 65, WIDTH-20, 35);
    label.text=[NSString stringWithFormat:@"KPI商品大类"];
    if (!NULLString(_model.KPICategory)) {
    label.text=[NSString stringWithFormat:@"KPI商品大类:%@",_model.KPICategory];
    }
    
    label.textAlignment=NSTextAlignmentCenter;
        label.textAlignment=NSTextAlignmentCenter;
    label.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:label];
    
    photoArr=[KeepSignInInfo selectPhotoWithType:_name andId:_model.Id andCfgID:_model.storeID];
    photoArr2=[KeepSignInInfo selectPhotoWithType:_name andId:_model.Id andCfgID:_model.storeID];
    
    [self initConfirmBtn];
    [self uiConfig];
    
    
}

-(void)dismiss
{
    [self.view endEditing:YES];
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    
//    if ([_model.PlanType isEqualToString:@"03"]) {
//        
//        [self initTG];
//        _type=@"tg";
//    }
//    else if([_model.PlanType isEqualToString:@"01"])
//    {
//        [self initList];
//        _type=@"list";
//    }
//    else if([_model.PlanType isEqualToString:@"04"])
//    {
//        [self initDoor];
//        _type=@"door";
//    }
//    
//    photoArr=[KeepSignInInfo selectPhotoWithType:@"照片" andId:_model.Id];
//    photoArr2=[KeepSignInInfo selectPhotoWithType:@"照片" andId:_model.Id];
//    
//    [self initConfirmBtn];
//    [self uiConfig];
//}
-(void)initConfirmBtn
{

    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(50, 450, WIDTH-100, 40);
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}
//提交
-(void)btnClick:(UIButton *)btn
{
    if ([_status isEqualToString:@"unchange"]) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set the label text.
//        hud.label.text = @"上传数据中,请稍候...";
        
//        [self uploadPic];
    }
    else
    {

   
    if ([_type isEqualToString:@"tg"]) {


            if ([tf1.text isEqualToString:@""]||[tf2.text isEqualToString:@""]) {
    
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示:" message:@"请将数据填写完整!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil, nil];
                alert.delegate=self;
                [alert show];
                
                return;
            }
        }
    else if([_type isEqualToString:@"list"])
    {

    }

        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set the label text.
        hud.label.text = @"上传数据中,请稍候...";
        
//        [self uploadPic];
        
 
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self uploadData];
    });

         }



}
-(void)uploadData
{
    if ([_type isEqualToString:@"tg"]) {
        

   
        dataDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:tf1.text,@"ShelfSectionNumber1",tf2.text,@"ShelfSectionNumber2",lab6.text,@"ShelfSectionNumber3", nil];
        [dataDic setValue:@"" forKey:@"TG"];
        [dataDic setValue:@"" forKey:@"ShopBuiltForm"];
        [dataDic setValue:@"" forKey:@"Coaming"];
        [dataDic setValue:_model.Expand1 forKey:@"Expand1"];
        [dataDic setValue:_model.Expand2 forKey:@"Expand2"];
        
      
    }
    else if([_type isEqualToString:@"list"])
    {
        
//        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//        // Set the label text.
//        hud.label.text = @"上传数据中,请稍候...";
        
        dataDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"ShelfSectionNumber1",@"",@"ShelfSectionNumber2",@"",@"ShelfSectionNumber3", nil];
        [dataDic setValue:_model.TG forKey:@"TG"];
        [dataDic setValue:@"" forKey:@"ShopBuiltForm"];
        [dataDic setValue:_model.Coaming forKey:@"Coaming"];
    }
    else if([_type isEqualToString:@"door"])

    {
        //        dataDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:tf1.text,@"ShelfSectionNumber1", nil];
        NSMutableString *styleStr=[NSMutableString string];
        
        NSArray *arr=@[@"货架装饰",@"长期形象TG",@"形象端架",@"包柱"];
//        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//        // Set the label text.
//        hud.label.text = @"上传数据中,请稍候...";
        for (int i=0; i<4; i++) {
            UIButton *btn=[self.view viewWithTag:201+i];
            if (btn.selected) {
                if (styleStr.length==0) {
                    [styleStr appendString:[NSString stringWithFormat:@"%@",arr[i]]];
                }
                else{
                    [styleStr appendString:[NSString stringWithFormat:@",%@",arr[i]]];
                }
                
            }
        }
        NSLog(@"%@",styleStr);
        dataDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"ShelfSectionNumber1",@"",@"ShelfSectionNumber2",@"",@"ShelfSectionNumber3", nil];
        [dataDic setValue:@"" forKey:@"TG"];
//        [dataDic setValue:styleStr forKey:@"ShopBuiltForm"];
#pragma mark--
        [dataDic setValue:_model.ShopBuiltForm forKey:@"ShopBuiltForm"];
        
        [dataDic setValue:@"" forKey:@"Coaming"];
    }
    else
    {
        dataDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"ShelfSectionNumber1",@"",@"ShelfSectionNumber2",@"",@"ShelfSectionNumber3", nil];

    }
    NSLog(@"id-->>%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"]);

    [dataDic setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"] forKey:@"UploadUserId"];
    [dataDic setValue:@"0" forKey:@"UploadUserType"];
    
    
    [dataDic setValue:_model.storeID forKey:@"ID"];
    

    
    NSArray *arr=[NSArray arrayWithObject:dataDic];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonString);
    NSString *urlStr;
    if (_model.isdsr) {
        urlStr=[NSString stringWithFormat:@"http://unicharm.egocomm.cn/service/AppWebServicedsr.asmx"];
    }
    else
    {
        urlStr=[NSString stringWithFormat:@"http://unicharm.egocomm.cn/service/appwebservice.asmx"];
    }
    
    [NetWork UploadDataDataWithDic:jsonString withAddress:urlStr withBlock:^(NSDictionary *result, NSError *error) {

//        dispatch_async(dispatch_get_main_queue(), ^{
//            [hud hideAnimated:YES];
//        });
        hud.label.text=@"上传成功";
        [hud hideAnimated:YES afterDelay:2];
        _status=@"unchange";
        
    } withBlock:^(NSString *result, NSError *error) {
        hud.label.text=@"上传失败,请重试";
        [hud hideAnimated:YES afterDelay:2];
    }];
    
    
}

-(void)uploadPic
{

    
    //NSMutableArray * picArr = [KeepSignInInfo selectPatrolPictureWithID:_model.ID];
    NSMutableArray * picArr = [KeepSignInInfo selectlPictureWithtype:_name andWithID:_model.Id];
    if (picArr.count==0) {
        hud.label.text=@"无照片";
        [hud hideAnimated:YES afterDelay:2];
    }
    
    NSString *userid=[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    
    for (int i=0; i<picArr.count; i++) {
        
        NSDictionary *picDic=[NSDictionary dictionaryWithObjectsAndKeys:[picArr[i] Longitude],@"lng",[picArr[i] Latitude],@"lat",userid,@"userid",_model.storeID,@"cfgId",[picArr[i] imageUrl],@"base64Str",[picArr[i] Createtime],@"Createtime",nil];
        
        NSLog(@"%@",picDic);
        
        NSString *urlStr;
        if (_model.isdsr) {
            urlStr=[NSString stringWithFormat:@"http://unicharm.egocomm.cn/service/AppWebServicedsr.asmx"];
        }
        else
        {
            urlStr=[NSString stringWithFormat:@"http://unicharm.egocomm.cn/service/appwebservice.asmx"];
        }
        NSLog(@"url-->\n%@",urlStr);
        [NetWork UploadPicWithDic:picDic withAddress:urlStr withBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"ErrorCode"] intValue]==0) {

            [KeepSignInInfo deletePatrolPictureWithImageUrl:[picArr[i] imageUrl]];

            NSString * imageUrl = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),[picArr[i] imageUrl]];
            [[NSFileManager defaultManager] removeItemAtPath:imageUrl error:nil];
            photoArr=[KeepSignInInfo selectPhotoWithType:_name andId:_model.Id];
            
            [self uiConfig];
            NSLog(@"img success");
            hud.label.text=@"照片上传成功";
            [hud hideAnimated:YES afterDelay:2];
            }
            else{
                hud.label.text=@"上传失败,请重试";
                [hud hideAnimated:YES afterDelay:2];
            }
            
        } withBlock:^(NSString *result, NSError *error) {
            hud.label.text=@"上传失败,请重试";
            [hud hideAnimated:YES afterDelay:2];
        }];
    }
 
    
}
-(void)initOther
{
    
}
-(void)initTG
{
    lab1=[[UILabel alloc]init];
    lab1.frame=CGRectMake(10, startHeight, WIDTH/2, 35);
    lab1.text=[NSString stringWithFormat:@"店内货架节数"];
    [self.view addSubview:lab1];
    
    lab2=[[UILabel alloc]init];
    lab2.frame=CGRectMake(10, startHeight+50, WIDTH/2, 35);
    lab2.text=[NSString stringWithFormat:@"我司货架节数"];
    [self.view addSubview:lab2];
    
    lab3=[[UILabel alloc]init];
    lab3.frame=CGRectMake(10, startHeight+100, WIDTH/2, 35);
    lab3.text=[NSString stringWithFormat:@"我司货架节数(增加到)"];
    lab3.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:lab3];
    
    
    lab4=[[UILabel alloc]init];
    lab4.frame=CGRectMake(10, startHeight+150, WIDTH/2, 35);
    lab4.text=[NSString stringWithFormat:@"我司货架横向"];
    [self.view addSubview:lab4];
    
    lab5=[[UILabel alloc]init];
    lab5.frame=CGRectMake(10, startHeight+200, WIDTH/2, 35);
    lab5.text=[NSString stringWithFormat:@"我司货架纵向"];
//    lab5.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:lab5];
    
    
    tf1=[[UITextField alloc]init];
    tf1.frame=CGRectMake(WIDTH/2+10, startHeight+5, WIDTH/2-20, 35);
    tf1.delegate=self;
    tf1.tag=101;
    tf1.keyboardType=UIKeyboardTypeDecimalPad;
    tf1.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:tf1];
    
    tf2=[[UITextField alloc]init];
    tf2.frame=CGRectMake(WIDTH/2+10, startHeight+50+5, WIDTH/2-20, 35);
    tf2.delegate=self;
    tf2.tag=102;
    tf2.borderStyle=UITextBorderStyleRoundedRect;
    tf2.keyboardType=UIKeyboardTypeDecimalPad;
    [self.view addSubview:tf2];
    
    tf3=[[UITextField alloc]init];
    tf3.frame=CGRectMake(WIDTH/2+10-50, startHeight+100+50, WIDTH/2-20, 35);
    tf3.delegate=self;
    tf3.tag=103;
    tf3.borderStyle=UITextBorderStyleRoundedRect;
    tf3.keyboardType=UIKeyboardTypeDecimalPad;
    tf3.userInteractionEnabled = NO;
    tf3.text=@"0";
//    [self.view addSubview:tf3];
    
    
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"合格",@"不合格",nil];
    
    seg1=[[UISegmentedControl alloc]initWithItems:segmentedArray];
    seg1.frame=CGRectMake(WIDTH/2-10, startHeight+150, WIDTH/2, 40);
    seg1.tag=2001;
    [seg1 addTarget:self action:@selector(segChoose:) forControlEvents:UIControlEventValueChanged];

    [self.view addSubview:seg1];
    
    seg2=[[UISegmentedControl alloc]initWithItems:segmentedArray];
    seg2.frame=CGRectMake(WIDTH/2-10, startHeight+200, WIDTH/2, 40);
    seg2.tag=2002;
    [seg2 addTarget:self action:@selector(segChoose:) forControlEvents:UIControlEventValueChanged];

    [self.view addSubview:seg2];
//    seg1.selectedSegmentIndex=0;
//    seg2.selectedSegmentIndex=0;
    if (_model.Expand1&&![_model.Expand1 isKindOfClass:[NSNull class]]) {
        if ([_model.Expand1 isEqualToString:@"不合格"]) {
            seg1.selectedSegmentIndex=1;
            
        }
        else
        {
        
            seg1.selectedSegmentIndex=0;

        }
    }
    
    if (_model.Expand2&&![_model.Expand2 isKindOfClass:[NSNull class]]) {
        if ([_model.Expand2 isEqualToString:@"不合格"]) {
            seg2.selectedSegmentIndex=1;
            
        }
        else
        {
            
            seg2.selectedSegmentIndex=0;
            
        }
    }
    
    if ([_status isEqualToString:@"unchange"]) {
        NSLog(@"unchange");
        seg1.momentary = YES; //默认为NO
        seg2.momentary = YES; //默认为NO
    }
    
    
    lab6=[[UILabel alloc]init];
    lab6.frame=CGRectMake(WIDTH/2+10, startHeight+100, WIDTH/2-20, 40);
//    label.text=[NSString stringWithFormat:<#(nonnull NSString *), ...#>];
    lab6.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:lab6];
    
    NSLog(@"%@ %@ %@",_model.ShelfSectionNumber1,_model.ShelfSectionNumber2,_model.ShelfSectionNumber3);
    
    if (_model.ShelfSectionNumber1&&![_model.ShelfSectionNumber1 isKindOfClass:[NSNull class]]) {
        tf1.text=[NSString stringWithFormat:@"%@",_model.ShelfSectionNumber1];
    }
    if (_model.ShelfSectionNumber2&&![_model.ShelfSectionNumber2 isKindOfClass:[NSNull class]]) {
        tf2.text=[NSString stringWithFormat:@"%@",_model.ShelfSectionNumber2];
    }
    if (_model.ShelfSectionNumber3&&![_model.ShelfSectionNumber3 isKindOfClass:[NSNull class]]) {
        lab6.text=[NSString stringWithFormat:@"%@",_model.ShelfSectionNumber3];
    }
    
    
    
}
-(void)segChoose:(UISegmentedControl *)seg
{
    
    
    if ([_status isEqualToString:@"unchange"]) {
        NSLog(@"unchange");
//        seg.momentary = YES; //默认为NO
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set the label text.
        hud.label.text = @"审核状态中数据无法修改";
        
        [hud hideAnimated:YES afterDelay:1];
        return;
        
    }
    
    NSInteger Index = seg.selectedSegmentIndex;
    
    
    NSString *value=seg.selectedSegmentIndex==0?@"合格":@"不合格";
    
    [_model setValue:value forKey:[NSString stringWithFormat:@"Expand%ld",seg.tag-2000]];

    
    
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");
    
    if ([_status isEqualToString:@"unchange"]) {
        NSLog(@"unchange");
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set the label text.
        hud.label.text = @"审核状态中数据无法修改";
        
        [hud hideAnimated:YES afterDelay:1];
        return NO;
        
    }
    return YES;
    
}
-(void)initList
{
    
    lab1=[[UILabel alloc]init];
    lab1.frame=CGRectMake(10, startHeight+20, WIDTH/2, 35);
    lab1.text=[NSString stringWithFormat:@"TG个数:"];
//    lab1.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:lab1];
    
    lab2=[[UILabel alloc]init];
    lab2.frame=CGRectMake(10, startHeight+70, WIDTH/2, 35);
    lab2.text=[NSString stringWithFormat:@"围板个数:"];
//    lab2.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:lab2];

//    if (NULLString(_model.TG)) {
//        
//        
//        lab1.text=[NSString stringWithFormat:@"TG个数:%@",_model.TG];
//            
//    }
//    if (NULLString(_model.Coaming)) {
//        lab2.text=[NSString stringWithFormat:@"围板个数:%@",_model.Coaming];
//        
//    }


    lab3=[[UILabel alloc]init];
    lab3.frame=CGRectMake(WIDTH/2+10, startHeight+20, WIDTH/2-20, 40);
//    lab3.text=[NSString stringWithFormat:@"TG个数"];
    [self.view addSubview:lab3];
    
    lab4=[[UILabel alloc]init];
    lab4.frame=CGRectMake(WIDTH/2+10, startHeight+70, WIDTH/2-20, 40);
//    lab4.text=[NSString stringWithFormat:@"围板个数"];
    [self.view addSubview:lab4];
    
    NSString *TGStr=[NSString stringWithFormat:@"%@",_model.TG];
    NSString *CoamingStr=[NSString stringWithFormat:@"%@",_model.Coaming];
    
    if (!NULLString(TGStr)) {
        
        lab3.text=[NSString stringWithFormat:@"%@",_model.TG];
        
    }
    else
    {
        lab3.text=[NSString stringWithFormat:@""];
    }
    if (!NULLString(CoamingStr)) {
        lab4.text=[NSString stringWithFormat:@"%@",_model.Coaming];
        
    }
    else
    {
        lab4.text=[NSString stringWithFormat:@""];
    }
    
    if (_model.TG&&![_model.TG isKindOfClass:[NSNull class]]) {
//        lab6.text=[NSString stringWithFormat:@"%@",_model.TG];
        NSLog(@"111222TG");
    }
    /*
    tf1=[[UITextField alloc]init];
    tf1.frame=CGRectMake(WIDTH/2+10, startHeight, WIDTH/2-20, 40);
    tf1.delegate=self;
    tf1.tag=101;
    tf1.borderStyle=UITextBorderStyleRoundedRect;
    tf1.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:tf1];
    
    tf2=[[UITextField alloc]init];
    tf2.frame=CGRectMake(WIDTH/2+10, startHeight+50, WIDTH/2-20, 40);
    tf2.delegate=self;
    tf2.tag=102;
    tf2.borderStyle=UITextBorderStyleRoundedRect;
    tf2.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:tf2];
    
    */
//    if ([_model.TG isKindOfClass:[NSNull class]]) {
//        NSLog(@"123");
//    }
//    if (_model.TG&&![_model.TG isKindOfClass:[NSNull class]]) {
//     
//        tf1.text=[NSString stringWithFormat:@"%@",_model.TG];
//    }
//    if (_model.Coaming&&![_model.Coaming isKindOfClass:[NSNull class]]) {
//        tf2.text=[NSString stringWithFormat:@"%@",_model.Coaming];
//    }
    
    
}
-(void)initDoor
{
    lab1=[[UILabel alloc]init];
    lab1.frame=CGRectMake(10, startHeight+20, WIDTH/2, 35);
//    lab1.text=[NSString stringWithFormat:@"店建形式"];
    lab1.textAlignment=NSTextAlignmentCenter;
    lab1.text=[NSString stringWithFormat:@"店建形式:"];

    lab1.numberOfLines=0;
    lab1.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:lab1];
    
    
    lab3=[[UILabel alloc]init];
    lab3.frame=CGRectMake(WIDTH/2+10, startHeight+20, WIDTH/2-20, 40);
    //    lab3.text=[NSString stringWithFormat:@"TG个数"];
    NSLog(@"shop--->%@",_model.ShopBuiltForm);
    
    if (!NULLString(_model.ShopBuiltForm)) {
        lab3.text=[NSString stringWithFormat:@"%@",_model.ShopBuiltForm];
    }
    [self.view addSubview:lab3];
    
    /*
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(20, startHeight+50, 30,30);
    [btn setBackgroundImage:[UIImage imageNamed:@"check_box_normal_n.png"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"check_box_select_n.png"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClicks:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=201;
    [self.view addSubview:btn];

    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(20, startHeight+100, 30,30);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"check_box_normal_n.png"] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"check_box_select_n.png"] forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(btnClicks:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag=202;
    [self.view addSubview:btn2];
    
    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame=CGRectMake(20, startHeight+150, 30,30);
    [btn3 setBackgroundImage:[UIImage imageNamed:@"check_box_normal_n.png"] forState:UIControlStateNormal];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"check_box_select_n.png"] forState:UIControlStateSelected];
    [btn3 addTarget:self action:@selector(btnClicks:) forControlEvents:UIControlEventTouchUpInside];
    btn3.tag=203;
    [self.view addSubview:btn3];
    
    UIButton *btn4=[UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame=CGRectMake(20, startHeight+200, 30,30);
    [btn4 setBackgroundImage:[UIImage imageNamed:@"check_box_normal_n.png"] forState:UIControlStateNormal];
    [btn4 setBackgroundImage:[UIImage imageNamed:@"check_box_select_n.png"] forState:UIControlStateSelected];
    [btn4 addTarget:self action:@selector(btnClicks:) forControlEvents:UIControlEventTouchUpInside];
    btn4.tag=204;
    [self.view addSubview:btn4];

    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(80, startHeight+50-10, WIDTH-100, 40);
    label.text=[NSString stringWithFormat:@"货架装饰"];
    [self.view addSubview:label];
    
    UILabel *label2=[[UILabel alloc]init];
    label2.frame=CGRectMake(80, startHeight+100-10, WIDTH-100, 40);
    label2.text=[NSString stringWithFormat:@"长期形象TG"];
    [self.view addSubview:label2];
    
    UILabel *label3=[[UILabel alloc]init];
    label3.frame=CGRectMake(80, startHeight+150-10, WIDTH-100, 40);
    label3.text=[NSString stringWithFormat:@"形象端架"];
    [self.view addSubview:label3];
    
    UILabel *label4=[[UILabel alloc]init];
    label4.frame=CGRectMake(80, startHeight+200-10, WIDTH-100, 40);
    label4.text=[NSString stringWithFormat:@"包柱"];
    [self.view addSubview:label4];
    
    if (_model.ShopBuiltForm&&![_model.ShopBuiltForm isKindOfClass:[NSNull class]]) {
        
        lab1.text=[NSString stringWithFormat:@"店建形式:%@",_model.ShopBuiltForm];
        NSArray *arr=[_model.ShopBuiltForm componentsSeparatedByString:@","];
        for (int i=0; i<arr.count; i++) {
            if ([arr[i] isEqualToString:@"货架装饰"]) {
                btn.selected=YES;
            }
            if ([arr[i] isEqualToString:@"长期形象TG"]) {
                btn2.selected=YES;
            }
            if ([arr[i] isEqualToString:@"形象端架"]) {
                btn3.selected=YES;
            }
            if ([arr[i] isEqualToString:@"包柱"]) {
                btn4.selected=YES;
            }
        }
    }
    
    btn.userInteractionEnabled=NO;
    btn2.userInteractionEnabled=NO;
    btn3.userInteractionEnabled=NO;
    btn4.userInteractionEnabled=NO;
    */

}
-(void)btnClicks:(UIButton *)btn
{
//    btn.selected=!btn.selected;
}
-(void)uiConfig
{
    [smallScr1 removeFromSuperview];
    smallScr1=[[UIScrollView alloc]init];
    
    smallScr1.tag=501;
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(0, 360, 100, 40);
   
    //    label.backgroundColor=[UIColor redColor];
    label.text=[NSString stringWithFormat:@"拍照:"];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    smallScr1.frame=CGRectMake(80, 360, 305, 90);
    
    smallScr.backgroundColor=[UIColor grayColor];
    
    smallScr1.contentSize=CGSizeMake(90 *photoArr.count+80, 90);
    [self.view addSubview:smallScr1];
    
    if ([_type isEqualToString:@"list"]) {
       label.frame=CGRectMake(0, 250, 100, 40);
        smallScr1.frame=CGRectMake(80, 210, 305, 90);
    }
    if ([_type isEqualToString:@"door"]) {
        label.frame=CGRectMake(0, 250, 100, 40);
        smallScr1.frame=CGRectMake(80, 210, 305, 90);
    }
    
    if ([_type isEqualToString:@"other"]) {
        label.frame=CGRectMake(0, 180, 100, 40);
        smallScr1.frame=CGRectMake(80, 140, 305, 90);
    }
    
    UIButton *Photobtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    Photobtn1.frame=CGRectMake(0, 30, 60, 60);
    //        [Photobtn setTitle:@"拍照" forState:UIControlStateNormal];
    //        [Photobtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [Photobtn1 setBackgroundImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    //        [Photobtn setBackgroundColor:[UIColor redColor]];
    Photobtn1.tag=301;
    [Photobtn1 addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [smallScr1 addSubview:Photobtn1];
    for (int j=0; j<photoArr.count; j++) {
        
        
        
        UIImageView *imgV=[[UIImageView alloc]init];
        imgV.frame=CGRectMake(80+90*j, 0, 80, 80);
        
        [imgV setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),[photoArr[j] objectForKey:@"imageurl"]]]];
        //        imgV.backgroundColor=[UIColor redColor];
        //            imgV.backgroundColor=[UIColor grayColor];
        UITapGestureRecognizer *longPress=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDetail:)];
        [imgV addGestureRecognizer:longPress];
        imgV.userInteractionEnabled=YES;
        [smallScr1 addSubview:imgV];
        
    }
    
    
    
    [smallScr removeFromSuperview];
    smallScr=[[UIScrollView alloc]init];
    smallScr.tag=502;
    // smallScr.backgroundColor=[UIColor grayColor];
    smallScr.frame=CGRectMake(10, 350, 305, 90);
    
    smallScr.contentSize=CGSizeMake(90 *photoArr2.count+80, 90);
//    [self.view addSubview:smallScr];
    UIButton *Photobtn=[UIButton buttonWithType:UIButtonTypeCustom];
    Photobtn.frame=CGRectMake(0, 0, 60, 60);
    //        [Photobtn setTitle:@"拍照" forState:UIControlStateNormal];
    //        [Photobtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [Photobtn setBackgroundImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    //        [Photobtn setBackgroundColor:[UIColor redColor]];
    Photobtn.tag=302;
    [Photobtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [smallScr addSubview:Photobtn];
    for (int j=0; j<photoArr2.count; j++) {
        
        
        
        UIImageView *imgV=[[UIImageView alloc]init];
        imgV.frame=CGRectMake(80+90*j, 0, 80, 80);
        
        [imgV setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),photoArr2[j]]]];
        //        imgV.backgroundColor=[UIColor redColor];
        //            imgV.backgroundColor=[UIColor grayColor];
        UITapGestureRecognizer *longPress=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDetail:)];
        [imgV addGestureRecognizer:longPress];
        imgV.userInteractionEnabled=YES;
        [smallScr addSubview:imgV];
        
    }
    
    
    
    
    
}
-(void)takePhoto:(UIButton *)btn
{
    if ([_status isEqualToString:@"unchange"]) {
        NSLog(@"unchange");
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set the label text.
        hud.label.text = @"审核状态中数据无法修改";
        
        [hud hideAnimated:YES afterDelay:1];
        return ;
        
    }
    
    if (_model.isdsr) {
        _name=@"dsr";
    }
    else
    {
        _name=@"qihua";
    }
    
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    
//        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    //imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    imagePicker.delegate=self;
    imagePicker.allowsEditing=YES;
    
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
    
    
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存到相册失败" ;
    }else{
        msg = @"保存到相册成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil];
    [alert show];
    
    [UIView animateWithDuration:8 animations:^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    }];
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
        NSString * time = [NSDate date];
        //        time = resultStr;
        NSString * imageUrl  =[NSString stringWithFormat:@"%@%@.jpg",time,userID];
        //        [_loMar stopUpdatingLocation];
        
        NSDictionary * imageDic = @{@"image":image,@"imageurl":imageUrl};
        
        //        [NSThread detachNewThreadSelector:@selector(useImage:) toTarget:self withObject:imageDic];
        [self useImage:imageDic];
        
        
        NSString * identifier   = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSString * imageType = @"JPG";
        
        NSDate * date = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
        NSString * Createtime = [formatter stringFromDate:date];
        Createtime=[Createtime stringByReplacingOccurrencesOfString:@" " withString:@"T"];

        _keepInfo=[[NSMutableDictionary alloc]init];
        
//        if (_model.isdsr) {
//            _name=@"dsr";
//        }
//        else
//        {
//        _name=@"qihua";
//        }
        
        [_keepInfo setValue:_name forKey:@"selectType"];
        [_keepInfo setValue:_model.Id   forKey:@"storeCode"];
        
        [_keepInfo setValue:userID      forKey:@"userID"];
        [_keepInfo setValue:identifier  forKey:@"identifier"];
        [_keepInfo setValue:imageType   forKey:@"imageType"];
        [_keepInfo setValue:Createtime  forKey:@"Createtime"];
        [_keepInfo setValue:imageUrl    forKey:@"imageUrl"];
//        storeID
        [_keepInfo setValue:_model.storeID   forKey:@"imgID"];
        
        
        
        StoreMD * store = [keepLocationInfo selectLocationLastData];
        //        [_keepInfo setValue:store.Latitude forKey:@"Latitude"];
        [_keepInfo setValue:[locationDic objectForKey:@"lng"] forKey:@"Longitude"];
        [_keepInfo setValue:[locationDic objectForKey:@"lat"] forKey:@"Latitude"];
        [_keepInfo setValue:store.timeStamo forKey:@"LocationTtime"];
        //        }
        //        if ([_keepInfo valueForKey:@"Longitude"]) {
        [KeepSignInInfo keepPhotoWithDictionary:_keepInfo];
        [self useImage:imageDic];
        
    }];
    
    
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
    
    //    dataArr=[KeepSignInInfo selectPhotoWithType:_name andId:_model.Code];
    photoArr=[KeepSignInInfo selectPhotoWithType:_name andId:_model.Id andCfgID:_model.storeID];
    photoArr2=[KeepSignInInfo selectPhotoWithType:_name andId:_model.Id andCfgID:_model.storeID];
    
    
    
    [self uiConfig];
}
-(void)toDetail:(UITapGestureRecognizer *)tap
{
//    NSLog(@"%ld",tap.view.superview.tag);
    NSLog(@"%d",tap.view.superview.tag-500);
    switch (tap.view.superview.tag-500) {
        case 1:
            dataArr=photoArr;
            break;
        case 2:
            dataArr=photoArr2;
            break;
            
        default:
            break;
    }
    
    self.tabBarController.tabBar.hidden = YES;
    otherScrollVC=[[UIScrollView alloc]init];
    otherScrollVC.frame=CGRectMake(0, 104, WIDTH, 464);
    otherScrollVC.contentSize=CGSizeMake(WIDTH*dataArr.count, 400);
    NSLog(@"count-->>%lu",(unsigned long)dataArr.count);
    otherScrollVC.pagingEnabled=YES;
    for (int i=0; i<dataArr.count; i++) {
        UIImageView *imgV=[[UIImageView alloc]init];
        imgV.frame=CGRectMake(10+WIDTH*i, 0, WIDTH-20, 400);
        [otherScrollVC addSubview:imgV];
        imgV.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),[dataArr[i] objectForKey:@"imageurl"]]];
        imgV.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
        [imgV addGestureRecognizer:tap];
        
    }
    
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view addSubview:otherScrollVC];
        
    }];
}
-(void)dismiss:(UITapGestureRecognizer *)tap
{
    [otherScrollVC removeFromSuperview];
    
    //    self.tabBarController.tabBar.hidden = NO;
}
-(void)backBtnClick:(UIButton *)btn
{
    
    if (!isSaved) {
        //        priceTextField.text=@"0";
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示:" message:@"数据未保存,是否确认退出?" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil, nil];
        alert.delegate=self;
        [alert show];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        return;
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    
    [locationDic setValue:latitude forKey:@"lat"];
    [locationDic setValue:longitude forKey:@"lng"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
