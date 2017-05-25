//
//  NewViewController.m
//  Unicharm
//
//  Created by EssIOS on 16/8/18.
//  Copyright © 2016年 ljh. All rights reserved.
//

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#import "NewViewController.h"
#import "NetWork.h"

#import "KeepSignInInfo.h"
#import "StoreMD.h"
#import "keepLocationInfo.h"

#import "PhotoModel.h"
#import "ListViewController.h"
#import "MBProgressHUD.h"
#define startHeight 64

@interface NewViewController ()
{
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
    
    
}
@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"11-->>%@",_model.ID);
    photoArr=[KeepSignInInfo selectPhotoWithType:@"照片" andId:_model.ID];
    
    
    [self initConfirmBtn];
    [self uiConfig];
    [self initDoor];
}

-(void)initDoor
{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(20, startHeight+50, 40,40);
    [btn setBackgroundImage:[UIImage imageNamed:@"check_box_normal_n.png"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"check_box_select_n.png"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClicks:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=201;
    [self.view addSubview:btn];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(20, startHeight+100, 40,40);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"check_box_normal_n.png"] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"check_box_select_n.png"] forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(btnClicks:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag=202;
    [self.view addSubview:btn2];
    
//    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn3.frame=CGRectMake(20, startHeight+150, 30,30);
//    [btn3 setBackgroundImage:[UIImage imageNamed:@"check_box_normal_n.png"] forState:UIControlStateNormal];
//    [btn3 setBackgroundImage:[UIImage imageNamed:@"check_box_select_n.png"] forState:UIControlStateSelected];
//    [btn3 addTarget:self action:@selector(btnClicks:) forControlEvents:UIControlEventTouchUpInside];
//    btn3.tag=203;
//    [self.view addSubview:btn3];
//    
//    UIButton *btn4=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn4.frame=CGRectMake(20, startHeight+200, 30,30);
//    [btn4 setBackgroundImage:[UIImage imageNamed:@"check_box_normal_n.png"] forState:UIControlStateNormal];
//    [btn4 setBackgroundImage:[UIImage imageNamed:@"check_box_select_n.png"] forState:UIControlStateSelected];
//    [btn4 addTarget:self action:@selector(btnClicks:) forControlEvents:UIControlEventTouchUpInside];
//    btn4.tag=204;
//    [self.view addSubview:btn4];
    
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(80, startHeight+50-10, WIDTH-100, 40);
    label.text=[NSString stringWithFormat:@"买赠"];
    [self.view addSubview:label];
    
    UILabel *label2=[[UILabel alloc]init];
    label2.frame=CGRectMake(80, startHeight+100-10, WIDTH-100, 40);
    label2.text=[NSString stringWithFormat:@"派发"];
    [self.view addSubview:label2];
//    
//    UILabel *label3=[[UILabel alloc]init];
//    label3.frame=CGRectMake(80, startHeight+150-10, WIDTH-100, 40);
//    label3.text=[NSString stringWithFormat:@"长期形象端架"];
//    [self.view addSubview:label3];
//    
//    UILabel *label4=[[UILabel alloc]init];
//    label4.frame=CGRectMake(80, startHeight+200-10, WIDTH-100, 40);
//    label4.text=[NSString stringWithFormat:@"排列包柱"];
//    [self.view addSubview:label4];
    
//    if (_model.ShopBuiltForm&&![_model.ShopBuiltForm isKindOfClass:[NSNull class]]) {
//        NSArray *arr=[_model.ShopBuiltForm componentsSeparatedByString:@","];
//        for (int i=0; i<arr.count; i++) {
//            if ([arr[i] isEqualToString:@"买赠"]) {
//                btn.selected=YES;
//            }
//            if ([arr[i] isEqualToString:@"派发"]) {
//                btn2.selected=YES;
//            }
////            if ([arr[i] isEqualToString:@"长期形象端架"]) {
////                btn3.selected=YES;
////            }
////            if ([arr[i] isEqualToString:@"陈列包柱"]) {
////                btn4.selected=YES;
////            }
//        }
//    }
    
}
-(void)btnClicks:(UIButton *)btn
{
    btn.selected=!btn.selected;
}
-(void)initConfirmBtn
{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(50, 440, WIDTH-100, 40);
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
//提交
-(void)btnClick:(UIButton *)btn
{

    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Set the label text.
    hud.label.text = @"上传数据中,请稍候...";

    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self uploadData];
    });
    
 
    [self uploadPic];
    
    
}

