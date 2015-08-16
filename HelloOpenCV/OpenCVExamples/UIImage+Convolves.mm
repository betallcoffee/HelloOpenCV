//
//  UIImage+Convolves.m
//  HelloOpenCV
//
//  Created by liang on 1/15/15.
//  Copyright (c) 2015 Tina. All rights reserved.
// http://docs.opencv.org/doc/tutorials/core/mat-mask-operations/mat-mask-operations.html#maskoperationsfilter

#include <opencv2/imgproc/imgproc.hpp>
#import "UIImage+Convolves.h"
#import "UIImage+CVMat.h"

@implementation UIImage (Convolves)

+ (NSNumber *)contrastEnhascementImageCount {
    return @(1);
}

+ (FilterImageBlock)contrastEnhancementImageBlock {
    return [^UIImage* (NSArray *images) {
        if (images.count > 0) {
            return [UIImage contrastEnhancementWithImage:images[0]];
        } else {
            return nil;
        }
    } copy];
}

+ (UIImage *)contrastEnhancementWithImage:(UIImage *)image
{
    cv::Mat cvMat = [image CVMatFromImage];
    [UIImage contrastEnhancement:cvMat];
    return [UIImage imageWithCVMat:cvMat];
}

+ (void)contrastEnhancement:(cv::Mat &)image {
    CV_Assert(image.depth() == CV_8U);
    cv::Mat imageMask(image.size(), image.type());
    const int nChannels = image.channels();
    
    for (int j = 1; j < image.rows - 1; j++) {
        const uchar *pre = image.ptr<uchar>(j - 1);
        const uchar *cur = image.ptr<uchar>(j);
        const uchar *next = image.ptr<uchar>(j + 1);
        
        uchar *out = imageMask.ptr<uchar>(j);
        for (int i = nChannels; i < nChannels * (image.cols - 1); i++) {
            *out = cv::saturate_cast<uchar>(5 * cur[i]-cur[i - nChannels] - cur[i + nChannels] - pre[i] - next[i]);
        }
    }
    
    imageMask.row(0).setTo(cv::Scalar(0));
    imageMask.row(imageMask.rows - 1).setTo(cv::Scalar(0));
    imageMask.col(0).setTo(cv::Scalar(0));
    imageMask.col(imageMask.cols - 1).setTo(cv::Scalar(0));
}

+(NSNumber *)filter2DImageCount {
    return @(1);
}

+ (FilterImageBlock)filter2DImageBlock {
    return [^UIImage* (NSArray *images) {
        if (images.count > 0) {
            return [UIImage filter2DWithImage:images[0]];
        } else {
            return nil;
        }
    } copy];
}

+ (UIImage *)filter2DWithImage:(UIImage *)image {
    cv::Mat cvMat = [image CVMatFromImage];
    [UIImage filter2D:cvMat];
    return [UIImage imageWithCVMat:cvMat];
}

+ (void)filter2D:(cv::Mat &)image {
    CV_Assert(image.depth() == CV_8U);
    cv::Mat kern = (cv::Mat_<char>(3,3) <<  0, -1,  0,
                    -1,  5, -1,
                    0, -1,  0);
    cv::filter2D(image, image, image.depth(), kern);
}

@end
