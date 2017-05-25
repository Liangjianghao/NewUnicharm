//
//  KPIListViewController.m
//  Unicharm
//
//  Created by abc on 2017/3/23.
//  Copyright © 2017年 ljh. All rights reserved.
//
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
#import "KPIListViewController.h"
#import "NetWork.h"
#import "DetailViewController.h"
@interface KPIListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *mytable;
    NSMutableArray *dataArr;
    NSMutableArray *baseArr;
    NSMutableArray *allModelArr;

}
@end

@implementation KPIListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArr=[[NSMutableArray alloc]init];
    baseArr=[[NSMutableArray alloc]init];
    allModelArr=[[NSMutableArray alloc]init];
    self.view.backgroundColor=[UIColor whiteColor];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}
-(void)loadData
{
    NSLog(@"%@ %@",_model.kpiCount,_model.kpiDsrCount);
    if (_model.kpiDsrCount==0&&_model.kpiDsrCount==0) {
        NSLog(@"无kpi");
        //baseScroll.contentSize=CGSizeMake(WIDTH, 230+imgArr.count*100);
        return;
    }
    else
    {
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:_model.ID,@"storeid", nil];
//        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"4006",@"storeid", nil];

        [NetWork getKPITypleWithDic:dic withBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"ErrorCode"] intValue]==0) {
                
                NSArray *listArr=[[result objectForKey:@"Data"] objectForKey:@"KPIPlanList"];
                NSArray *listArr2=[[result objectForKey:@"Data"] objectForKey:@"KPIPlanDSRList"];
                //            baseArr=[NSMutableArray arrayWithArray:listArr];
                baseArr=[[NSMutableArray alloc]init];
                dataArr=[[NSMutableArray alloc]init];
                for (int i=0; i<listArr.count; i++) {
                    //                NSString *kpiname=[NSString stringWithFormat:@"%@_%@",[self numberToContent:[listArr[i] objectForKey:@"PlanItem"]],[self numberTokpi:[listArr[i] objectForKey:@"PlanType"]]];
                    NSString *kpiname=[NSString stringWithFormat:@"类型：%@ 品质：%@ 状态：%@",[self numberToContent:[listArr[i] objectForKey:@"PlanType"]],[self numberTokpi:[listArr[i] objectForKey:@"PlanItem"]],[self numberToStatus:[listArr[i] objectForKey:@"IsVerify"]]];
                    [dataArr addObject:kpiname];
                    [baseArr addObject:[listArr[i] objectForKey:@"PlanType"]];
                    StoreModel *mymodel=[[StoreModel alloc]init];
                    mymodel.storeID=[listArr[i] objectForKey:@"ID"];
                    mymodel.PlanNo=[listArr[i] objectForKey:@"PlanNo"];
                    mymodel.PlanItem=[listArr[i] objectForKey:@"PlanItem"];
                    mymodel.PlanType=[listArr[i] objectForKey:@"PlanType"];
                    mymodel.PlanStartDate=[listArr[i] objectForKey:@"PlanStartDate"];
                    mymodel.PlanEndDate=[listArr[i] objectForKey:@"PlanEndDate"];
                    mymodel.PlanMonth=[listArr[i] objectForKey:@"PlanMonth"];
                    mymodel.ShelfSectionNumber1=[listArr[i] objectForKey:@"ShelfSectionNumber1"];
                    mymodel.ShelfSectionNumber2=[listArr[i] objectForKey:@"ShelfSectionNumber2"];
                    mymodel.ShelfSectionNumber3=[listArr[i] objectForKey:@"ShelfSectionNumber3"];
                    mymodel.ShopBuiltForm=[listArr[i] objectForKey:@"ShopBuiltForm"];
                    mymodel.Coaming=[listArr[i] objectForKey:@"Coaming"];
                    mymodel.TG=[listArr[i] objectForKey:@"TG"];
                    mymodel.IsVerify=[listArr[i] objectForKey:@"IsVerify"];
                    mymodel.IsUpload=[listArr[i] objectForKey:@"IsUpload"];
                    mymodel.Name=[[listArr[i] objectForKey:@"Store"] objectForKey:@"Name"];
                    mymodel.Id=[[listArr[i] objectForKey:@"Store"] objectForKey:@"Id"];
                    mymodel.Address=[[listArr[i] objectForKey:@"Store"] objectForKey:@"Address"];
                    mymodel.isdsr=NO;
                    mymodel.Expand1=[listArr[i] objectForKey:@"Expand1"];
                    mymodel.Expand2=[listArr[i] objectForKey:@"Expand2"];
                    mymodel.KPICategory=[listArr[i] objectForKey:@"KPICategory"];
                    
                    [allModelArr addObject:mymodel];
                }
                for (int i=0; i<listArr2.count; i++) {
                    //                NSString *kpiname=[NSString stringWithFormat:@"%@_%@",[self numberToContent:[listArr2[i] objectForKey:@"PlanItem"]],[self numberTokpi:[listArr2[i] objectForKey:@"PlanType"]]];
                    NSString *kpiname=[NSString stringWithFormat:@"类型dsr：%@ 品质：%@ 状态：%@",[self numberToContent:[listArr2[i] objectForKey:@"PlanType"]],[self numberTokpi:[listArr2[i] objectForKey:@"PlanItem"]],[self numberToStatus:[listArr2[i] objectForKey:@"IsVerify"]]];
                    [dataArr addObject:kpiname];
                    [baseArr addObject:[listArr2[i] objectForKey:@"PlanType"]];
                    StoreModel *mymodel=[[StoreModel alloc]init];
                    mymodel.storeID=[listArr2[i] objectForKey:@"ID"];
                    mymodel.PlanNo=[listArr2[i] objectForKey:@"PlanNo"];
                    mymodel.PlanItem=[listArr2[i] objectForKey:@"PlanItem"];
                    mymodel.PlanType=[listArr2[i] objectForKey:@"PlanType"];
                    mymodel.PlanStartDate=[listArr2[i] objectForKey:@"PlanStartDate"];
                    mymodel.PlanEndDate=[listArr2[i] objectForKey:@"PlanEndDate"];
                    mymodel.PlanMonth=[listArr2[i] objectForKey:@"PlanMonth"];
                    mymodel.ShelfSectionNumber1=[listArr2[i] objectForKey:@"ShelfSectionNumber1"];
                    mymodel.ShelfSectionNumber2=[listArr2[i] objectForKey:@"ShelfSectionNumber2"];
                    mymodel.ShelfSectionNumber3=[listArr2[i] objectForKey:@"ShelfSectionNumber3"];
                    mymodel.ShopBuiltForm=[listArr2[i] objectForKey:@"ShopBuiltForm"];
                    mymodel.Coaming=[listArr2[i] objectForKey:@"Coaming"];
                    mymodel.TG=[listArr2[i] objectForKey:@"TG"];
                    mymodel.IsVerify=[listArr2[i] objectForKey:@"IsVerify"];
                    mymodel.IsUpload=[listArr2[i] objectForKey:@"IsUpload"];
                    mymodel.Name=[[listArr2[i] objectForKey:@"Store"] objectForKey:@"Name"];
                    mymodel.Id=[[listArr2[i] objectForKey:@"Store"] objectForKey:@"Id"];
                    mymodel.Address=[[listArr2[i] objectForKey:@"Store"] objectForKey:@"Address"];
                    mymodel.isdsr=YES;
                    mymodel.Expand1=[listArr2[i] objectForKey:@"Expand1"];
                    mymodel.Expand2=[listArr2[i] objectForKey:@"Expand2"];
                    mymodel.KPICategory=[listArr2[i] objectForKey:@"KPICategory"];
                    [allModelArr addObject:mymodel];
                    
                }
              //  baseScroll.contentSize=CGSizeMake(WIDTH, 230+imgArr.count*100);
                
                 [self tableviewUI];
                
            }
            
        } withBlock:^(NSString *result, NSError *error) {
            
        }];
        
    }

}
-(void)tableviewUI
{
    if (mytable) {
        [mytable removeFromSuperview];
    }
    
    mytable=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    mytable.delegate=self;
    mytable.dataSource=self;
    [self.view addSubview:mytable];
}
-(NSString *)numberToStatus:(NSString *)str
{
    if ([str intValue]==0) {
        return @"未填写";
    }
    else     if ([str intValue]==1) {
        return @"未审核";
        
    }
    else     if ([str intValue]==2) {
        return @"审核通过";
        
    }
    else
    {
        return @"审核不通过";
        
    }
}
-(NSString *)numberTokpi:(NSString *)str
{
    if ([str isEqualToString:@"01"]) {
        return @"生理";
    }
    else     if ([str isEqualToString:@"02"]) {
        return @"婴儿";
    }
    else
    {
        return @"无";
    }
}
-(NSString *)numberToContent:(NSString *)str
{
    if ([str isEqualToString:@"01"]) {
        return @"普通TG";
    }
    else     if ([str isEqualToString:@"03"]) {
        return @"陈列扩大";
        
    }
    else     if ([str isEqualToString:@"04"]) {
        return @"店头建设";
        
    }
    else
    {
        return @"无任务";
    }
    
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
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    //    [cell setModel:dataArr[indexPath.row]];
    cell.textLabel.text=dataArr[indexPath.row];
    //    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.font=[UIFont systemFontOfSize:13];
    cell.textLabel.numberOfLines=0;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC=[[DetailViewController alloc]init];
    
    
    detailVC.model=allModelArr[indexPath.row];
    
    detailVC.KPICategory=[_model KPICategory];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    if ([[NSString stringWithFormat:@"%@",[allModelArr[indexPath.row] IsVerify]] isEqualToString:@"0"]) {
        
        detailVC.status=@"change";
        
    }
    else  if ([[NSString stringWithFormat:@"%@",[allModelArr[indexPath.row] IsVerify]] isEqualToString:@"1"]) {
        detailVC.status=@"unchange";
        
    }
    else   if ([[NSString stringWithFormat:@"%@",[allModelArr[indexPath.row] IsVerify]] isEqualToString:@"2"]) {
        
        detailVC.status=@"unchange";
        
    }
    else
    {
        detailVC.status=@"change";
        
    }
    
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
