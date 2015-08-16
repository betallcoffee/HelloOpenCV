//
//  LLPhotoCell.h
//  HelloOpenCV
//
//  Created by liang on 6/13/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLPhotoModel;

@interface LLPhotoCell : UICollectionViewCell

+ (CGSize)size;

- (void)configCell:(LLPhotoModel *)model;
                    
@end
