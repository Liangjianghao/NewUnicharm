//
//  MDLViewController.m
//  Unicharm
//
//  Created by EssIOS on 16/8/19.
//  Copyright © 2016年 ljh. All rights reserved.
//

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
#import "NetWork.h"
#import "MDLViewController.h"
#import "NewViewController.h"
#import "signViewController.h"
#import "NewSignViewController.h"
@interface MDLViewController ()
{
    NSMutableArray *dataArr;
    UITableView *tableView;
    
}
@end

@implementation MDLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    dataArr=[[NSMutableArray alloc]init];
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
    [NetWork getStoreDataWithDic:dic withBlock:^(NSDictionary *result, NSError *error) {
        
        NSArray *arr=[result objectForKey:@"Data"];
        
        for (int i=0; i<arr.count; i++) {
            StoreModel *model=[[StoreModel alloc]init];
            model.ID=[arr[i] objectForKey:@"Id"];
            model.StoreNo=[arr[i] objectForKey:@"Name"];
//            model.storeID=[arr[i] objectForKey:@"Id"];
            
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
            
            [dataArr addObject:model];
        }
        
        
        [tableView reloadData];
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
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    //    [cell setModel:dataArr[indexPath.row]];
    cell.textLabel.text=[dataArr[indexPath.row] StoreNo];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


//    signViewController *signVC=[[signViewController alloc]init];
//    //    newVC.name=[dataArr[indexPath.row] ID];
//    signVC.model=dataArr[indexPath.row];
//    [self.navigationController pushViewController:signVC animated:YES];

    NewSignViewController *signVC=[[NewSignViewController alloc]init];
    //    newVC.name=[dataArr[indexPath.row] ID];
    signVC.model=dataArr[indexPath.row];
    [self.navigationController pushViewController:signVC animated:YES];
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
