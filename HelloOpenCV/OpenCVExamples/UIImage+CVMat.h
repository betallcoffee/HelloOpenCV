//
//  UIImage+CVMat.h
//  HelloOpenCV
//
//  Created by liang on 1/16/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#include <opencv2/core/core.hpp>
#import <UIKit/UIKit.h>

@interface UIImage (CVMat)

+ (UIImage *)imageWithCVMat:(cv::Mat &)cvMat;
- (cv::Mat)CVMatFromImage;
- (UIImage *)grayImage;

@end
