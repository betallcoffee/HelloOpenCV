//
//  LLPhotoFilter.h
//  HelloOpenCV
//
//  Created by liang on 7/30/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef UIImage* (^FilterImageBlock)(NSArray *images);

@protocol LLPhotoFilter <NSObject>

@required
- (UIImage *)filterImage:(NSArray *)images;
- (NSInteger)imageCountOfFilter;

@end
