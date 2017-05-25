//
//  QueViewController.m
//  Unicharm
//
//  Created by abc on 2017/3/22.
//  Copyright © 2017年 ljh. All rights reserved.
//

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#import "QueViewController.h"

@interface QueViewController ()

@end

@implementation QueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *web=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://unicharm.egocomm.cn/Service/Questionnaire/default.aspx?userid=%@&storeid=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"],_storeID]]]];
//    http://192.168.60.50/ynj/Service/Questionnaire/default.aspx?userid=1&storeid=7
    [self.view addSubview:web];
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
