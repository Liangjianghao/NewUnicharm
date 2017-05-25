//
//  ListViewController.m
//  Unicharm
//
//  Created by EssIOS on 16/8/8.
//  Copyright © 2016年 ljh. All rights reserved.
//

#import "ListViewController.h"
#import "NetWork.h"
@interface ListViewController ()
{
    NSMutableArray *dataArr;
    UITableView *tableView;
}
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    
    [self getList];
}
-(void)getList
{

    
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
    cell.textLabel.text=dataArr[indexPath.row];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
