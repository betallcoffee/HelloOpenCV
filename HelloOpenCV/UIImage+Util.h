//
//  UIImage+Util.h
//  HelloOpenCV
//
//  Created by liang on 6/13/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAsset;
@class ALAssetRepresentation;

@interface UIImage (Util)

+ (UIImage *)imageWithALAsset:(ALAsset *)asset;

+ (UIImage *)thumbImageWithALAsset:(ALAsset *)asset;

+ (UIImage *)thumbImageWithURL:(NSURL *)url maxPixelSize:(CGFloat)maxPixelSize;

- (UIImage *)scaleToSize:(CGSize)size;

@end
