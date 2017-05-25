//
//  ThirdViewController.m
//  Unicharm
//
//  Created by EssIOS on 16/8/5.
//  Copyright © 2016年 ljh. All rights reserved.
//

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
#import "ThirdViewController.h"
#import "secondVC.h"
#import "NewViewController.h"
#import "MDLViewController.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(50, 100, WIDTH-100, 40);
    [btn setTitle:@"企划" forState:UIControlStateNormal];
    btn.tag=101;
    btn.backgroundColor=[UIColor groupTableViewBackgroundColor];
    btn.layer.cornerRadius=20;
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame=CGRectMake(50, 200, WIDTH-100, 40);
    [btn2 setTitle:@"填报" forState:UIControlStateNormal];
    btn2.tag=102;
    btn2.backgroundColor=[UIColor groupTableViewBackgroundColor];
    btn2.layer.cornerRadius=20;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn3.frame=CGRectMake(50, 300, WIDTH-100, 40);
    [btn3 setTitle:@"POP" forState:UIControlStateNormal];
    btn3.tag=103;
    btn3.backgroundColor=[UIColor groupTableViewBackgroundColor];
    btn3.layer.cornerRadius=20;
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    
    
}

-(void)getMD:(NSDictionary *)dic
{

  
}
-(void)btnClick:(UIButton *)btn
{
    secondVC *second=[[secondVC alloc]init];
    MDLViewController *newC=[[MDLViewController alloc]init];
    
//    NSLog(@"%d".btn.tag);
    
    switch (btn.tag) {
        case 101:
            [self.navigationController pushViewController:second animated:YES];
            
            break;
        case 102:
//            [self.navigationController pushViewController:second animated:YES];
            
            break;
        case 103:
            [self.navigationController pushViewController:newC animated:YES];
            
            break;
            
        default:
            break;
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
