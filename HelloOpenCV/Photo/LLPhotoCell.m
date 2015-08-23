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

@interface LLPhotoCell ()

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
    [self.contentView addSubview:self.imageView];
    self.imageView.frame = CGRectMake(0, 0, [LLPhotoCell size].width, [LLPhotoCell size].height);
    self.imageView.image = [UIImage thumbImageWithALAsset:model.asset];
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
