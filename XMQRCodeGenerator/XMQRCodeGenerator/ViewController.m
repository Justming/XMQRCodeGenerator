//
//  ViewController.m
//  XMQRCodeGenerator
//
//  Created by Justming on 2017/2/20.
//  Copyright © 2017年 Justming. All rights reserved.
//

#import "ViewController.h"
#import "XMQRCode.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //黑白二维码
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 100, 100, 100)];
    imageView.backgroundColor = [UIColor yellowColor];
    imageView.image = [XMQRCode commonQRCodeWithData:@"https://github.com/Justming/XMQRCodeGenerator.git"];
    [self.view addSubview:imageView];
    
    //带头像二维码
    UIImageView * iconView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 250, 100, 100)];
    iconView.image = [XMQRCode createQRCodeWithData:@"https://github.com/Justming/XMQRCodeGenerator.git" Icon:@"1.jpg" scale:0.1];
    [self.view addSubview:iconView];
    
    //彩色二维码
    UIImageView * colorView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 400, 100, 100)];
    colorView.image = [XMQRCode colorfulQRCodeWithData:@"https://github.com/Justming/XMQRCodeGenerator.git" forwardColor:[CIColor redColor] backColor:[CIColor yellowColor]];
    [self.view addSubview:colorView];

    
    
    
}



@end
