//
//  LLMaskMatrices.h
//  HelloOpenCV
//
//  Created by liang on 11/11/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLMaskMatrices : NSObject

+ (UIImage *)contrastEnhancementWithImage:(UIImage *)image;

+ (UIImage *)filter2DWithImage:(UIImage *)image;

@end
