//
//  ViewController.m
//  Unicharm
//
//  Created by EssIOS on 16/8/5.
//  Copyright © 2016年 ljh. All rights reserved.
//

#import "ViewController.h"
#import "ThirdViewController.h"
#import "secondVC.h"
#import "NetWork.h"
#import "MD5Tool.h"

#import "KeepSignInInfo.h"
#import "StoreMD.h"
#import "keepLocationInfo.h"
#import "MBProgressHUD.h"
#define UserDefaults  [NSUserDefaults standardUserDefaults]

@interface ViewController ()
{
    UIScrollView *smallScr;
    UIScrollView *smallScr1;
    
    NSMutableArray *dataArr;
    NSMutableArray *photoArr;
    NSMutableArray *photoArr2;
    
    NSMutableDictionary     * _keepInfo;
    
    
    UIScrollView *otherScrollVC;
    
    bool isSaved;
    UIAlertView * _alert;
    
    UIAlertController *alertC;


}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
}
- (IBAction)rememberBtn:(UIButton *)sender {
    sender.selected=!sender.selected;
}
- (IBAction)autoLogin:(UIButton *)sender {
    sender.selected=!sender.selected;
}

- (void)viewWillAppear:(BOOL)animated
{
    _MMPSWbtn.selected   = (BOOL) [UserDefaults boolForKey:@"mmpswType"];
    _autoLogBtn.selected = (BOOL) [UserDefaults boolForKey:@"autoLogType"];
    if (_MMPSWbtn.selected == YES)
    {
        _nameTF.text = [UserDefaults objectForKey:@"username"];
        _passWTF.text = [UserDefaults objectForKey:@"password"];
        //是否自动登录
        if (_autoLogBtn.selected == YES)
        {
       //     [self validUser];
        }
    }else {
        _nameTF.text = @"";
        _passWTF.text = @"";
    }
}
-(void)dismiss
{
    [self.view endEditing:YES];
}

- (IBAction)pushTo:(id)sender {
    
    
    [self validUser];
    
    
}
-(void)validUser
{
   
    
  
    NSString *passWord=_passWTF.text;
    
    passWord = [MD5Tool MD5WithString:passWord];

    alertC=[UIAlertController alertControllerWithTitle:@"提示" message:@"登录中,请稍候..." preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *confirm=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    UIAlertAction *cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//                    
//    [alertC addAction:confirm];
//    [alertC addAction:cancle];
  
    [self presentViewController:alertC animated:YES completion:^{
        
        _alert=[[UIAlertView alloc]init];
        
        if (_nameTF.text.length == 0 || _passWTF.text.length == 0) {
            [self dismissViewControllerAnimated:YES completion:nil];

            [_alert setTitle:@"账号或密码不能为空!"];
            [_alert show];
            [UIView animateWithDuration:8 animations:^{
                [_alert dismissWithClickedButtonIndex:0 animated:YES];
            }];
            return;
        }
        [NetWork loginWithLoginName:_nameTF.text password:passWord withBlock:^(NSDictionary *result, NSError *error) {
//            NSLog(@"登陆成功");
            NSString * userID = [[result objectForKey:@"Data"] objectForKey:@"UserId"];
            if ([userID intValue] == 0){
                
                [self dismissViewControllerAnimated:YES completion:nil];
                [_alert setTitle:@"账号密码错误!"];
                [_alert show];
                [UIView animateWithDuration:4 animations:^{
                    [_alert dismissWithClickedButtonIndex:0 animated:YES];
                }];
                return;
            }else
            {
                [_alert dismissWithClickedButtonIndex:0 animated:YES];
                
                [UserDefaults setObject:_nameTF.text forKey:@"username"];
                [UserDefaults setObject:_passWTF.text forKey:@"password"];
                [UserDefaults setBool:_MMPSWbtn.selected forKey:@"mmpswType"];
                [UserDefaults setBool:_autoLogBtn.selected forKey:@"autoLogType"];
                
            }

            
            [self dismissViewControllerAnimated:YES completion:nil];

            secondVC *second=[[secondVC alloc]init];

            
            [self.navigationController pushViewController:second animated:YES];
            
            
        } withBlock:^(NSString *result, NSError *error) {
            
            NSLog(@"登陆失败");
            [self dismissViewControllerAnimated:YES completion:nil];
            [_alert setTitle:@"登录失败，请稍后重试!"];
            [_alert show];
            [UIView animateWithDuration:4 animations:^{
                [_alert dismissWithClickedButtonIndex:0 animated:YES];
            }];
        }];
    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
