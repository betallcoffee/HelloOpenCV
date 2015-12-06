//
//  LLMaskMatrices.m
//  HelloOpenCV
//
//  Created by liang on 11/11/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//   http://docs.opencv.org/doc/tutorials/core/mat-mask-operations/mat-mask-operations.html#maskoperationsfilter

#include <opencv2/imgproc/imgproc.hpp>

#import "UIImage+CVMat.h"
#import "LLMaskMatrices.h"

@implementation LLMaskMatrices

+ (UIImage *)contrastEnhancementWithImage:(UIImage *)image
{
    cv::Mat cvMat = [image CVMatFromImage];

    CV_Assert(cvMat.depth() == CV_8U);
    cv::Mat imageMask;
    imageMask.create(cvMat.size(), cvMat.type());
    const int nChannels = cvMat.channels();
    
    for (int j = 1; j < cvMat.rows - 1; j++) {
        const uchar *pre = cvMat.ptr<uchar>(j - 1);
        const uchar *cur = cvMat.ptr<uchar>(j);
        const uchar *next = cvMat.ptr<uchar>(j + 1);
        
        uchar *out = imageMask.ptr<uchar>(j);
        for (int i = nChannels; i < nChannels * (cvMat.cols - 1); i++) {
            *out = cv::saturate_cast<uchar>(5 * cur[i] - cur[i - nChannels] - cur[i + nChannels] - pre[i] - next[i]);
            out++;
        }
    }
    
    imageMask.row(0).setTo(cv::Scalar(0));
    imageMask.row(imageMask.rows - 1).setTo(cv::Scalar(0));
    imageMask.col(0).setTo(cv::Scalar(0));
    imageMask.col(imageMask.cols - 1).setTo(cv::Scalar(0));
    
    return [UIImage imageWithCVMat:imageMask];
}

+ (UIImage *)filter2DWithImage:(UIImage *)image
{
    cv::Mat cvMat = [image CVMatFromImage];

    CV_Assert(cvMat.depth() == CV_8U);
    cv::Mat kern = (cv::Mat_<char>(3,3) <<  0, -1,  0,
                    -1,  5, -1,
                    0, -1,  0);
    cv::filter2D(cvMat, cvMat, cvMat.depth(), kern);
    
    return [UIImage imageWithCVMat:cvMat];
}

@end
