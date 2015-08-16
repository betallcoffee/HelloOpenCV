//
//  UIImage+Convolves.h
//  HelloOpenCV
//
//  Created by liang on 1/15/15.
//  Copyright (c) 2015 Tina. All rights reserved.
// 

#import "LLPhotoFilter.h"

@interface UIImage (Convolves)

+ (NSNumber *)contrastEnhascementImageCount;

+ (FilterImageBlock)contrastEnhancementImageBlock;

+ (UIImage *)contrastEnhancementWithImage:(UIImage *)image;

+ (NSNumber *)filter2DImageCount;

+ (FilterImageBlock)filter2DImageBlock;

+ (UIImage *)filter2DWithImage:(UIImage *)image;

@end
