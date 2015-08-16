//
//  UIImage+CVBlend.m
//  HelloOpenCV
//
//  Created by liang on 1/16/15.
//  Copyright (c) 2015 Tina. All rights reserved.
// http://docs.opencv.org/doc/tutorials/core/adding_images/adding_images.html#adding-images

#import "UIImage+CVBlend.h"
#import "UIImage+CVMat.h"
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>

@implementation UIImage (CVBlend)

+ (NSNumber *)blendImageCount {
    return @(2);
}

+ (FilterImageBlock)blendImageBlock {
    return [^UIImage* (NSArray *images) {
        if (images.count > 1) {
            return [UIImage imageBlendImage:images[0] andImage:images[1] withBeta:0.5];
        } else {
            return nil;
        }
    } copy];
}

+ (UIImage *)imageBlend:(NSString *)imageName1 andImage:(NSString *)imageName2 withBeta:(float)beta {
    assert(beta < 1);
    cv::Mat cvMat1 = [[UIImage imageNamed:imageName1] CVMatFromImage];
    cv::Mat cvMat2 = [[UIImage imageNamed:imageName2] CVMatFromImage];
    cv::Mat dst(cvMat1.size(), cvMat1.type());
    float alpha = 1 - beta;
    // dst = src1*alpha + src2*beta + gamma;
    cv::addWeighted(cvMat1, alpha, cvMat2, beta, 0.0, dst);
    return [UIImage imageWithCVMat:dst];
}

+ (UIImage *)imageBlendImage:(UIImage *)image1 andImage:(UIImage *)image2 withBeta:(float)beta {
    assert(beta < 1);
    cv::Mat cvMat1 = [image1 CVMatFromImage];
    cv::Mat cvMat2 = [image2 CVMatFromImage];
    cv::Mat dst(cvMat1.size(), cvMat1.type());
    float alpha = 1 - beta;
    // dst = src1*alpha + src2*beta + gamma;
    cv::addWeighted(cvMat1, alpha, cvMat2, beta, 0.0, dst);
    return [UIImage imageWithCVMat:dst];
}

- (UIImage *)blendedImage:(UIImage *)image withBeta:(float)beta {
    return image;
}

- (void)blendWithImage:(UIImage *)image withBeta:(float)beta {
    
}

@end
