//
//  UIImage+Util.h
//  HelloOpenCV
//
//  Created by liang on 6/13/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

+ (UIImage *)imageWithALAsset:(ALAssetRepresentation *)rep;

- (UIImage *)scaleToSize:(CGSize)size;

- (void)asycScaleToSize:(CGSize)size onDispatchQueue:(dispatch_queue_t)queue complete:(void (^)(UIImage *image))completeBlock;

@end
