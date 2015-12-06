//
//  LLContrastBrightness.m
//  HelloOpenCV
//
//  Created by liang on 12/6/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//  http://docs.opencv.org/2.4/doc/tutorials/core/basic_linear_transform/basic_linear_transform.html#basic-linear-transform

//
//Two commonly used point processes are multiplication and addition with a constant:
//
//g(x) = \alpha f(x) + \beta
//
//The parameters \alpha > 0 and \beta are often called the gain and bias parameters; sometimes these parameters are said to control contrast and brightness respectively.
//
//You can think of f(x) as the source image pixels and g(x) as the output image pixels. Then, more conveniently we can write the expression as:
//
//g(i,j) = \alpha \cdot f(i,j) + \beta
//
//where i and j indicates that the pixel is located in the i-th row and j-th column.
//
//Enter the alpha value [1.0-3.0]: 2.2
//* Enter the beta value [0-100]: 50


#import "UIImage+CVMat.h"
#import "LLContrastBrightness.h"

@implementation LLContrastBrightness

+ (UIImage *)contrastBrightness:(UIImage *)image alpha:(float)alpha beta:(float)beta
{
    cv::Mat cvMat = [image CVMatFromImage];
    cv::Mat newMat = cv::Mat::zeros(cvMat.size(), cvMat.type());
    
    /// Do the operation new_image(i,j) = alpha*image(i,j) + beta
    for (int y = 0; y < cvMat.rows; y++) {
        for (int x = 0; x < cvMat.cols; x++) {
            for (int c = 0; c < 3; c++) {
                newMat.at<cv::Vec3b>(y, x)[c] = cv::saturate_cast<uchar>(alpha * (cvMat.at<cv::Vec3b>(y, x)[c] + beta));
            }
        }
    }
    
    return [UIImage imageWithCVMat:newMat];
}

@end
