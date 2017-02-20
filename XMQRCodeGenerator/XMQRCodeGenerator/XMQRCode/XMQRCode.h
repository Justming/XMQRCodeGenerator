//
//  XMQRCode.h
//  XMQRCodeGenerator
//
//  Created by Huasheng on 2017/2/20.
//  Copyright © 2017年 Huasheng. All rights reserved.
//


/**
 *     使用说明：
 *      1.在控制器中导入头文件 #import "XMQRCode.h"
 *      2.创建imageview
 *      3.调用以下三个类方法分别生成二维码
 *      4.把二维码设置为imageview的image
 *
 *      github地址：https://github.com/Justming/XMQRCodeGenerator.git
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XMQRCode : NSObject


/**
 *  生成一张普通黑白的二维码
 *
 *  @param dataString    要保存到二维码的数据
 *
 */
+ (UIImage *)commonQRCodeWithData:(NSString *)dataString;



/**
 *  生成一张中间带头像的二维码
 *
 *  @param dataString    要保存到二维码的数据
 *  @param iconName      头像名称
 *  @param scale         头像缩放比例，默认0.2
 */
+ (UIImage *)createQRCodeWithData:(NSString *)dataString Icon:(NSString *)iconName scale:(CGFloat)scale;


/**
 *  生成一张彩色的二维码
 *
 *  @param dataString   要保存到二维码的数据
 *  @param fcolor       前景色，即绘制成的二维码图案的颜色
 *  @param bcolor       背景色，绘制二维码的背景画布的颜色
 */
+ (UIImage *)colorfulQRCodeWithData:(NSString *)dataString forwardColor:(CIColor *)fcolor backColor:(CIColor *)bcolor;

@end
