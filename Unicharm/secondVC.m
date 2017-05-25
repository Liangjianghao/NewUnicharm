//
//  secondVC.m
//  Unicharm
//
//  Created by EssIOS on 16/8/5.
//  Copyright © 2016年 ljh. All rights reserved.
//

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#import "secondVC.h"
#import "ThirdViewController.h"
#import "DetailViewController.h"
#import "StoreModel.h"
#import "NetWork.h"
#import "MBProgressHUD.h"
#import "signViewController.h"
#import "NewSignViewController.h"
#import "tiaozhuanViewController.h"
#import "KeepSignInInfo.h"
#import "PhotoModel.h"
@interface secondVC ()
{
    NSMutableArray *dataArr;
    UITableView *tableView;
    NSString *statu;
    NSString *content;
    NSString *quality;
    MBProgressHUD *hud;

}
@end

@implementation secondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-50-64) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    dataArr=[[NSMutableArray alloc]init];
//    dataArr=[NSMutableArray arrayWithObjects:@"门店一",@"门店二",@"门店三",@"门店四",@"门店五",@"门店六", nil];
    self.title=@"门店列表";
//    [self getAllMD];
    
    UIButton *btn4=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn4.frame=CGRectMake(10, HEIGHT-50-64, WIDTH-20, 40);
    [btn4 setTitle:@"上传照片" forState:UIControlStateNormal];
    btn4.tag=104;
    btn4.backgroundColor=[UIColor groupTableViewBackgroundColor];
    btn4.layer.cornerRadius=20;
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(UploadAllPic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    

}
-(void)UploadAllPic:(UIButton *)btn
{

    
    
        //回调或者说是通知主线程刷新，
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"上传照片中,请稍候...";
        
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    [self uploadXDPic];
    
    [self uploadQHPic];
        
        
    }
                   );
}
-(void)uploadXDPic
{
    
    // Set the label text.
//    hud.label.text = @"上传巡店照片中,请稍候...";
    
        NSMutableArray * picArr = [KeepSignInInfo NewselectPhotoWithType:nil andId:nil];
    
    if (picArr.count==0) {
        hud.label.text=@"无巡店照片";
        [hud hideAnimated:YES afterDelay:2];
    }
        for (int i=0; i<picArr.count; i++) {

            NSMutableDictionary *picDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:[picArr[i] objectForKey:@"userID"],@"userid",[picArr[i] objectForKey:@"storeCode"],@"storeid",[picArr[i] objectForKey:@"imgID"],@"imgtype",[picArr[i] objectForKey:@"Longitude"],@"lng",[picArr[i] objectForKey:@"Latitude"],@"lat",[picArr[i] objectForKey:@"imageurl"],@"base64Str",[picArr[i] objectForKey:@"createTime"],@"createTime",nil];
            
            
            [NetWork uploadPhotoWithDic:picDic withBlock:^(NSDictionary *result, NSError *error) {
                if ([[result objectForKey:@"ErrorCode"] intValue]==0) {
                    NSLog(@"shanchu%@",[picArr[i] objectForKey:@"imageurl"]);
                    
                    [KeepSignInInfo deletePatrolPictureWithImageUrl:[picArr[i] objectForKey:@"imageurl"]];
                    
                    NSString * imageUrl = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),[picArr[i] objectForKey:@"imageurl"]];
                    [[NSFileManager defaultManager] removeItemAtPath:imageUrl error:nil];
                    
                    hud.label.text=@"巡店照片上传成功";
                    [hud hideAnimated:YES afterDelay:1];
                    
                }
                else
                {
                    hud.label.text=@"巡店照片上传失败,请重试";
                    [hud hideAnimated:YES afterDelay:2];
                }
                
            } withBlock:^(NSString *result, NSError *error) {
                hud.label.text=@"巡店照片上传失败,请重试";
                [hud hideAnimated:YES afterDelay:2];
            }];
        }
    
}

