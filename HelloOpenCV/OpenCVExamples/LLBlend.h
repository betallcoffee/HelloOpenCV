//
//  LLBlend.h
//  HelloOpenCV
//
//  Created by liang on 12/6/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLBlend : NSObject

/**
 @brief convenient method return a UIImage that blend imageName1*(1-beta) with imageName2*beta;
 Note: image size need same.
 */
+ (UIImage *)imageBlend:(NSString *)imageName1 andImage:(NSString *)imageName2 withBeta:(float)beta;

+ (UIImage *)imageBlendImage:(UIImage *)image1 andImage:(UIImage *)image2 withBeta:(float)beta;

@end
