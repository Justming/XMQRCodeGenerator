//
//  XMQRCode.m
//  XMQRCodeGenerator
//
//  Created by Justming on 2017/2/20.
//  Copyright © 2017年 Huasheng. All rights reserved.
//

#import "XMQRCode.h"
#import <CoreImage/CoreImage.h>
@implementation XMQRCode



/**
 *  二维码由滤镜（CIFilter类）生成，
 *  首先要导入<CoreImage/CoreImage.h>
 *
 *
 *
 */

#pragma mark 普通黑白二维码
+ (UIImage *)commonQRCodeWithData:(NSString *)dataString{
    
    //创建滤镜
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //滤镜属性设置为默认值
    [filter setDefaults];
    
    //给过滤器添加数据
    NSData * data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    //获取输出的二维码
    CIImage * outputImage = [filter outputImage];
    
    //直接输出的二维码比较模糊,进行缩放后变清楚
    return [UIImage imageWithCIImage:[outputImage imageByApplyingTransform:CGAffineTransformMakeScale(5, 5)]];
    
    //图片模糊也可以通过下面方法转换成高清二维码
    //return [XMQRCode createNonInterpolatedUIImageFormCIImage:outputImage withSize:100];

}
//CIImage->UIImage，转换成高清二维码
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size{
    
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    //创建bitmap 位图
    size_t width = CGRectGetWidth(extent)*scale;
    size_t height = CGRectGetHeight(extent)*scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}


#pragma mark 生成带中间头像的二维码
//方法：1.先生成二维码图像
//     2.通过画图把二维码画到屏幕上
//     3.把头像画到二维码上
//     4.画头像时不能画的太大，否则会导致二维码信息被覆盖而失效
// 其实还有一种方法，直接把头像调整大小，加到二维码的子视图上，只要不覆盖二维码的信息部分，都是可以的
+ (UIImage *)createQRCodeWithData:(NSString *)dataString Icon:(NSString *)iconName scale:(CGFloat)scale{
    
    scale = 0.2;
    
    //创建过滤器
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //滤镜属性设置为默认值
    [filter setDefaults];
    
    //给过滤器添加数据
    NSData * data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    //获取输出的二维码
    CIImage * outputImage = [filter outputImage];
    UIImage * QRimage = [UIImage imageWithCIImage:[outputImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)]];
    
    //获取画图上下文
    UIGraphicsBeginImageContext(QRimage.size);
    
    //先画二维码
    [QRimage drawInRect:CGRectMake(0, 0, QRimage.size.width, QRimage.size.height)];
    
    //计算头像坐标
    UIImage * icon = [UIImage imageNamed:iconName];
    CGFloat x = QRimage.size.width *(1-scale) / 2;
    CGFloat y = x;
    CGFloat w = QRimage.size.width * scale;
    CGFloat h = w;
    //画头像
    [icon drawInRect:CGRectMake(x, y, w, h)];
    //获取画好的图片
    UIImage * result = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭绘图上下文
    UIGraphicsEndImageContext();
    
    
    return result;

}


#pragma mark 生成彩色二维码
+ (UIImage *)colorfulQRCodeWithData:(NSString *)dataString forwardColor:(CIColor *)fcolor backColor:(CIColor *)bcolor {
    
    //创建过滤器
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //设置过滤器属性为默认值
    [filter setDefaults];
    //给过滤器添加数据
    NSData * data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    //获取输出的二维码
    CIImage * outputImage = [filter outputImage];
    
    //到这里二维码就生成了，不过是默认的黑白色
    //要想设置成彩色二维码，还需要创建一个彩色过滤器进行设置
    
    //创建彩色过滤器
    CIFilter * colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    //给彩色过滤器属性设置默认值
    [colorFilter setDefaults];
    
    //设置私有属性，输入图片
    [colorFilter setValue:outputImage forKey:@"inputImage"];
    //设置背景色
    [colorFilter setValue:fcolor forKey:@"inputColor0"];
    //设置前景死
    [colorFilter setValue:bcolor forKey:@"inputColor1"];
    //获取生成的图片
    CIImage * colorImage = [colorFilter outputImage];
    
    return [UIImage imageWithCIImage:colorImage];
    

}





@end
