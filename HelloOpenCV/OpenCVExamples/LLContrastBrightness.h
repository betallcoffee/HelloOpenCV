//
//  LLContrastBrightness.h
//  HelloOpenCV
//
//  Created by liang on 12/6/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLContrastBrightness : NSObject

+ (UIImage *)contrastBrightness:(UIImage *)image alpha:(float)alpha beta:(float)beta;

@end
