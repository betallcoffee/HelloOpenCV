//
//  LLBlend.m
//  HelloOpenCV
//
//  Created by liang on 12/6/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//  http://docs.opencv.org/doc/tutorials/core/adding_images/adding_images.html#adding-images

#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>

#import "UIImage+Util.h"
#import "UIImage+CVMat.h"

#import "LLBlend.h"

@implementation LLBlend


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

@end