-(void)uploadQHPic
{
    
    
    

    NSMutableArray * picArr = [KeepSignInInfo NewselectlPictureWithtype:nil andWithID:nil];
    if (picArr.count==0) {
        hud.label.text=@"无企划照片";
        [hud hideAnimated:YES afterDelay:2];
    }
    
    NSString *userid=[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    
    for (int i=0; i<picArr.count; i++) {
        
        NSDictionary *picDic=[NSDictionary dictionaryWithObjectsAndKeys:[picArr[i] Longitude],@"lng",[picArr[i] Latitude],@"lat",userid,@"userid",[picArr[i] imgID],@"cfgId",[picArr[i] imageUrl],@"base64Str",[picArr[i] Createtime],@"Createtime",[picArr[i] selectType],@"type",nil];
        
        NSLog(@"%@",picDic);
        
        NSString *urlStr;
        if ([[picArr[i] selectType] isEqualToString:@"dsr"]) {
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
                
                NSLog(@"img success");
                hud.label.text=@"企划照片上传成功";
                [hud hideAnimated:YES afterDelay:2];
            }
            else{
                hud.label.text=@"企划照片上传失败,请重试";
                [hud hideAnimated:YES afterDelay:2];
            }
            
        } withBlock:^(NSString *result, NSError *error) {
            hud.label.text=@"企划照片上传失败,请重试";
            [hud hideAnimated:YES afterDelay:2];
        }];
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getAllMD];
}
-(void)getAllMD
{
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    NSDate *date=[NSDate date];
    NSDateFormatter *dateForm=[[NSDateFormatter alloc]init];
    [dateForm setDateFormat:@"yyyyMM"];
    NSString *time=[dateForm stringFromDate:date];
    NSLog(@"%@",time);
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:time,@"month",userid,@"userid",@"0",@"userType", nil];
    [dataArr removeAllObjects];
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Set the label text.
    hud.label.text = @"获取门店中,请稍候...";
    
    [NetWork getBaseDataWithDic:dic withBlock:^(NSDictionary *result, NSError *error) {
        
        NSArray *arr=[result objectForKey:@"Data"];
        
        for (int i=0; i<arr.count; i++) {
            StoreModel *model=[[StoreModel alloc]init];
            model.ID=[arr[i] objectForKey:@"StoreId"];
            model.StoreNo=[arr[i] objectForKey:@"StoreName"];
            model.kpiCount=[arr[i] objectForKey:@"KPICount"];
            model.kpiDsrCount=[arr[i] objectForKey:@"KPIDSRCount"];
//            model.PlanNo=[arr[i] objectForKey:@"PlanNo"];
//            model.PlanItem=[arr[i] objectForKey:@"PlanItem"];
//            model.PlanType=[arr[i] objectForKey:@"PlanType"];
//            model.PlanStartDate=[arr[i] objectForKey:@"PlanStartDate"];
//            model.PlanEndDate=[arr[i] objectForKey:@"PlanEndDate"];
//            model.PlanMonth=[arr[i] objectForKey:@"PlanMonth"];
//            model.ShelfSectionNumber1=[arr[i] objectForKey:@"ShelfSectionNumber1"];
//            model.ShelfSectionNumber2=[arr[i] objectForKey:@"ShelfSectionNumber2"];
//            model.ShelfSectionNumber3=[arr[i] objectForKey:@"ShelfSectionNumber3"];
//            model.ShopBuiltForm=[arr[i] objectForKey:@"ShopBuiltForm"];
//            model.Coaming=[arr[i] objectForKey:@"Coaming"];
//            model.TG=[arr[i] objectForKey:@"TG"];
//            model.IsVerify=[arr[i] objectForKey:@"IsVerify"];
//            model.IsUpload=[arr[i] objectForKey:@"IsUpload"];
//            model.Name=[[arr[i] objectForKey:@"Store"] objectForKey:@"Name"];
//            model.Id=[[arr[i] objectForKey:@"Store"] objectForKey:@"Id"];
//            model.Address=[[arr[i] objectForKey:@"Store"] objectForKey:@"Address"];
//            model.KPICategory=[arr[i] objectForKey:@"KPICategory"];
//            model.Expand1=[arr[i] objectForKey:@"Expand1"];
//            model.Expand2=[arr[i] objectForKey:@"Expand2"];
            [dataArr addObject:model];
        }
        hud.label.text = @"获取门店成功";
        [hud hideAnimated:YES afterDelay:1];
        
        [tableView reloadData];
    } withBlock:^(NSString *result, NSError *error) {
        hud.label.text = @"获取门店失败";
        [hud hideAnimated:YES afterDelay:2];
    }];

}
-(void)getSinglePro:(NSString *)str
{
//    NSDictionary *dic;
    [NetWork getSingleProDataWithDic:str withBlock:^(NSDictionary *result, NSError *error) {
    
    } withBlock:^(NSString *result, NSError *error) {
    
    }];

}
#pragma mark--tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        //        cell=[[[NSBundle mainBundle]loadNibNamed:@"BottleCell" owner:self options:nil]firstObject];
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    //    [cell setModel:dataArr[indexPath.row]];
//    NSLog(@"%@",[dataArr[indexPath.row] objectForKey:@"Store"] );
//
//    NSLog(@"%@",dataArr[indexPath.row]);
    
    
//    cell.textLabel.text=[[dataArr[indexPath.row] objectForKey:@"Store"] objectForKey:@"Name"];
    cell.textLabel.text=[dataArr[indexPath.row] StoreNo];

    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    
    if ([[NSString stringWithFormat:@"%@",[dataArr[indexPath.row] IsVerify]] isEqualToString:@"0"]) {
       statu=@"未填写";
    }
    else     if ([[NSString stringWithFormat:@"%@",[dataArr[indexPath.row] IsVerify]] isEqualToString:@"1"]) {
        statu=@"未审核";

    }
    else     if ([[NSString stringWithFormat:@"%@",[dataArr[indexPath.row] IsVerify]] isEqualToString:@"2"]) {
        statu=@"审核通过";

    }
    else
    {
        statu=@"审核不通过";

    }
    
    if ([[NSString stringWithFormat:@"%@",[dataArr[indexPath.row] PlanType]] isEqualToString:@"01"]) {
        content=@"普通TG";
    }
    else     if ([[NSString stringWithFormat:@"%@",[dataArr[indexPath.row] PlanType]] isEqualToString:@"03"]) {
        content=@"陈列扩大";
        
    }
    else     if ([[NSString stringWithFormat:@"%@",[dataArr[indexPath.row] PlanType]] isEqualToString:@"04"]) {
        content=@"店头建设";
        
    }
    else
    {
        content=@"无任务";
    }
    
    if ([[NSString stringWithFormat:@"%@",[dataArr[indexPath.row] PlanItem]] isEqualToString:@"01"]) {
        quality=@"生理";
    }
    else     if ([[NSString stringWithFormat:@"%@",[dataArr[indexPath.row] PlanItem]] isEqualToString:@"02"]) {
        quality=@"婴儿";
        
    }
    else
    {
        quality=@"无";
    }
 

    
//    cell.detailTextLabel.text=[NSString stringWithFormat:@"\n审核内容:%@\n审核状态:%@\nKPI计划品质:%@",content,statu,quality];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
    cell.detailTextLabel.numberOfLines=5;
//    NSLog(@"%@",[dataArr[indexPath.row] IsUpload]);
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    signViewController *signVC=[[signViewController alloc]init];
//    //    newVC.name=[dataArr[indexPath.row] ID];
//    signVC.model=dataArr[indexPath.row];
//    [self.navigationController pushViewController:signVC animated:YES];

    
    tiaozhuanViewController *tiaozhuanVC=[[tiaozhuanViewController alloc]init];
    //    newVC.name=[dataArr[indexPath.row] ID];
    tiaozhuanVC.model=dataArr[indexPath.row];
    [self.navigationController pushViewController:tiaozhuanVC animated:YES];

    
 
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
