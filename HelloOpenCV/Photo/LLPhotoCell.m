//
//  LLPhotoCell.m
//  HelloOpenCV
//
//  Created by liang on 6/13/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "LLPhotoCell.h"
#import "LLPhotoModel.h"
#import "UIImage+Util.h"

static dispatch_queue_t imageQueue;

@interface LLPhotoCell ()

@property (nonatomic, strong) LLPhotoModel *model;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LLPhotoCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    self.imageView.frame = bounds;
}

- (void)prepareForReuse
{
    self.imageView.image = nil;
}

+ (CGSize)size
{
    return CGSizeMake(64, 64);
}

- (void)configCell:(LLPhotoModel *)model
{
    if (!imageQueue) {
        imageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    }
    self.model = model;
    [self.contentView addSubview:self.imageView];
    
    __weak typeof(&*self) weakSelf = self;
    dispatch_async(imageQueue, ^{
        CGImageRef imageRef = [weakSelf.model.rep fullScreenImage];
        if (imageRef) {
            [[UIImage imageWithCGImage:imageRef] asycScaleToSize:[LLPhotoCell size]
                                                 onDispatchQueue:imageQueue
                                                        complete:^(UIImage *image) {
                                                            weakSelf.imageView.image = image;
                                                            [weakSelf setNeedsDisplay];
                                                        }];
        }

    });
}

#pragma mark getter/setter
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

@end
