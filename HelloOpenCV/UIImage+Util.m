//
//  UIImage+Util.m
//  HelloOpenCV
//
//  Created by liang on 6/13/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>
#import "UIImage+Util.h"

@implementation UIImage (Util)

+ (UIImage *)imageWithALAsset:(ALAsset *)asset
{
    CGImageRef imageRef = [asset.defaultRepresentation fullScreenImage];
    return [UIImage imageWithCGImage:imageRef];
}

+ (UIImage *)thumbImageWithALAsset:(ALAsset *)asset {
    return [UIImage imageWithCGImage:asset.thumbnail];
}

+ (UIImage *)thumbImageWithURL:(NSURL *)url maxPixelSize:(CGFloat)maxPixelSize {
    // Create the image source (from path)
    CGImageSourceRef src = CGImageSourceCreateWithURL((__bridge_retained CFURLRef)url, NULL);
    
    // To create image source from UIImage, use this
//    NSData* pngData =  UIImagePNGRepresentation();
//    if (pngData == nil) {
//        return nil;
//    }
//    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)pngData, NULL);
    
    
    // Create thumbnail options
    CFDictionaryRef options = (__bridge_retained CFDictionaryRef) @{
                                                           (id) kCGImageSourceCreateThumbnailWithTransform : @YES,
                                                           (id) kCGImageSourceCreateThumbnailFromImageAlways : @YES,
                                                           (id) kCGImageSourceThumbnailMaxPixelSize : @(maxPixelSize)
                                                           };
    
    // Generate the thumbnail
    CGImageRef thumbnail = CGImageSourceCreateThumbnailAtIndex(src, 0, options);
    CFRelease(src);
    
    UIImage *image = [[UIImage alloc] initWithCGImage:thumbnail];
    CFRelease(thumbnail);
    return image;
}

- (UIImage *)scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