-(void)uploadData
{
//    if ([_type isEqualToString:@"tg"]) {
//        dataDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:tf1.text,@"ShelfSectionNumber1",tf2.text,@"ShelfSectionNumber2",tf3.text,@"ShelfSectionNumber3", nil];
//        [dataDic setValue:@"" forKey:@"TG"];
//        [dataDic setValue:@"" forKey:@"ShopBuiltForm"];
//        [dataDic setValue:@"" forKey:@"Coaming"];
//    }
//    else if([_type isEqualToString:@"list"])
//    {
//        dataDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"ShelfSectionNumber1",@"",@"ShelfSectionNumber2",@"",@"ShelfSectionNumber3", nil];
//        [dataDic setValue:tf1.text forKey:@"TG"];
//        [dataDic setValue:@"" forKey:@"ShopBuiltForm"];
//        [dataDic setValue:tf2.text forKey:@"Coaming"];
//    }
//    else
//    {
        //        dataDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:tf1.text,@"ShelfSectionNumber1", nil];
    
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];

        NSMutableString *styleStr=[NSMutableString string];
    NSDate *date=[NSDate date];
    NSDateFormatter *dateForm=[[NSDateFormatter alloc]init];
    [dateForm setDateFormat:@"yyyy-MM-dd"];
    NSString *time=[dateForm stringFromDate:date];
    NSLog(@"%@",time);
    
        NSArray *arrs=@[@"买赠",@"派发"];
        for (int i=0; i<2; i++) {
            UIButton *btn=[self.view viewWithTag:201+i];
            if (btn.selected) {
                if (styleStr.length==0) {
                    [styleStr appendString:[NSString stringWithFormat:@"%@",arrs[i]]];
                }
                else{
                    [styleStr appendString:[NSString stringWithFormat:@",%@",arrs[i]]];
                }
                
            }
//        }
        NSLog(@"%@",styleStr);
//        dataDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"ShelfSectionNumber1",@"",@"ShelfSectionNumber2",@"",@"ShelfSectionNumber3", nil];
   
    }
    dataDic=[[NSMutableDictionary alloc]init];
    [dataDic setValue:userid forKey:@"userId"];
    [dataDic setValue:@"0" forKey:@"usertype"];
    [dataDic setValue:_model.ID forKey:@"storeid"];
    [dataDic setValue:time forKey:@"date"];
    [dataDic setValue:styleStr forKey:@"note"];
    
    
    
//    [dataDic setValue:_model.ID forKey:@"ID"];
    
    NSArray *arr=[NSArray arrayWithObject:dataDic];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [NetWork UploadPOPDataDataWithDic:dataDic withBlock:^(NSDictionary *result, NSError *error) {
        
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            [hud hideAnimated:YES];
        //        });
        hud.label.text=@"上传成功";
        [hud hideAnimated:YES afterDelay:2];
    } withBlock:^(NSString *result, NSError *error) {
        hud.label.text=@"上传失败,请重试";
        [hud hideAnimated:YES afterDelay:2];
    }];
    
    
}

-(void)uploadPic
{
    NSMutableArray * picArr = [KeepSignInInfo selectPatrolPictureWithID:_model.ID];
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    NSMutableString *styleStr=[NSMutableString string];
    NSDate *date=[NSDate date];
    NSDateFormatter *dateForm=[[NSDateFormatter alloc]init];
    [dateForm setDateFormat:@"yyyy-MM-dd"];
    NSString *time=[dateForm stringFromDate:date];
    NSLog(@"%@",time);
    
    for (int i=0; i<picArr.count; i++) {
        
        NSDictionary *picDic=[NSDictionary dictionaryWithObjectsAndKeys:_model.ID,@"storeid",[picArr[i] imageUrl],@"base64Str",time,@"date",userid,@"userId",@"0",@"usertype",nil];
        
        
        [NetWork UploadPOPPicWithDic:picDic withBlock:^(NSDictionary *result, NSError *error) {
            
            [KeepSignInInfo deletePatrolPictureWithImageUrl:[picArr[i] imageUrl]];
            
            NSString * imageUrl = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),[picArr[i] imageUrl]];
            [[NSFileManager defaultManager] removeItemAtPath:imageUrl error:nil];
            photoArr=[KeepSignInInfo selectPhotoWithType:@"照片" andId:_model.ID];
            
            [self uiConfig];
            
            hud.label.text=@"上传成功";
            [hud hideAnimated:YES afterDelay:2];
            
        } withBlock:^(NSString *result, NSError *error) {
            hud.label.text=@"上传失败,请重试";
            [hud hideAnimated:YES afterDelay:2];
        }];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)uiConfig
{
    [smallScr1 removeFromSuperview];
    smallScr1=[[UIScrollView alloc]init];
    
    smallScr1.tag=501;
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(0, 250, 100, 40);
    //    label.backgroundColor=[UIColor redColor];
    label.text=[NSString stringWithFormat:@"拍照:"];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    smallScr1.frame=CGRectMake(80, 210, 305, 90);
    
    smallScr.backgroundColor=[UIColor grayColor];
    
    smallScr1.contentSize=CGSizeMake(90 *photoArr.count+80, 90);
    [self.view addSubview:smallScr1];
    
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
        
        [imgV setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),photoArr[j]]]];
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
    

    _name=@"照片";
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    
    //    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
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
        
        NSData *data = UIImageJPEGRepresentation(image, 1);
        //        NSString *resultStr = [NSString stringWithFormat:@"%ld",(unsigned long)data.length];
        
        NSDictionary *  dic = [[editingInfo objectForKey:@"UIImagePickerControllerMediaMetadata"] objectForKey:@"{Exif}"];
        NSString * time = [dic objectForKey:@"DateTimeOriginal"];
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
    photoArr=[KeepSignInInfo selectPhotoWithType:@"照片" andId:_model.ID];
    photoArr2=[KeepSignInInfo selectPhotoWithType:@"照片" andId:_model.ID];
    [self uiConfig];
}
-(void)toDetail:(UITapGestureRecognizer *)tap
{
    //    NSLog(@"%ld",tap.view.superview.tag);
    NSLog(@"%ld",tap.view.superview.tag-500);
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
    otherScrollVC.frame=CGRectMake(0, 104, 320, 464);
    otherScrollVC.contentSize=CGSizeMake(320*dataArr.count, 400);
    NSLog(@"count-->>%lu",(unsigned long)dataArr.count);
    otherScrollVC.pagingEnabled=YES;
    for (int i=0; i<dataArr.count; i++) {
        UIImageView *imgV=[[UIImageView alloc]init];
        imgV.frame=CGRectMake(10+320*i, 0, 300, 400);
        [otherScrollVC addSubview:imgV];
        imgV.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),dataArr[i]]];
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


@end
