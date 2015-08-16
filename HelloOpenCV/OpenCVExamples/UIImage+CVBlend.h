//
//  UIImage+CVBlend.h
//  HelloOpenCV
//
//  Created by liang on 1/16/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPhotoFilter.h"

@interface UIImage (CVBlend)

+ (NSNumber *)blendImageCount;

+ (FilterImageBlock)blendImageBlock;

/**
 @brief convenient method return a UIImage that blend imageName1*(1-beta) with imageName2*beta;
 Note: image size need same.
 */
+ (UIImage *)imageBlend:(NSString *)imageName1 andImage:(NSString *)imageName2 withBeta:(float)beta;

/**
 @brief blend self*(1-beta) with image*beta, and return the result.
 */
- (UIImage *)blendedImage:(UIImage *)image withBeta:(float)beta;

/**
 @brief blend self*(1-beta) with image*beta, and restore to self.
 */
- (void)blendWithImage:(UIImage *)image withBeta:(float)beta;

@end