//
//  UIImage+Util.m
//  HelloOpenCV
//
//  Created by liang on 6/13/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+Util.h"

@implementation UIImage (Util)

+ (UIImage *)imageWithALAsset:(ALAssetRepresentation *)rep
{
    CGImageRef imageRef = [rep fullScreenImage];
    return [UIImage imageWithCGImage:imageRef];
}

- (UIImage *)scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)asycScaleToSize:(CGSize)size onDispatchQueue:(dispatch_queue_t)queue complete:(void (^)(UIImage *))completeBlock
{
    if (!queue) {
        queue = dispatch_get_main_queue();
    }
    __weak typeof(&*self) weakSelf = self;
    dispatch_async(queue, ^{
        UIImage *image = [weakSelf scaleToSize:size];
        if (completeBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completeBlock(image);
            });
        }
    });
}

@end
