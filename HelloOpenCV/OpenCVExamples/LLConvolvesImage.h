//
//  LLConvolvesImage.h
//  HelloOpenCV
//
//  Created by liang on 1/15/15.
//  Copyright (c) 2015 Tina. All rights reserved.
// 

#include <opencv2/core/core.hpp>

#import <Foundation/Foundation.h>

@interface LLConvolvesImage : NSObject

+ (UIImage *)contrastEnhancementWithImage:(UIImage *)image;
+ (void)contrastEnhancement:(cv::Mat &)image;

+ (void)filter2D:(cv::Mat &)image;

@end
